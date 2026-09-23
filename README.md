# Canny IEC61131

CODESYS project workspace.

## Git Hooks

This repo ships a tracked pre-commit hook (`.githooks/pre-commit`) that
pretty-prints staged `.object` files, which CODESYS stores as minified JSON.
Git does not run tracked hooks automatically, so enable it once per clone:

```sh
git config core.hooksPath .githooks
```

The hook requires a `python3`/`python`/`py` interpreter on `PATH`; if none is
found it skips prettification without failing the commit.
