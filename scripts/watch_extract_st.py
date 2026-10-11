#!/usr/bin/env python3
"""Watch CODESYS .object files and refresh their extracted Structured Text."""

import argparse
import subprocess
import sys
import time
from pathlib import Path

from st import DEFAULT_ROOT, DEFAULT_ST


def snapshot_objects(root):
    """Return the modification time and size of each project object."""
    snapshots = {}
    for path in root.rglob("*.object"):
        try:
            stat = path.stat()
        except FileNotFoundError:
            continue
        snapshots[path] = (stat.st_mtime_ns, stat.st_size)
    return snapshots


def run_extraction(root, output_dir):
    """Run the extractor and report a failure without stopping the watcher."""
    script = Path(__file__).with_name("extract_st.py")
    result = subprocess.run(
        [sys.executable, str(script), str(root), "--output-dir", str(output_dir)],
        check=False,
    )
    if result.returncode:
        print(
            f"watch_extract_st: extraction failed with exit code {result.returncode}",
            file=sys.stderr,
        )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "root",
        nargs="?",
        default=DEFAULT_ROOT,
        help="directory to watch for .object files",
    )
    parser.add_argument(
        "-o",
        "--output-dir",
        default=DEFAULT_ST,
        help="directory to write extracted .st files to",
    )
    parser.add_argument(
        "--poll-interval",
        type=float,
        default=0.5,
        help="seconds between checks for project changes",
    )
    parser.add_argument(
        "--debounce",
        type=float,
        default=1.0,
        help="quiet period in seconds before extraction starts",
    )
    args = parser.parse_args()
    if args.poll_interval <= 0 or args.debounce < 0:
        parser.error(
            "--poll-interval must be positive and --debounce cannot be negative"
        )

    root = Path(args.root)
    output_dir = Path(args.output_dir)
    snapshots = snapshot_objects(root)
    print(f"watch_extract_st: starting extraction from {root}", flush=True)
    run_extraction(root, output_dir)
    print(f"watch_extract_st: watching {root} for .object changes", flush=True)

    last_change = None
    try:
        while True:
            time.sleep(args.poll_interval)
            current = snapshot_objects(root)
            if current != snapshots:
                snapshots = current
                last_change = time.monotonic()
                print("watch_extract_st: detected project changes", flush=True)
            elif (
                last_change is not None
                and time.monotonic() - last_change >= args.debounce
            ):
                run_extraction(root, output_dir)
                last_change = None
    except KeyboardInterrupt:
        print("\nwatch_extract_st: stopped", flush=True)


if __name__ == "__main__":
    main()
