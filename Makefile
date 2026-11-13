.DEFAULT_GOAL := help
.PHONY: help showcase generate demo test-showcase

help:
	@echo "TCPIP-Model: a Formal-Spec-Agent case study"
	@echo "Read spec/ -> model/ -> formal/ -> code/ -> tests/ -> demo/"
	@echo "make generate PYTHON=.venv/bin/python OUT=/tmp/tcpip-code-001"
	@echo "make demo PYTHON=.venv/bin/python"
	@echo "make test-showcase PYTHON=.venv/bin/python"
	@echo "Other targets below retain historical compatibility commands."

generate:
	@test -n "$(OUT)" || (echo "Set OUT to a fresh directory outside this repository"; exit 2)
	$(PYTHON) code/build.py --out "$(OUT)" --run-example

demo:
	$(PYTHON) demo/build_review.py

test-showcase:
	$(PYTHON) -m unittest discover -s tests -p test_showcase.py -v

showcase: test-showcase demo

.PHONY: test build validate formal assess suite suite-verify lwip lwip-verify

PYTHON ?= python3

test:
	$(PYTHON) -m unittest discover -s tests -v

build:
	$(PYTHON) -m protocol_lab build

validate:
	$(PYTHON) -m protocol_lab validate

formal:
	$(PYTHON) -m protocol_lab formal

assess:
	$(PYTHON) -m protocol_lab assess

suite:
	$(PYTHON) -m protocol_lab suite --formal

suite-verify:
	$(PYTHON) -m protocol_lab suite-verify

lwip:
	$(PYTHON) -m protocol_lab lwip

lwip-verify:
	$(PYTHON) -m protocol_lab lwip-verify
