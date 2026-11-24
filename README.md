# TCPIP-Model

A minimal, runnable IPv4/TCP/UDP/ICMP/ARP prototype produced with
[Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent).

```text
spec → model → formal → code → tests → live demo (.pcap)
```

| Directory | Contents |
|---|---|
| [spec/](spec/README.md) | Pinned RFC sources and source/interpretation references |
| [model/](model/README.md) | One authoritative generated Protocol IR |
| [formal/](formal/README.md) | Runnable Lean 4.35.0 proof and bound verification evidence |
| [code/](code/README.md) | Standalone generated C; build and optional regeneration |
| [tests/](tests/README.md) | Frozen C/model conformance checks + live exchange PCAP verification |
| [demo/](demo/README.md) | Live communicating demo (`live_demo.py`) + retained historical Linux TAP recording |

For a checkout of just the current example, use `git clone --depth 1` rather
than downloading the entire development history.

## Live communicating demo & packet capture (`.pcap`)

With one command (only a C99 compiler and Python 3.11+ needed — no root or API keys),
[demo/live_demo.py](demo/live_demo.py) compiles [code/generated/protocol.c](code/generated/protocol.c)
and exchanges real Ethernet/ARP/IPv4/TCP/UDP/ICMP traffic between the compiled
C endpoint (`192.0.2.1:40000`) and an independent peer (`192.0.2.2:8080`) over
`127.0.0.1` UDP loopback sockets, capturing every frame to a standard
`DLT_EN10MB` `live-capture.pcap`:

```sh
make live OUT=/tmp/tcpip-live-001
tcpdump -nn -r /tmp/tcpip-live-001/live-capture.pcap
# or open /tmp/tcpip-live-001/live-capture.pcap directly in Wireshark
```

What `make live` exercises in a single captured run (**41 wire packets**):
1. **Client scenario (`--mode client`)**: active TCP open (`T.app.connect` -> ARP Request/Reply -> `SYN` / `SYN-ACK` / `ACK`), segmented TCP payload echo (`"hello"` -> `"echo:hello"` across SMSS=4 chunks -> `FIN` -> `TIME-WAIT`), UDP datagram echo (`"udp-ping"` -> `"echo:udp-ping"`), and ICMP Echo Request/Reply (`"icmp-ping"`).
2. **Server scenario (`--mode server`)**: passive TCP open (`T.app.listen` -> `LISTEN` -> incoming peer `SYN` -> ARP Request/Reply -> `SYN-ACK` -> `ACK` -> `ESTABLISHED` -> echoes `"ping"` as `"echo:ping"` -> `CLOSE-WAIT` -> `LAST-ACK` -> `CLOSED`).

Sample `tcpdump -nn -r` output from running `make live`:

```text
22:06:44.155062 ARP, Request who-has 192.0.2.2 tell 192.0.2.1, length 46
22:06:44.155208 ARP, Reply 192.0.2.2 is-at 02:00:00:00:00:02, length 46
22:06:44.155743 IP 192.0.2.1.40000 > 192.0.2.2.8080: Flags [S], seq 1000, win 16, length 0
22:06:44.155872 IP 192.0.2.2.8080 > 192.0.2.1.40000: Flags [S.], seq 9000, ack 1001, win 16, length 0
22:06:44.156501 IP 192.0.2.1.40000 > 192.0.2.2.8080: Flags [.], ack 1, win 16, length 0
22:06:44.157043 IP 192.0.2.1.40000 > 192.0.2.2.8080: Flags [P.], seq 1:5, ack 1, win 16, length 4
...
22:06:44.160190 IP 192.0.2.1.40000 > 192.0.2.2.8080: UDP, length 8
22:06:44.160249 IP 192.0.2.2.8080 > 192.0.2.1.40000: UDP, length 13
22:06:44.160426 IP 192.0.2.2 > 192.0.2.1: ICMP echo request, id 4660, seq 1, length 17
22:06:44.160624 IP 192.0.2.1 > 192.0.2.2: ICMP echo reply, id 4660, seq 1, length 17
22:06:44.164767 IP 192.0.2.2.8080 > 192.0.2.1.40000: Flags [S], seq 5000, win 16, length 0
... (server ARP + SYN-ACK + echo:ping + CLOSE-WAIT/LAST-ACK/CLOSED)
```

