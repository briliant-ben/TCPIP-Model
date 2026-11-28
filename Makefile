.DEFAULT_GOAL := help
.PHONY: help run live formal demo test stack-build stack-test stack-asan stack-tsan stack-demo stack-bench stack-regen stack-formal clean

PYTHON ?= python3
LEAN ?= lean
CC ?= cc
OUT ?= /tmp/tcpip-stack-out

CFLAGS_STACK := -std=c99 -Wall -Wextra -Werror -Wsign-compare -Wtype-limits -I code -I code/generated/stack

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  ASAN_ENV := ASAN_OPTIONS=symbolize=0:detect_leaks=0 UBSAN_OPTIONS=print_stacktrace=0
  TSAN_ENV := TSAN_OPTIONS=symbolize=0
else
  ASAN_ENV := ASAN_OPTIONS=detect_leaks=0 UBSAN_OPTIONS=print_stacktrace=1
  TSAN_ENV :=
endif

help:
	@echo "v1 minimal single-endpoint prototype targets:"
	@echo "  make test"
	@echo "  make run OUT=/tmp/tcpip-case-001"
	@echo "  make live OUT=/tmp/tcpip-live-001"
	@echo "  make formal FRAMEWORK=../Formal-Spec-Agent LEAN=$(LEAN) OUT=/tmp/tcpip-lean-proof"
	@echo "  make demo"
	@echo ""
	@echo "10-module generated C99 TCP/IPv4 stack targets (out-of-tree OUT=$(OUT)):"
	@echo "  make stack-build  OUT=/tmp/tcpip-stack-out"
	@echo "  make stack-test   OUT=/tmp/tcpip-stack-out"
	@echo "  make stack-asan   OUT=/tmp/tcpip-stack-out"
	@echo "  make stack-tsan   OUT=/tmp/tcpip-stack-out"
	@echo "  make stack-demo   OUT=/tmp/tcpip-stack-out"
	@echo "  make stack-bench  OUT=/tmp/tcpip-stack-out"
	@echo "  make stack-regen  FRAMEWORK=../Formal-Spec-Agent"
	@echo "  make stack-formal FRAMEWORK=../Formal-Spec-Agent LEAN=$(LEAN) OUT=/tmp/tcpip-stack-out"

run:
	@test -n "$(OUT)" || (echo "Set OUT to a fresh output directory"; exit 2)
	$(PYTHON) code/build.py --out "$(OUT)" --run-example

live:
	@test -n "$(OUT)" || (echo "Set OUT to a fresh output directory"; exit 2)
	$(PYTHON) demo/live_demo.py --out "$(OUT)"

formal:
	@test -n "$(OUT)" && test -n "$(FRAMEWORK)" || (echo "Set FRAMEWORK and a fresh OUT"; exit 2)
	$(PYTHON) formal/check.py --framework "$(FRAMEWORK)" --out "$(OUT)" --lean "$(LEAN)"

demo:
	$(PYTHON) demo/build_review.py

test:
	$(PYTHON) -m unittest discover -s tests -v

stack-build:
	rm -rf "$(OUT)/build"
	$(PYTHON) code/build_stack.py --cc "$(CC)" --out "$(OUT)/build" --run-size-check --check-freertos

