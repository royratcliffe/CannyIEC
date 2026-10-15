#!/usr/bin/env python3
"""Update the project's version patch and build numbers from Git history.

The Project Information object stores a version as ``Major.Minor.Patch.Build``
(e.g. ``0.1.0.0``). This script preserves ``Major.Minor`` and replaces:

- ``Patch`` with the number of first-parent commits reachable from the selected
  main branch.
- ``Build`` with the number of first-parent commits in ``main_branch..HEAD``.

If ``--main-branch`` is omitted, the first existing ref among ``main``,
``master``, ``origin/main``, and ``origin/master`` is used. The Git repository
is the repository containing this script. The optional positional ``root``
only controls where the Project Information object is searched for.

Use ``--dry-run`` to report the proposed version without writing the object
file. The ``Major.Minor`` components are retained from the existing version.
"""

import argparse
import json
import subprocess
import sys
from pathlib import Path

from st import STRING_PREFIX, DEFAULT_ROOT, unwrap_string


def run_git(args, cwd):
    """Run a git command and return its trimmed stdout."""
    result = subprocess.run(
        ["git", *args], cwd=cwd, capture_output=True, text=True, check=True
    )
    return result.stdout.strip()


def find_main_branch(cwd):
    """Return the first existing candidate for the repository's main branch."""
    for candidate in ("main", "master", "origin/main", "origin/master"):
        try:
            run_git(["rev-parse", "--verify", "--quiet", candidate], cwd)
        except subprocess.CalledProcessError:
            continue
        return candidate
    raise SystemExit("update_version: no main or master branch found")


def git_patch_and_build(cwd, main_branch=None):
    """Return (patch, build) numbers derived from the git history."""
    # Only consider the first-parent history to avoid counting commits
    # from merged branches multiple times.
    branch = main_branch or find_main_branch(cwd)
    patch = int(run_git(["rev-list", "--count", "--first-parent", branch], cwd))
    build = int(
        run_git(["rev-list", "--count", "--first-parent", f"{branch}..HEAD"], cwd)
    )
    return patch, build


def find_project_information(root):
    """Locate the Project Information object file under ``root``."""
    for path in sorted(root.rglob("*.object")):
        try:
            with path.open("r", encoding="utf-8-sig") as file:
                data = json.load(file)
        except (json.JSONDecodeError, OSError):
            continue
        name = unwrap_string(
            data.get("payload", {})
            .get("meta", {})
            .get("Graph", {})
            .get("@Value", {})
            .get("Name")
        )
        if name == "Project Information":
            return path, data
    raise SystemExit(
        f"update_version: no Project Information object found under {root}"
    )


def update_version(data, patch, build):
    """Replace the patch and build components of the stored version string."""
    try:
        version_container = data["payload"]["object"]["Graph"]["@Value"]["Properties"][
            "@Value"
        ]["Version"]["@Value"]
    except (KeyError, TypeError) as error:
        raise SystemExit("update_version: could not locate Version property") from error

    old_version = unwrap_string(version_container.get("Version"))
    if not isinstance(old_version, str):
        raise SystemExit("update_version: Version property is not a string")

    parts = old_version.split(".")
    if len(parts) != 4:
        raise SystemExit(f"update_version: unexpected version format: {old_version}")

    parts[2] = str(patch)
    parts[3] = str(build)
    new_version = ".".join(parts)
    version_container["Version"] = STRING_PREFIX + new_version
    return old_version, new_version


def main():
    """Update the Project Information version using first-parent Git counts.

    The patch is the selected base ref's first-parent commit count; the build is
    the first-parent commit count in ``base..HEAD``. The optional ``root``
    positional argument selects where to find the object file, not the Git
    repository used for these counts.

    Usage:
        python scripts/update_version.py [root] [--main-branch MAIN_BRANCH] [--dry-run]
    """
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "root", nargs="?", default=DEFAULT_ROOT, help="project object directory"
    )
    parser.add_argument(
        "--main-branch", help="main branch name (auto-detected if omitted)"
    )
    parser.add_argument(
        "--dry-run", action="store_true", help="report the update without writing"
    )
    args = parser.parse_args()

    root = Path(args.root)
    repo_root = Path(__file__).resolve().parent.parent

    patch, build = git_patch_and_build(repo_root, args.main_branch)
    path, data = find_project_information(root)
    old_version, new_version = update_version(data, patch, build)

    if old_version == new_version:
        print(f"update_version: {path} already at {new_version}")
        return

    if not args.dry_run:
        path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")

    action = "would update" if args.dry_run else "updated"
    print(f"update_version: {action} {path} from {old_version} to {new_version}")


if __name__ == "__main__":
    try:
        main()
    except subprocess.CalledProcessError as error:
        sys.exit(f"update_version: git command failed: {error}")
