"""Tests for release-tag-based project versions using isolated git repositories."""

import contextlib
import io
import json
import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from update_version import git_version, main, update_version


class VersionTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.repo = Path(self.temporary.name)
        self.git("init", "--initial-branch=main")
        self.git("config", "user.name", "Version Tests")
        self.git("config", "user.email", "tests@example.invalid")
        self.git("config", "commit.gpgsign", "false")
        self.git("config", "tag.gpgsign", "false")
        self.commit()

    def git(self, *args):
        return subprocess.run(
            ["git", *args], cwd=self.repo, capture_output=True, text=True, check=True
        ).stdout.strip()

    def commit(self):
        self.git("commit", "--allow-empty", "-m", "Test commit")

    def test_exact_lightweight_tag(self):
        self.git("tag", "v0.1.2")
        self.assertEqual(git_version(self.repo), (0, 1, 2, 0))

    def test_annotated_tag_without_prefix_and_commit_distance(self):
        self.git("tag", "-a", "1.2.3", "-m", "Release")
        for _ in range(5):
            self.commit()
        self.assertEqual(git_version(self.repo), (1, 2, 3, 5))

    def test_nearest_tag_not_highest_version(self):
        self.git("tag", "v9.0.0")
        self.commit()
        self.git("tag", "v0.2.1")
        self.commit()
        self.assertEqual(git_version(self.repo), (0, 2, 1, 1))

    def test_unrelated_tags_are_ignored(self):
        self.git("tag", "v0.1.2")
        self.commit()
        for tag in ("snapshot", "v0.1.3-rc1", "v0.1.3.extra", "v0x1.3"):
            self.git("tag", tag)
        self.assertEqual(git_version(self.repo), (0, 1, 2, 1))

    def test_merge_counts_only_first_parent_and_ignores_side_branch_tag(self):
        self.git("tag", "v0.1.2")
        self.git("checkout", "-b", "feature")
        self.commit()
        self.commit()
        self.git("tag", "v9.0.0")
        self.git("checkout", "main")
        self.commit()
        self.git("merge", "--no-ff", "feature", "-m", "Merge feature")
        self.assertEqual(git_version(self.repo), (0, 1, 2, 2))

    def test_missing_release_tag(self):
        self.git("tag", "snapshot")
        with self.assertRaisesRegex(SystemExit, "no release tags found"):
            git_version(self.repo)

    def test_unreachable_release_tag(self):
        self.git("checkout", "-b", "feature")
        self.commit()
        self.git("tag", "v0.1.2")
        self.git("checkout", "main")
        with self.assertRaisesRegex(SystemExit, "no release tag is reachable"):
            git_version(self.repo)

    def test_shallow_history_is_rejected(self):
        self.git("tag", "v0.1.2")
        shallow = self.repo / "shallow"
        self.git("clone", "--depth=1", self.repo.as_uri(), str(shallow))
        with self.assertRaisesRegex(SystemExit, "full git history is required"):
            git_version(shallow)

    @staticmethod
    def project_data(version="(string)7.8.9.10"):
        return {
            "payload": {
                "meta": {"Graph": {"@Value": {"Name": "(string)Project Information"}}},
                "object": {
                    "Graph": {
                        "@Value": {
                            "Properties": {
                                "@Value": {"Version": {"@Value": {"Version": version}}}
                            }
                        }
                    }
                },
            }
        }

    def test_update_replaces_all_version_components(self):
        data = self.project_data()
        self.assertEqual(
            update_version(data, (0, 1, 2, 5)), ("7.8.9.10", "0.1.2.5")
        )
        self.assertEqual(
            data["payload"]["object"]["Graph"]["@Value"]["Properties"]["@Value"][
                "Version"
            ]["@Value"]["Version"],
            "(string)0.1.2.5",
        )

    def test_invalid_stored_version_is_rejected(self):
        with self.assertRaisesRegex(SystemExit, "unexpected version format"):
            update_version(self.project_data("(string)invalid"), (0, 1, 2, 5))

    def test_cli_dry_run_and_persistent_update(self):
        self.git("tag", "v0.1.2")
        version = git_version(self.repo)
        project = self.repo / "project"
        project.mkdir()
        path = project / "information.object"
        original = json.dumps(self.project_data())
        path.write_text(original, encoding="utf-8")
        with patch("update_version.git_version", return_value=version):
            with patch("sys.argv", ["update_version", str(project), "--dry-run"]):
                with contextlib.redirect_stdout(io.StringIO()) as output:
                    main()
                self.assertIn("would update", output.getvalue())
                self.assertEqual(path.read_text(encoding="utf-8"), original)
            with patch("sys.argv", ["update_version", str(project)]):
                with contextlib.redirect_stdout(io.StringIO()) as output:
                    main()
                self.assertIn("from 7.8.9.10 to 0.1.2.0", output.getvalue())
                self.assertEqual(
                    update_version(json.loads(path.read_text(encoding="utf-8")), version),
                    ("0.1.2.0", "0.1.2.0"),
                )
                with contextlib.redirect_stdout(io.StringIO()) as output:
                    main()
                self.assertIn("already at 0.1.2.0", output.getvalue())


if __name__ == "__main__":
    unittest.main()