stack-test:
	rm -rf "$(OUT)/test-fast" "$(OUT)/test-strict"
	$(PYTHON) code/build_stack.py --cc "$(CC)" --out "$(OUT)/test-fast" --run-size-check --check-freertos
	$(PYTHON) code/build_stack.py --cc "$(CC)" --out "$(OUT)/test-strict" --extra-cflags="-DFSA_STRICT=1" --check-freertos
	$(CC) $(CFLAGS_STACK) -O2 -DFSA_HOST_NO_SYS=1 tests/stack_suite.c "$(OUT)/test-fast/libtcpip_stack_nosys.a" -o "$(OUT)/test-fast/suite_nosys"
	$(CC) $(CFLAGS_STACK) -O2 -DFSA_HOST_NO_SYS=0 -pthread tests/stack_suite.c "$(OUT)/test-fast/libtcpip_stack_posix.a" -o "$(OUT)/test-fast/suite_posix"
	$(CC) $(CFLAGS_STACK) -O2 -DFSA_STRICT=1 -DFSA_HOST_NO_SYS=1 tests/stack_suite.c "$(OUT)/test-strict/libtcpip_stack_nosys.a" -o "$(OUT)/test-strict/suite_nosys_strict"
	$(CC) $(CFLAGS_STACK) -O2 -DFSA_STRICT=1 -DFSA_HOST_NO_SYS=0 -pthread tests/stack_suite.c "$(OUT)/test-strict/libtcpip_stack_posix.a" -o "$(OUT)/test-strict/suite_posix_strict"
	"$(OUT)/test-fast/suite_nosys"
	"$(OUT)/test-fast/suite_posix"
	"$(OUT)/test-strict/suite_nosys_strict"
	"$(OUT)/test-strict/suite_posix_strict"

stack-asan:
	rm -rf "$(OUT)/asan"
	$(PYTHON) code/build_stack.py --cc "$(CC)" --out "$(OUT)/asan" --opt=-O1 --extra-cflags="-g -DFSA_STRICT=1 -fsanitize=address,undefined -fno-omit-frame-pointer"
	$(CC) $(CFLAGS_STACK) -O1 -g -DFSA_STRICT=1 -fsanitize=address,undefined -fno-omit-frame-pointer -DFSA_HOST_NO_SYS=0 -pthread tests/stack_suite.c "$(OUT)/asan/libtcpip_stack_posix.a" -o "$(OUT)/asan/suite_asan"
	$(ASAN_ENV) "$(OUT)/asan/suite_asan"

stack-tsan:
	rm -rf "$(OUT)/tsan"
	$(PYTHON) code/build_stack.py --cc "$(CC)" --out "$(OUT)/tsan" --opt=-O1 --extra-cflags="-g -fsanitize=thread -fno-omit-frame-pointer"
	$(CC) $(CFLAGS_STACK) -O1 -g -fsanitize=thread -fno-omit-frame-pointer -DFSA_HOST_NO_SYS=0 -pthread tests/stack_suite.c "$(OUT)/tsan/libtcpip_stack_posix.a" -o "$(OUT)/tsan/suite_tsan"
	$(TSAN_ENV) "$(OUT)/tsan/suite_tsan"

stack-demo:
	rm -rf "$(OUT)/demo"
	CC="$(CC)" $(PYTHON) demo/stack_demo.py --out "$(OUT)/demo"

stack-bench:
	rm -rf "$(OUT)/bench"
	$(PYTHON) code/build_stack.py --cc "$(CC)" --out "$(OUT)/bench" --opt=-O2
	$(CC) $(CFLAGS_STACK) -O2 -DFSA_HOST_NO_SYS=1 demo/stack_bench.c "$(OUT)/bench/libtcpip_stack_nosys.a" -o "$(OUT)/bench/stack_bench"
	"$(OUT)/bench/stack_bench"

stack-regen:
	@test -n "$(FRAMEWORK)" || (echo "Set FRAMEWORK to Formal-Spec-Agent path"; exit 2)
	$(PYTHON) code/regenerate_stack.py --framework "$(FRAMEWORK)" --python "$(PYTHON)" --verify

stack-formal:
	@test -n "$(FRAMEWORK)" || (echo "Set FRAMEWORK to Formal-Spec-Agent path"; exit 2)
	rm -rf "$(OUT)/formal"
	$(PYTHON) formal/stack/check_stack.py --framework "$(FRAMEWORK)" --lean "$(LEAN)" --out "$(OUT)/formal"

clean:
	rm -rf "$(OUT)"
