PYTHON=python

.PHONY: prettify-json

prettify-json:
	$(PYTHON) ./.githooks/prettify_json.py project
