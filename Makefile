.DEFAULT_GOAL := help
.PHONY: help run live formal demo test lib size test-lib test-asan test-tsan demos bench regen-lib formal-lib clean
PYTHON ?= python3
LEAN ?= lean
CC ?= cc

CFLAGS_WARN := -std=c99 -Wall -Wextra -Werror
CFLAGS_OPT  := $(CFLAGS_WARN) -Os -ffunction-sections -fdata-sections -I include
CFLAGS_TEST := $(CFLAGS_WARN) -O2 -I include -I src/generated
CFLAGS_ASAN := $(CFLAGS_WARN) -O2 -g -fsanitize=address,undefined -fno-omit-frame-pointer -I include -I src/generated
CFLAGS_TSAN := $(CFLAGS_WARN) -O2 -g -fsanitize=thread -fno-omit-frame-pointer -I include -I src/generated

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  SAN_ENV := ASAN_OPTIONS=symbolize=0 TSAN_OPTIONS=symbolize=0
else
  SAN_ENV :=
endif

CORE_SRCS := \
	src/core/memp.c \
	src/core/pbuf.c \
	src/core/pcap.c \
	src/core/tcpip.c \
	src/core/inet_chksum.c \
	src/core/netif.c \
	src/core/etharp.c \
	src/core/ip4.c \
	src/core/ip4_frag.c \
	src/core/icmp.c \
	src/core/udp.c \
	src/core/tcp.c \
	src/core/tcp_in.c \
	src/core/tcp_out.c

M4_SRCS := \
	src/core/dhcp.c \
	src/core/dns.c \
	src/api/netconn.c \
	src/api/sockets.c

GEN_SRCS := \
	src/generated/sys_port_fsm.c \
	src/generated/pbuf_fsm.c \
	src/generated/actor_fsm.c \
	src/generated/arp_fsm.c \
	src/generated/ip_reass_fsm.c \
	src/generated/tcp_fsm.c \
	src/generated/dhcp_fsm.c \
	src/generated/dns_fsm.c

NOSYS_LIB_SRCS := $(CORE_SRCS) port/nosys/sys_port.c
POSIX_LIB_SRCS := $(CORE_SRCS) $(M4_SRCS) port/posix/sys_port.c
ALL_STACK_SRCS := $(CORE_SRCS) $(M4_SRCS)

help:
	@echo "v1 minimal prototype targets:"
	@echo "  make run OUT=/tmp/tcpip-case-001"
	@echo "  make live OUT=/tmp/tcpip-live-001"
	@echo "  make formal FRAMEWORK=../Formal-Spec-Agent OUT=/tmp/tcpip-lean-proof"
	@echo "  make demo"
	@echo "  make test"
	@echo ""
	@echo "v2 libtcpip targets:"
	@echo "  make lib         - build build/libtcpip_nosys.a and build/libtcpip_posix.a (-Os)"
	@echo "  make size        - measure .text/.data/.bss and enforce <= 90 KiB core L2-L4 .text"
	@echo "  make test-lib    - run M1-M4 stack verification suites (NO_SYS=1 & NO_SYS=0)"
	@echo "  make test-asan   - run M1-M4 suites with ASan + UBSan"
	@echo "  make test-tsan   - run M1, M3, M4 suites with ThreadSanitizer"
	@echo "  make demos       - run BSD sockets tcp_echo_demo & dhcp_dns_demo (.pcap)"
	@echo "  make bench       - run checksum/UDP/TCP throughput & RTT microbenchmarks"
	@echo "  make regen-lib FRAMEWORK=../Formal-Spec-Agent"
	@echo "  make formal-lib FRAMEWORK=../Formal-Spec-Agent LEAN=$(LEAN)"

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

lib: build/libtcpip_nosys.a build/libtcpip_posix.a

