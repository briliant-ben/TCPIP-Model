# TCPIP-Model

**A finite IPv4 case study for [Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent).**

This repository shows how a protocol specification becomes a declarative model,
independently checked behavior, standalone generated C, executable tests and
traceable observations. The reusable framework is maintained separately; this
repository owns the TCP/IP subject and its experiments.

```text
spec/ → model/ → formal/ → code/ → tests/ → demo/
  specification   IR       checks    C       tests     observations
```

## Follow the case study

| Stage | Start here | What it contains |
|---|---|---|
| Specification | [spec/](spec/README.md) | Pinned RFC text, modeling assumptions and independent byte oracles |
| Model | [model/](model/README.md) | The authoritative composed IPv4 Protocol IR and earlier scoped experiments |
| Formal checks | [formal/](formal/README.md) | Declared properties, query strategies, certificates and remaining gaps |
| Generated code | [code/](code/README.md) | Inspectable standalone C and regeneration/build entry |
| Tests | [tests/](tests/README.md) | Frozen scenarios, reference/C checks and independent observations |
| Demonstration | [demo/](demo/README.md) | English recorded execution view: 19 transitions and 25 captured packets |

**Scope:** one fixed peer/tuple, Ethernet/ARP, atomic IPv4 MTU1500, UDP, ICMP Echo,
and finite TCP with 16-byte buffers/SMSS4. The same generated C process has
exchanged ARP, TCP data/close, three UDP payload sizes and three ICMP Echo sizes
with independent Linux peers. The retained capture has 25 packets and zero drops.
This is a virtual-link prototype, not a production stack or full TCP/IP proof.

## Run the generated implementation

Use Python3.11+, a C99 compiler and the pinned framework submodule:

```sh
git submodule update --init --recursive
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-formal.txt
.venv/bin/python code/build.py --out /tmp/tcpip-example-001 --run-example
```

This generates and compiles C, executes a frozen scenario and compares its full
trace with the reference model. It does not generate a new network capture.
The C executable can run independently of Python:

```sh
printf 'B\nD 0 T.app.connect\n' | /tmp/tcpip-example-001/build/protocol-native
```

Or compile the [committed generated snapshot](code/generated/protocol.c) directly:

```sh
cc -std=c99 -Wall -Wextra -Werror code/generated/protocol.c -o /tmp/tcpip-reference
printf 'B\nD 0 T.app.connect\n' | /tmp/tcpip-reference
```

To run the ten-stage flow on this repository's data, see the
[pinned framework client](docs/framework-client.md). To inspect the existing
network observation, open [demo/review.html](demo/review.html) locally. Regenerate
that read-only English view with `.venv/bin/python demo/build_review.py`.

## What has been validated

- The fixed finite-prototype [delivery contract](docs/ipv4-prototype-acceptance.md)
  passes; see the [delivery guide](docs/ipv4-prototype-delivery.md).
- The final task has 77 reference/C cases, 563 initialized one-step negative
  queries UNSAT and one SAT witness with strict replay.
- Supplemental frozen paths bring accepted default-initial execution coverage
  to **102/335** rules. Unobserved rules are not asserted unreachable.
- Original 332 direct UNSAT preservation observations plus three separately
  audited ACK certificates cover the declared preservation obligations for
  defined transitions, including disabled/vacuous branches.
- Nonvacuity has 174 rules with SAT certificates, 11 excluded short-header
  branches and 150 without SAT certificates. Original UNKNOWN receipts remain.

The general flow still reports **`unresolved`** for incomplete exploration.
Finite delivery, scenario correspondence, bounded checks and full correctness
are different conclusions. No compiler, unbounded protocol or English-spec-to-IR
correctness proof is claimed. Original lwIP2750ms and LinuxTCP Differences remain.

## Repository map and historical material

[docs/](docs/README.md) is the current reading index. [framework/](framework) is a
pinned dependency, not another copy of protocol models. The
[legacy inventory](legacy/README.md) explains the remaining compatibility tools,
earlier model branches, experiment logs and raw evidence. Their paths and bytes
are preserved where needed by historical hashes and regression contracts; they
are not the primary showcase or active generic-framework implementation.

Dynamic routing, fragmentation/reassembly, general TCP congestion/recovery,
sockets, IPv6 and upper application protocols are outside this prototype.
