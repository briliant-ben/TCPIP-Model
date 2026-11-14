.DEFAULT_GOAL := help
.PHONY: help run demo test
PYTHON ?= python3

help:
	@echo "spec -> model -> formal -> code -> tests -> demo"
	@echo "make run OUT=/tmp/tcpip-case-001"
	@echo "make demo"
	@echo "make test"

run:
	@test -n "$(OUT)" || (echo "Set OUT to a fresh output directory"; exit 2)
	$(PYTHON) code/build.py --out "$(OUT)" --run-example

demo:
	$(PYTHON) demo/build_review.py

test:
	$(PYTHON) -m unittest discover -s tests -v
