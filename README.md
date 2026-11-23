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
| [formal/](formal/README.md) | Runnable Lean 4.35.0 proof and bound verification evidence |
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
The recorded prototype used one generated C process for ARP resolution, TCP data/close, three UDP
round trips and three ICMP Echo exchanges against independent Linux peers.
The recorded observation contains **19 transitions and 25 packets, zero drops**.
It is a retained observation, not a new network run when the viewer is rebuilt.

The model is byte-identical to the accepted prototype. The current C is
regenerated with a pinned, optimized framework backend: **2.75 MiB → 651 KiB**,
with 24 existing paths /157 transitions matching both the original executable
output and reference. [Generation details](code/README.md) distinguish this
regression from the recorded network run, which retains its original C binding.
Scope is a fixed peer/tuple, MTU1500 and TCP16-byte buffers/SMSS4. General routing,
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
