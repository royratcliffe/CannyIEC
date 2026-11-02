"""Test release creation without publishing anything to GitHub."""

import contextlib
import io
import subprocess
import unittest
from pathlib import Path
from unittest.mock import patch

from create_release import main, project_version


def project_data(version="(string)0.2.0.42"):
    return {
        "payload": {
            "object": {
                "Graph": {
                    "@Value": {
                        "Properties": {
                            "@Value": {
                                "LibraryCategories": {
                                    "@Value": [{"Version": "(string)1.0.0.0"}]
                                },
                                "Version": {"@Value": {"Version": version}},
                            }
                        }
                    }
                }
            }
        }
    }


class ReleaseTests(unittest.TestCase):
    def setUp(self):
        self.repo = Path(__file__).resolve().parent.parent
        self.path = self.repo / "project" / "information.object"
        self.commit = "a" * 40
        self.remote = "https://github.com/example/library.git"
        self.status = ""
        self.tags = ""
        self.git_calls = []
        finder = patch(
            "create_release.find_project_information",
            return_value=(self.path, project_data()),
        )
        self.finder = finder.start()
        self.addCleanup(finder.stop)
        git = patch("create_release.run_git", side_effect=self.git)
        git.start()
        self.addCleanup(git.stop)
        gh = patch("create_release.subprocess.run")
        self.gh = gh.start()
        self.addCleanup(gh.stop)

    def git(self, args, cwd):
        self.assertEqual(cwd, self.repo)
        self.git_calls.append(args)
        if args == ["rev-parse", "HEAD"]:
            return self.commit
        if args == ["remote", "get-url", "origin"]:
            return self.remote
        if args == ["status", "--porcelain", "--untracked-files=all"]:
            return self.status
        if args[0] == "ls-files":
            self.assertEqual(
                args, ["ls-files", "--error-unmatch", "--",
                       str(self.path.relative_to(self.repo))]
            )
            return str(self.path)
        if args == ["ls-remote", "origin", "refs/tags/v0.2.0.42",
                    "refs/tags/v0.2.0.42^{}"]:
            return self.tags
        self.fail(f"Unexpected git command: {args}")

    def run_main(self, *args):
        with patch("sys.argv", ["create_release", *args]):
            with contextlib.redirect_stdout(io.StringIO()) as output:
                main()
        return output.getvalue()

    def test_reads_project_version_instead_of_category_version(self):
        self.assertEqual(project_version(project_data()), "0.2.0.42")

    def test_rejects_missing_version(self):
        with self.assertRaisesRegex(SystemExit, "could not locate Version"):
            project_version({})

    def test_rejects_malformed_versions(self):
        for value in (None, 42, "(string)0.2.0", "(string)0.2.0.42-rc1",
                      "(string)0.2.0.-1", "(string)0.2.0.42\n"):
            with self.subTest(value=value):
                with self.assertRaisesRegex(SystemExit, "invalid project version"):
                    project_version(project_data(value))

    def test_dry_run_does_not_contact_remote_or_require_clean_checkout(self):
        self.status = "?? scripts/create_release.py"
        output = self.run_main("--dry-run")
        self.assertIn("gh release create v0.2.0.42", output)
        self.assertIn(f"--target {self.commit}", output)
        self.assertIn(f"--repo {self.remote}", output)
        self.assertIn("--generate-notes", output)
        self.assertEqual(len(self.git_calls), 2)
        self.gh.assert_not_called()

    def test_creates_release_at_head_using_origin_and_stored_version(self):
        self.run_main()
        self.finder.assert_called_once_with(self.repo / "project")
        self.gh.assert_called_once_with(
            ["gh", "release", "create", "v0.2.0.42",
             "--repo", self.remote, "--target", self.commit,
             "--title", "v0.2.0.42", "--generate-notes"],
            cwd=self.repo, check=True,
        )

    def test_dirty_checkout_is_rejected(self):
        for status in (" M project/information.object", "?? new.object"):
            with self.subTest(status=status):
                self.status = status
                with self.assertRaisesRegex(SystemExit, "clean checkout"):
                    self.run_main()
                self.gh.assert_not_called()

    def test_existing_lightweight_tag_at_head_is_allowed(self):
        self.tags = f"{self.commit}\trefs/tags/v0.2.0.42"
        self.run_main()
        self.gh.assert_called_once()

    def test_existing_annotated_tag_uses_peeled_commit(self):
        self.tags = (
            f"{'b' * 40}\trefs/tags/v0.2.0.42\n"
            f"{self.commit}\trefs/tags/v0.2.0.42^{{}}"
        )
        self.run_main()
        self.gh.assert_called_once()

    def test_existing_tag_at_another_commit_is_rejected(self):
        self.tags = f"{'b' * 40}\trefs/tags/v0.2.0.42"
        with self.assertRaisesRegex(SystemExit, "does not point to HEAD"):
            self.run_main()
        self.gh.assert_not_called()

    def test_gh_failure_is_not_reported_as_success(self):
        self.gh.side_effect = subprocess.CalledProcessError(1, ["gh"])
        with self.assertRaises(subprocess.CalledProcessError):
            self.run_main()

    def test_git_failure_prevents_publishing(self):
        with patch(
            "create_release.run_git",
            side_effect=subprocess.CalledProcessError(1, ["git"]),
        ):
            with self.assertRaises(subprocess.CalledProcessError):
                self.run_main()
        self.gh.assert_not_called()


if __name__ == "__main__":
    unittest.main()
