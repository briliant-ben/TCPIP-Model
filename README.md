# TCPIP-Model

A **100% model-driven, Lean 4.35.0-verified generated C99 TCP/IPv4 stack** and formalized software-architecture protocol system, built with [Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent).

All protocol packet parsing, header construction, RFC 1071 checksums, timers, sliding-window state machines, and software-architecture accounting (`sys_port`, `frame_pool`, `stack_actor`) live in declarative **Protocol IR 0.6** models under `model/` and compile directly into `code/generated/stack/` via `Formal-Spec-Agent`'s `system-codegen` (`fsa-system-v1` + `c99-lib-v1`), while preserving the original **v1 minimal single-endpoint prototype** (`tag v1-minimal-prototype`, `code/generated/protocol.c`, `demo/live_demo.py`) 100% intact.

## Strict 6-Directory Repository Layout

```text
spec/     RFC source bindings + stack & software-architecture specifications (spec/{arch,stack}/)
model/    Authoritative IR 0.6 models: v1 endpoint + 10 stack/arch modules + tcpip-stack-system.json
formal/   Lean 4.35.0 kernel proofs: v1 formal/lean/ + 10-module formal/stack/{arch,stack}/
code/     Generated C99 snapshots (code/generated/protocol.c + code/generated/stack/) & thin host_runtime.{h,c}
tests/    v1 conformance suite (test_case_study.py) + 10-module generated stack E2E suite (stack_suite.c)
demo/     Live socket + PCAP capture demos (live_demo.py, stack_demo.py), stack_bench.c, & historical review.html
```

- **Zero hand-written protocol C**: `code/host_runtime.{h,c}` (`fsa_host_*`) is a thin protocol-agnostic OS/wire/PCAP adapter with zero protocol state machines or packet codecs.
- **Explicitly excluded scope**: TLS, HTTP, IPv6, Wi-Fi, and BLE are excluded.
- **Dual execution modes**:
  - `FSA_HOST_NO_SYS=1` (`libtcpip_stack_nosys.a`): single-threaded polled bare-metal execution with zero OS locks or threads.
  - `FSA_HOST_NO_SYS=0` (`libtcpip_stack_posix.a`, plus `FSA_HOST_FREERTOS` port): single-writer background stack actor thread with mutex/condvar synchronization and blocking application helpers.

---

## Lean 4.35.0 Formal Verification (10 Stack Modules + v1)

Every module in `model/{arch,stack}/` passes `Formal-Spec-Agent`'s `lean-timed-check` (`status: checked_timed_dispatch_contract`) under Lean `4.35.0` (`formal/stack/check_stack.py`, pinned in `formal/stack/framework.json` to `a11c5e860d0e8552332caf42a0ba9f305bad889e`) with **zero `sorry`** and standard Lean axioms (`propext`, `Classical.choice`, `Quot.sound`) only:

| Layer | Module | Generated Prefix | States | Raw Firings | Conflict Groups |
|---|---|---|---:|---:|---:|
| Arch | `arch/sys_port` | `fsa_sys_port` | 3 | 9 | 9 |
| Arch | `arch/frame_pool` | `fsa_frame_pool` | 1 | 3 | 3 |
| Arch | `arch/stack_actor` | `fsa_stack_actor` | 3 | 9 | 8 |
| L2 | `stack/arp_neighbor` | `fsa_arp` | 3 | 19 | 14 |
| L3 | `stack/ipv4_reass` | `fsa_reass` | 2 | 5 | 4 |
| L2/L3 | `stack/eth_ipv4_icmp` | `fsa_eth_ip` | 1 | 22 | 7 |
| L4 | `stack/udp_endpoint` | `fsa_udp` | 3 | 10 | 10 |
| L4 | `stack/tcp_connection` | `fsa_tcp` | 11 | 144 | 74 |
| Control | `stack/dhcpv4_client` | `fsa_dhcp` | 5 | 12 | 8 |
| Control | `stack/dns_resolver` | `fsa_dns` | 3 | 10 | 8 |
| **Total** | **10 modules** | **`tcpip_stack`** | **35** | **243** | **145** |

---

## Measured Code Footprint & `-O2` Throughput

Measured on Apple Clang arm64 (`-std=c99 -Wall -Wextra -Werror -Wsign-compare -Wtype-limits`):

### Generated `-Os` `.text` / `__TEXT` Breakdown (`84,490 B` / `82.51 KiB` <= `90 KiB` budget)

