.DEFAULT_GOAL := help
.PHONY: help run demo test formal
PYTHON ?= python3
LEAN ?= lean

help:
	@echo "spec -> model -> formal -> code -> tests -> demo"
	@echo "make run OUT=/tmp/tcpip-case-001"
	@echo "make formal FRAMEWORK=../Formal-Spec-Agent OUT=/tmp/tcpip-lean-proof"
	@echo "make demo"
	@echo "make test"

run:
	@test -n "$(OUT)" || (echo "Set OUT to a fresh output directory"; exit 2)
	$(PYTHON) code/build.py --out "$(OUT)" --run-example

formal:
	@test -n "$(OUT)" && test -n "$(FRAMEWORK)" || (echo "Set FRAMEWORK and a fresh OUT"; exit 2)
	$(PYTHON) formal/check.py --framework "$(FRAMEWORK)" --out "$(OUT)" --lean "$(LEAN)"

demo:
	$(PYTHON) demo/build_review.py

test:
	$(PYTHON) -m unittest discover -s tests -v