Options for sniffing or attaching to a real OS kernel interface on Linux:

```sh
# Sniff UDP loopback traffic live in another terminal while running:
python3 demo/live_demo.py --mode all --transport udp --port-a 19001 --port-b 19002 --out /tmp/tcpip-live-002

# Attach the compiled C stack (LISTEN mode) to a Linux TAP interface and capture:
sudo python3 demo/live_demo.py --mode tap --tap tap0 --duration 15 --out /tmp/tcpip-tap-001
```

## Build and test

Only a C99 compiler and Python 3.11+ are needed for the local build and test scripts:

```sh
python3 code/build.py --out /tmp/tcpip-case-001 --run-example
printf 'B\nD 0 T.app.connect\n' | /tmp/tcpip-case-001/tcpip-reference
python3 -m unittest discover -s tests -v
```

The generated executable runs independently of Python. You can also compile it
directly with `cc -std=c99 code/generated/protocol.c -o /tmp/tcpip-reference`.
To inspect the retained pre-optimization Linux TAP recording, open
[demo/review.html](demo/review.html) locally or [demo/capture.pcap](demo/capture.pcap) in Wireshark.

## Check the model in Lean

The optional proof uses a separate, pinned Formal-Spec-Agent checkout and
Lean 4.35.0. It checks the declared invariants on all 335 model rule/timer
pairings and the scheduler's dispatch and rollback behavior.

```sh
make formal FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean OUT=/tmp/tcpip-lean-proof
```

See [formal/](formal/README.md) for the precise scope and framework pin.

## What this example demonstrates

One declarative IR owns ARP, atomic IPv4, finite TCP, UDP and ICMP Echo behavior.
The live prototype above (`demo/live_demo.py`) drives the current optimized C99
program (**651 KiB** source [code/generated/protocol.c](code/generated/protocol.c))
over local UDP loopback sockets (or Linux TAP with `--mode tap`), capturing
RFC-checksummed Ethernet frames directly to `.pcap`.

Separately, [demo/](demo/README.md) retains the historical **19-transition,
25-packet** pre-optimization Linux TAP observation against real Linux peers.
The current C is regenerated with a pinned, optimized framework backend
(**2.75 MiB → 651 KiB**), with 24 regression paths / 157 transitions matching
the original executable output and reference; [code/README.md](code/README.md)
and [demo/README.md](demo/README.md) keep those evidence epochs distinct.

Scope is a fixed peer/tuple, MTU 1500 and TCP 16-byte buffers / SMSS 4. General routing,
fragmentation, congestion/recovery, sockets, IPv6 and upper layers are excluded.
The optional Lean 4.35.0 proof covers declared invariants, timer bounds, guard
conflict groups, and dispatch/rollback contracts for this fixed endpoint
profile; see [formal/](formal/README.md) and
[formal/lean-result.json](formal/lean-result.json). Compiler equivalence and
unmodeled protocol layers remain outside the claim boundary.

## Regenerating from IR

Generation and protocol-model validation belong to the separate framework, not
this example repository. [code/regenerate.py](code/README.md) optionally uses an
external checkout pinned by [code/framework.json](code/framework.json). Building
the supplied C and viewing the demo do not depend on it.

The full development tree, experiments and original proof bundles remain in
[Git history](https://github.com/briliant-ben/TCPIP-Model/tree/351f2519c864a05e5b3d5a405ba528862d41fa7d).
They are intentionally absent from this focused example's working tree.