| Object | `-Os` Code Bytes | Object | `-Os` Code Bytes |
|---|---:|---|---:|
| `fsa_tcp.o` | `22,346 B` | `fsa_arp.o` | `5,022 B` |
| `fsa_eth_ip.o` | `16,695 B` | `fsa_udp.o` | `2,890 B` |
| `tcpip_stack.o` | `15,098 B` | `fsa_sys_port.o` | `1,108 B` |
| `fsa_dhcp.o` | `8,331 B` | `fsa_stack_actor.o` | `998 B` |
| `fsa_dns.o` | `5,802 B` | `fsa_frame_pool.o` | `856 B` |
| `fsa_reass.o` | `5,344 B` | **Total (11 `.o`)** | **`84,490 B` (`82.51 KiB`)** |

### End-to-End `-O2` Benchmark (`make stack-bench`)

| Benchmark | Measured Result |
|---|---:|
| Generated runtime RFC 1071 checksum (`1460 B` × `200,000`) | **9,910.8 MiB/s** |
| End-to-end UDP datagram TX + RX (`1400 B` × `20,000`) | **573.2 kpps** (**6,420.2 Mbps**) |
| End-to-end TCP bulk transfer (`8 MiB` stream) | **3,135.9 Mbps** |
| End-to-end TCP `64 B` ping-pong loopback RTT | **5.00 µs / iter** |

---

## Quick Start

All build and test artifacts are written out-of-tree (default `OUT=/tmp/tcpip-stack-out`), keeping the 6-directory repository root clean:

```sh
# 1. Run full Python + C99 conformance & generated-stack unit suite
make test

# 2. Build static archives, verify <= 90 KiB -Os size budget, and check FreeRTOS port
make stack-build OUT=/tmp/tcpip-stack-out

# 3. Run NO_SYS=1, NO_SYS=0 actor, FSA_STRICT, ASan+UBSan, and TSan suites
make stack-test stack-asan stack-tsan OUT=/tmp/tcpip-stack-out

# 4. Run live UDP-socket stack demo (DHCPv4 + ARP + DNS + ICMP + UDP + 2x TCP) & inspect PCAP
make stack-demo stack-bench OUT=/tmp/tcpip-stack-out
tcpdump -nn -r /tmp/tcpip-stack-out/demo/stack-live.pcap

# 5. Verify byte-identical C99 regeneration & all 10 Lean 4.35.0 formal proofs
make stack-regen FRAMEWORK=../Formal-Spec-Agent
make stack-formal FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean OUT=/tmp/tcpip-stack-out
```

### Live Stack Capture Excerpt (`tcpdump -nn -r stack-live.pcap`)

```text
08:00:01.000000 IP 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from 02:42:00:00:00:10, length 250
08:00:01.016000 IP 10.42.0.1.67 > 255.255.255.255.68: BOOTP/DHCP, Reply, length 268
08:00:01.052000 ARP, Request who-has 10.42.0.1 tell 10.42.0.10, length 46
08:00:01.056000 ARP, Reply 10.42.0.1 is-at 02:42:00:00:00:01, length 46
08:00:01.060000 IP 10.42.0.10.53001 > 10.42.0.1.53: 8755+ A? echo.demo.local. (33)
08:00:01.076000 IP 10.42.0.1.53 > 10.42.0.10.53001: 8755 1/0/0 A 10.42.0.1 (49)
08:00:01.092000 IP 10.42.0.10 > 10.42.0.1: ICMP echo request, id 43981, seq 1, length 16
08:00:01.096000 IP 10.42.0.1 > 10.42.0.10: ICMP echo reply, id 43981, seq 1, length 16
08:00:01.144000 IP 10.42.0.10.48000 > 10.42.0.1.8080: Flags [S], seq 30000, win 8192, options [mss 1460], length 0
08:00:01.148000 IP 10.42.0.1.8080 > 10.42.0.10.48000: Flags [S.], seq 1382023300, ack 30001, win 8192, options [mss 1460], length 0
```

---

## Preserved v1 Minimal Prototype (`v1-minimal-prototype`)

The original single-endpoint verified prototype remains unchanged and verified in CI (`standalone-case` & `lean-and-regen`):

```sh
make run OUT=/tmp/tcpip-case-001
make live OUT=/tmp/tcpip-live-001
make formal FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean OUT=/tmp/tcpip-lean-proof
make demo
```

See [spec/README.md](spec/README.md), [model/README.md](model/README.md), [formal/README.md](formal/README.md), [code/README.md](code/README.md), [tests/README.md](tests/README.md), and [demo/README.md](demo/README.md) for details.
