PYTHON=python

.PHONY: prettify-json

# Prettify *staged* JSON files in the project directory. Run `git config
# core.hooksPath .githooks` to enable the pre-commit hook for
# prettifying JSON files.
prettify-json:
	$(PYTHON) ./.githooks/prettify_json.py project
