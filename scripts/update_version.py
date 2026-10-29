#!/usr/bin/env python3
"""Update the project's version from a release tag and git history.

The Project Information object stores a version as ``Major.Minor.Patch.Build``
(e.g. ``0.1.2.5``). Major, minor and patch come from the nearest release tag
on HEAD's first-parent history, named ``vMajor.Minor.Patch`` or
``Major.Minor.Patch``. Build counts first-parent commits since that tag;
the tagged commit itself has build zero.

Full history and a reachable release tag are required. No branch reference
or working-tree changes contribute to the numeric version.
"""

import argparse
import json
import re
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


def git_version(cwd):
    """Return (major, minor, patch, build) using the nearest release tag."""
    if run_git(["rev-parse", "--is-shallow-repository"], cwd) == "true":
        raise SystemExit(
            "update_version: full git history is required; fetch with --unshallow --tags"
        )

    # Find the nearest release tag reachable from HEAD along the
    # first-parent history. It must match the pattern vMajor.Minor.Patch
    # or Major.Minor.Patch.
    tags = run_git(["tag", "--list"], cwd).splitlines()
    release_tags = [
        tag for tag in tags if re.fullmatch(r"v?[0-9]+\.[0-9]+\.[0-9]+", tag)
    ]
    if not release_tags:
        raise SystemExit(
            "update_version: no release tags found; create a tag such as v0.1.0"
        )

    # Prepare the --match arguments for "git describe" to limit to release tags.
    matches = [argument for tag in release_tags for argument in ("--match", tag)]
    try:
        tag = run_git(
            ["describe", "--tags", "--first-parent", "--abbrev=0", *matches, "HEAD"],
            cwd,
        )
    except subprocess.CalledProcessError as error:
        raise SystemExit(
            "update_version: no release tag is reachable on HEAD's first-parent history"
        ) from error

    # Extract the numeric components from the tag.
    major, minor, patch = (int(part) for part in tag.removeprefix("v").split("."))
    build = int(
        run_git(["rev-list", "--count", "--first-parent", f"{tag}..HEAD"], cwd)
    )
    return major, minor, patch, build


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


def update_version(data, version):
    """Replace the stored version with the four git-derived components."""
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

    new_version = ".".join(str(part) for part in version)
    version_container["Version"] = STRING_PREFIX + new_version
    return old_version, new_version


def main():
    """Update the project's version using the nearest release tag as a baseline.

    Usage:
        python scripts/update_version.py [root] [--dry-run]
    """
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "root", nargs="?", default=DEFAULT_ROOT, help="project object directory"
    )
    parser.add_argument(
        "--dry-run", action="store_true", help="report the update without writing"
    )
    args = parser.parse_args()

    root = Path(args.root)
    repo_root = Path(__file__).resolve().parent.parent

    version = git_version(repo_root)
    path, data = find_project_information(root)
    old_version, new_version = update_version(data, version)

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