build/libtcpip_nosys.a: $(NOSYS_LIB_SRCS) include/tcpip/*.h
	@rm -rf build/obj_nosys && mkdir -p build/obj_nosys
	@for src in $(NOSYS_LIB_SRCS); do \
		obj="build/obj_nosys/$$(basename $${src%.c}).o"; \
		$(CC) $(CFLAGS_OPT) -DTCPIP_NO_SYS=1 -DTCPIP_VERIFY_FSM=0 -c "$$src" -o "$$obj" || exit 1; \
	done
	ar rcs $@ build/obj_nosys/*.o

build/libtcpip_posix.a: $(POSIX_LIB_SRCS) include/tcpip/*.h
	@rm -rf build/obj_posix && mkdir -p build/obj_posix
	@for src in $(POSIX_LIB_SRCS); do \
		obj="build/obj_posix/$$(basename $${src%.c}).o"; \
		$(CC) $(CFLAGS_OPT) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=0 -c "$$src" -o "$$obj" || exit 1; \
	done
	ar rcs $@ build/obj_posix/*.o

size: lib
	@$(PYTHON) scripts/check_size.py

test-lib:
	@mkdir -p build
	$(CC) $(CFLAGS_TEST) -DTCPIP_NO_SYS=1 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/nosys/sys_port.c tests/lib/test_m1_arch.c -o build/test_m1_nosys
	$(CC) $(CFLAGS_TEST) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c tests/lib/test_m1_arch.c -lpthread -o build/test_m1_posix
	$(CC) $(CFLAGS_TEST) -DTCPIP_NO_SYS=1 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/nosys/sys_port.c port/posix/netif_veth.c tests/lib/test_m2_l2l3.c -o build/test_m2_nosys
	$(CC) $(CFLAGS_TEST) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m2_l2l3.c -lpthread -o build/test_m2_posix
	$(CC) $(CFLAGS_TEST) -DTCPIP_NO_SYS=1 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/nosys/sys_port.c port/posix/netif_veth.c tests/lib/test_m3_tcp_udp.c -o build/test_m3_nosys
	$(CC) $(CFLAGS_TEST) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m3_tcp_udp.c -lpthread -o build/test_m3_posix
	$(CC) $(CFLAGS_TEST) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(ALL_STACK_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m4_api_dhcp_dns.c -lpthread -o build/test_m4_posix
	./build/test_m1_nosys
	./build/test_m1_posix
	./build/test_m2_nosys
	./build/test_m2_posix
	./build/test_m3_nosys
	./build/test_m3_posix
	./build/test_m4_posix

test-asan:
	@mkdir -p build
	$(CC) $(CFLAGS_ASAN) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c tests/lib/test_m1_arch.c -lpthread -o build/test_m1_asan
	$(CC) $(CFLAGS_ASAN) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m2_l2l3.c -lpthread -o build/test_m2_asan
	$(CC) $(CFLAGS_ASAN) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m3_tcp_udp.c -lpthread -o build/test_m3_asan
	$(CC) $(CFLAGS_ASAN) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(ALL_STACK_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m4_api_dhcp_dns.c -lpthread -o build/test_m4_asan
	$(SAN_ENV) ./build/test_m1_asan
	$(SAN_ENV) ./build/test_m2_asan
	$(SAN_ENV) ./build/test_m3_asan
	$(SAN_ENV) ./build/test_m4_asan

test-tsan:
	@mkdir -p build
	$(CC) $(CFLAGS_TSAN) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c tests/lib/test_m1_arch.c -lpthread -o build/test_m1_tsan
	$(CC) $(CFLAGS_TSAN) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(CORE_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m3_tcp_udp.c -lpthread -o build/test_m3_tsan
	$(CC) $(CFLAGS_TSAN) -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=1 $(ALL_STACK_SRCS) $(GEN_SRCS) port/posix/sys_port.c port/posix/netif_veth.c tests/lib/test_m4_api_dhcp_dns.c -lpthread -o build/test_m4_tsan
	$(SAN_ENV) ./build/test_m1_tsan
	$(SAN_ENV) ./build/test_m3_tsan
	$(SAN_ENV) ./build/test_m4_tsan

demos: lib
	@mkdir -p build
	$(CC) $(CFLAGS_WARN) -O2 -I include -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=0 examples/tcp_echo_demo.c port/posix/netif_veth.c build/libtcpip_posix.a -lpthread -o build/tcp_echo_demo
	$(CC) $(CFLAGS_WARN) -O2 -I include -DTCPIP_NO_SYS=0 -DTCPIP_VERIFY_FSM=0 examples/dhcp_dns_demo.c port/posix/netif_veth.c build/libtcpip_posix.a -lpthread -o build/dhcp_dns_demo
	./build/tcp_echo_demo
	./build/dhcp_dns_demo

bench: lib
	@mkdir -p build
	$(CC) $(CFLAGS_WARN) -O2 -I include -DTCPIP_NO_SYS=1 -DTCPIP_VERIFY_FSM=0 examples/bench_stack.c port/posix/netif_veth.c build/libtcpip_nosys.a -o build/bench_stack
	./build/bench_stack

regen-lib:
	@test -n "$(FRAMEWORK)" || (echo "Set FRAMEWORK to Formal-Spec-Agent path"; exit 2)
	$(PYTHON) scripts/regen_lib.py --verify --framework "$(FRAMEWORK)"

formal-lib:
	@test -n "$(FRAMEWORK)" || (echo "Set FRAMEWORK to Formal-Spec-Agent path"; exit 2)
	$(PYTHON) scripts/check_formal_lib.py --framework "$(FRAMEWORK)" --lean "$(LEAN)"

clean:
	rm -rf build
