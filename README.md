# TCPIP-Model

A modular, Lean 4.35.0-verified, embeddable **lwIP-class C99 TCP/IPv4 library (`libtcpip`)** and formalized software-architecture stack, evolved alongside [Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent).

It preserves the **v1 minimal single-endpoint prototype** (`tag v1-minimal-prototype`, [code/generated/protocol.c](code/generated/protocol.c), [demo/live_demo.py](demo/live_demo.py)) while delivering a full embeddable **L2–L4 + DHCPv4 + DNS C99 library** backed by **8 Lean 4.35.0-verified protocol and OS-portability FSM modules**.

## Architecture & Repository Layout

```text
spec/           Protocol & OS architecture specifications (sys_port, pbuf_pool, tcpip_actor, L2-L4, DHCP/DNS, RFC pins)
model/          Authoritative Protocol IR JSON models (v1 endpoint + 8 library modules in model/{arch,stack}/)
formal/         Lean 4.35.0 proofs (v1 formal/lean/ + 8 library proofs in formal/lib/{arch,stack}/)
include/tcpip/  Public C99 headers (opt.h, err.h, memp.h, pbuf.h, pcap.h, sys.h, tcpip.h, netif.h, netif_veth.h, inet_chksum.h, etharp.h, ip4_addr.h, ip4.h, icmp.h, udp.h, tcp.h, dhcp.h, dns.h, netconn.h, sockets.h)
src/            C99 implementation: src/core/ (L2-L4, DHCP, DNS, pbuf, memp, tcpip actor), src/api/ (Netconn & BSD Sockets), src/generated/ (8 FSM C99 verifiers)
port/           OS/bare-metal ports: port/nosys/, port/posix/ (pthreads + virtual-Ethernet veth + PCAP), port/freertos/
examples/       tcp_echo_demo.c (BSD sockets), dhcp_dns_demo.c, bench_stack.c
tests/          v1 conformance suite (test_case_study.py) + M1-M4 C99 library & sanitizer suites (tests/lib/)
scripts/        C99 FSM library regenerator (regen_lib.py) and 8-module Lean proof verifier (check_formal_lib.py)
```

### Software Architecture Protocol + Dual Execution Model
1. **Bare-metal (`TCPIP_NO_SYS=1`)**: `libtcpip_nosys.a` — polling loop (`tcpip_poll`), zero threads/locks, callback Raw API (`udp_*`, `tcp_*`), **23.22 KiB** `.text` at `-Os`.
2. **Multithreaded RTOS/POSIX (`TCPIP_NO_SYS=0`)**: `libtcpip_posix.a` (plus `port/freertos/` skeleton) — single-writer `tcpip_thread` actor mailbox (`tcpip_input`, `tcpip_api_call`, timer wheel) with blocking `netconn_*` and BSD-compatible `tcpip_socket`/`tcpip_bind`/`tcpip_listen`/`tcpip_accept`/`tcpip_connect`/`tcpip_send`/`tcpip_recv`/`tcpip_close` APIs, **38.27 KiB** `.text` at `-Os`.

### Stack Capabilities (Exclude TLS, HTTP, IPv6, Wi-Fi/BLE)
- **OS Port & Memory (`M1`)**: Fixed `memp` pools, chained zero-copy `pbuf` (`PBUF_POOL` / `PBUF_RAM` / `PBUF_REF`), PCAP writer (`DLT_EN10MB`), virtual-Ethernet (`veth`) with configurable drop/reorder/duplicate fault injection.
- **L2 / L3 (`M2`)**: Ethernet framing, 16-entry ARP cache + request queueing (`etharp`), RFC 791 IPv4 + 16-bit options/checksum + fragmentation & out-of-order reassembly (`ip4_frag`), RFC 792 ICMP Echo & Destination Unreachable.
- **L4 (`M3`)**: Multi-PCB UDP (`udp_bind`, `udp_connect`, `udp_send`, `udp_sendto`), RFC 9293 / 6298 / 5681 TCP across all 11 states (`LISTEN` backlog, MSS/window negotiation, Jacobson RTT/RTO backoff, delayed ACK, fast retransmit/recovery, zero-window persist probes, out-of-order segment queue, `TIME_WAIT` expiry).
- **Control & App API (`M4`)**: DHCPv4 DORA client (`dhcp.c`), DNS A-record stub resolver (`dns.c`), thread-safe Netconn (`netconn.c`), and BSD Sockets (`sockets.c`).

---

## Formal Verification Summary (8 Lean 4.35.0 Modules + v1)

All 8 library FSM modules compile to pure C99 headers/sources via `Formal-Spec-Agent` (`c99-lib-v1` backend pinned in [formal/lib/framework.json](formal/lib/framework.json)) and are checked against [formal/lib/](formal/lib/) with **zero `sorry`** and standard Lean axioms only (`propext`, `Classical.choice`, `Quot.sound`):

