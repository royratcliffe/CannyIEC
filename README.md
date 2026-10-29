# Canny IEC61131

CODESYS project workspace.

## Git Hooks

This repo ships a tracked pre-commit hook (`scripts/pre-commit`) that
pretty-prints staged `.object` files, which CODESYS stores as minified JSON.
Git does not run tracked hooks automatically, so enable it once per clone:

```sh
git config core.hooksPath scripts
```

The hook requires a `python3`/`python`/`py` interpreter on `PATH`; if none is
found it skips prettification without failing the commit.

## Project Version

`python scripts/update_version.py` updates the Project Information version as
`Major.Minor.Patch.Build`. Use `--dry-run` to preview without writing.

- Major, minor and patch come from the nearest release tag on HEAD's
  first-parent history, named `v0.1.2` or `0.1.2`.
- Build is the number of first-parent commits since that tag: the tag itself
  produces `0.1.2.0`, and five subsequent commits produce `0.1.2.5`.
- Other tag formats and tags on merged side branches are ignored. To begin a
  new patch cycle, explicitly create a new release tag.
- Full history and tags are required in build checkouts; shallow history or a
  missing baseline causes an error. Branch names do not affect the version.
- Uncommitted changes do not affect the number. Use a clean checkout for
  releases and record the Git SHA alongside build artifacts for traceability.

The script does not create tags. For an initial `0.1.0` baseline at the current
commit, run `git tag v0.1.0` explicitly.

Run the versioning tests with `python -m unittest discover -s scripts -p "test_*.py"`.
