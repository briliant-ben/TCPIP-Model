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