| Layer | Module | Raw Firings | Conflict Groups | C99 Hook (`-DTCPIP_VERIFY_FSM=1`) |
|---|---|---:|---:|---|
| Arch | `arch/sys_port` | 10 | 5 | `sys_port_fsm` |
| Arch | `arch/pbuf_pool` | 13 | 11 | `pbuf_fsm` |
| Arch | `arch/tcpip_actor` | 16 | 14 | `actor_fsm` |
| Stack | `stack/arp_entry` | 17 | 15 | `arp_fsm` |
| Stack | `stack/ip_reass_slot` | 7 | 5 | `ip_reass_fsm` |
| Stack | `stack/tcp_pcb` | 52 | 38 | `tcp_fsm` |
| Stack | `stack/dhcp_client` | 22 | 18 | `dhcp_fsm` |
| Stack | `stack/dns_stub` | 9 | 7 | `dns_fsm` |

Runtime builds use `-DTCPIP_VERIFY_FSM=0` for zero FSM-shadow overhead, while all CI test suites enable `-DTCPIP_VERIFY_FSM=1` under clean, ASan/UBSan, and TSan instrumentation.

---

## Measured Footprint & Throughput (`make size`, `make bench`)

Measured locally on Apple Clang arm64 (`-std=c99 -Os -ffunction-sections -fdata-sections` for libs, `-O2` over polled in-memory `veth` for `bench_stack`):

| Metric | Value | Target |
|---|---:|---|
| Core L2–L4 static lib (`libtcpip_nosys.a` `.text`) | **23,779 B (23.22 KiB)** | 40–90 KiB (`<= 90 KiB`) |
| Full stack (`libtcpip_posix.a` `.text`) | **39,188 B (38.27 KiB)** | Compact embeddable |
| `inet_chksum` (1500 B × 200,000) | **4,571.0 MiB/s** (`62.59 ms`) | Fast RFC 1071 32-bit fold |
| UDP TX+RX (1400 B × 20,000) | **2,154.7 kpps** (**24,132.7 Mbps**) | Line-rate software loopback |
| TCP bulk TX (8 MiB stream) | **16,268.8 Mbps** (`4.12 ms`) | High-throughput zero-copy path |
| TCP ping-pong RTT (32 B × 1,000) | **0.31 µs / RTT** | Low-latency single-writer path |

---

## Quick Start (`libtcpip`)

Requires a C99 compiler (`cc`) and Python 3.11+ (`pthreads` for `TCPIP_NO_SYS=0`):

```sh
# 1. Build static libraries and enforce core L2-L4 size limit
make lib size

# 2. Run M1-M4 verification suites (NO_SYS=1 & NO_SYS=0) + ASan/UBSan + TSan
make test-lib test-asan test-tsan

# 3. Run real-traffic BSD Socket TCP echo & DHCP+DNS demos (produces build/*.pcap)
make demos
tcpdump -nn -r build/tcp_echo_demo.pcap
tcpdump -nn -r build/dhcp_dns_demo.pcap

# 4. Run checksum/UDP/TCP microbenchmarks
make bench

# 5. Verify C99 FSM regeneration & all 8 Lean 4.35.0 formal proofs
make regen-lib FRAMEWORK=../Formal-Spec-Agent
make formal-lib FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean
```

### Sample Wire Captures (`tcpdump -nn -r`)

`make demos` produces standard Ethernet PCAPs verifiable with Wireshark or `tcpdump`:

```text
# build/tcp_echo_demo.pcap (11 frames: 3-way handshake, 62B echo, 4-way FIN teardown)
08:00:00.001000 IP 10.42.0.2.49152 > 10.42.0.2.9090: Flags [S], seq 2542462624, win 32768, options [mss 1460], length 0
08:00:00.001000 IP 10.42.0.2.9090 > 10.42.0.2.49152: Flags [S.], seq 1382023300, ack 2542462625, win 32768, options [mss 1460], length 0
08:00:00.001000 IP 10.42.0.2.49152 > 10.42.0.2.9090: Flags [P.], seq 1:63, ack 1, win 32768, length 62
...

# build/dhcp_dns_demo.pcap (6 frames: DHCP DORA lease 10.50.0.100 + DNS A? example.org -> 93.184.216.34)
08:00:00.001000 IP 0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from 02:00:00:00:00:a1, length 249
08:00:00.001000 IP 10.50.0.2.67 > 255.255.255.255.68: BOOTP/DHCP, Reply, length 274
08:00:00.011000 IP 10.50.0.2.49152 > 10.50.0.2.53: 4352+ A? example.org. (29)
08:00:00.011000 IP 10.50.0.2.53 > 10.50.0.2.49152: 4352 1/0/0 A 93.184.216.34 (45)
```

---

## Preserved v1 Minimal Prototype (`v1-minimal-prototype`)

The original single-endpoint verified prototype remains intact and tested in CI (`standalone-case` & `lean-and-regen`):

```sh
make test
make live OUT=/tmp/tcpip-live-001
tcpdump -nn -r /tmp/tcpip-live-001/live-capture.pcap
make run OUT=/tmp/tcpip-case-001
make formal FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean OUT=/tmp/tcpip-lean-proof
```

See [code/README.md](code/README.md), [demo/README.md](demo/README.md), and [formal/README.md](formal/README.md) for v1 artifact digests, regression paths (`24` paths / `157` transitions), and historical Linux TAP capture ([demo/review.html](demo/review.html)).
