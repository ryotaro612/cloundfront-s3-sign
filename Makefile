.PHONY: help clean install


VENV ?= venv
help: ## Display this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: cloudfront_s3_sign.egg-info/requires.txt ## Install the dependencies

PROJECT_ROOT := $(dir $(lastword $(MAKEFILE_LIST)))
clean: ## Clean the intermediate files
	rm -rf $(PROJECT_ROOT)$(VENV)

cloudfront_s3_sign.egg-info/requires.txt: pyproject.toml $(VENV)/bin/activate
	pip install -e .[dev]

$(VENV)/bin/activate:
	python -m venv $(VENV)

