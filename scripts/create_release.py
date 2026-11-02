#!/usr/bin/env python3
"""Create a GitHub release from the stored Project Information version."""

import argparse
import re
import subprocess
import sys
from pathlib import Path

from st import DEFAULT_ROOT, unwrap_string
from update_version import find_project_information, run_git


def project_version(data):
    """Read the project version, not a nested library category version."""
    try:
        version = unwrap_string(
            data["payload"]["object"]["Graph"]["@Value"]["Properties"]["@Value"][
                "Version"
            ]["@Value"]["Version"]
        )
    except (KeyError, TypeError) as error:
        raise SystemExit("create_release: could not locate Version property") from error
    if not isinstance(version, str) or not re.fullmatch(
        r"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+", version
    ):
        raise SystemExit(f"create_release: invalid project version: {version!r}")
    return version


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--dry-run", action="store_true", help="preview without contacting GitHub"
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parent.parent
    path, data = find_project_information(repo_root / DEFAULT_ROOT)
    tag = f"v{project_version(data)}"
    commit = run_git(["rev-parse", "HEAD"], repo_root)
    remote = run_git(["remote", "get-url", "origin"], repo_root)
    command = [
        "gh", "release", "create", tag,
        "--repo", remote,
        "--target", commit,
        "--title", tag,
        "--generate-notes",
    ]

    if args.dry_run:
        print(f"create_release: version from {path}")
        print(f"create_release: would run {subprocess.list2cmdline(command)}")
        return

    if run_git(["status", "--porcelain", "--untracked-files=all"], repo_root):
        raise SystemExit("create_release: a clean checkout is required")
    run_git(
        ["ls-files", "--error-unmatch", "--", str(path.relative_to(repo_root))],
        repo_root,
    )
    ref = f"refs/tags/{tag}"
    remote_tags = run_git(["ls-remote", "origin", ref, f"{ref}^{{}}"], repo_root)
    tags = dict(line.split()[::-1] for line in remote_tags.splitlines())
    target = tags.get(f"{ref}^{{}}", tags.get(ref))
    if target is not None and target != commit:
        raise SystemExit(f"create_release: remote tag {tag} does not point to HEAD")

    subprocess.run(command, cwd=repo_root, check=True)


if __name__ == "__main__":
    try:
        main()
    except subprocess.CalledProcessError as error:
        sys.exit(f"create_release: command failed: {error}\n{error.stderr or ''}")
    except OSError as error:
        sys.exit(f"create_release: {error}")
