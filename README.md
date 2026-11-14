# TCPIP-Model

A small, runnable IPv4 case study produced with
[Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent).

```text
spec → model → formal → code → tests → demo
```

| Directory | Contents |
|---|---|
| [spec/](spec/README.md) | Pinned RFC sources and source/interpretation references |
| [model/](model/README.md) | One authoritative generated Protocol IR |
| [formal/](formal/README.md) | Results, scope and links to original proof records |
| [code/](code/README.md) | Standalone generated C; build and optional regeneration |
| [tests/](tests/README.md) | A frozen input/output example and focused checks |
| [demo/](demo/README.md) | Recorded execution, original capture and English viewer |

For a checkout of just the current example, use `git clone --depth 1` rather
than downloading the entire development history.

## Build and run

Only a C99 compiler and Python3.11+ are needed for the scripts. No API key,
framework checkout, Python package install or network privilege is required.

```sh
python3 code/build.py --out /tmp/tcpip-case-001 --run-example
printf 'B\nD 0 T.app.connect\n' | /tmp/tcpip-case-001/tcpip-reference
python3 -m unittest discover -s tests -v
```

The generated executable runs independently of Python. You can also compile it
directly with `cc -std=c99 code/generated/protocol.c -o /tmp/tcpip-reference`.
To inspect the recorded exchange, open [demo/review.html](demo/review.html) locally
or open [demo/capture.pcap](demo/capture.pcap) in Wireshark.

## What this example demonstrates

One declarative IR owns ARP, atomic IPv4, finite TCP, UDP and ICMP Echo behavior.
The same generated C process completed ARP resolution, TCP data/close, three UDP
round trips and three ICMP Echo exchanges against independent Linux peers.
The recorded observation contains **19 transitions and25 packets, zero drops**.
It is a retained observation, not a new network run when the viewer is rebuilt.

The model and generated C are byte-identical to the accepted prototype.
Scope is a fixed peer/tuple, MTU1500 and TCP16-byte buffers/SMSS4. General routing,
fragmentation, congestion/recovery, sockets, IPv6 and upper layers are excluded.
Finite delivery passed its stated contract; the general verification flow remains
`unresolved`, with original UNKNOWNs and implementation Differences retained in the linked historical records.
See [formal/results.json](formal/results.json) for the exact retained conclusions.

## Regenerating from IR

Generation and protocol-model validation belong to the separate framework, not
this example repository. [code/regenerate.py](code/README.md) optionally uses an
external checkout pinned by [code/framework.json](code/framework.json). Building
the supplied C and viewing the demo do not depend on it.

The full development tree, experiments and original proof bundles remain in
[Git history](https://github.com/briliant-ben/TCPIP-Model/tree/351f2519c864a05e5b3d5a405ba528862d41fa7d).
They are intentionally absent from this focused example's working tree.
