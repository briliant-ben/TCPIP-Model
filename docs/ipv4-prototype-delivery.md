# Finite IPv4 prototype delivery

The prototype passes the previously fixed [finite delivery contract](ipv4-prototype-acceptance.md).
See [the machine-readable summary](../artifacts/ipv4-prototype-delivery-20261112/summary.json)
and the [six-stage case-study entry](../README.md). Generic framework development
continues in Formal-Spec-Agent; this repository owns the TCP/IP subject.

## Delivered behavior

The authoritative `model/ipv4-endpoint-virtual-link.json` explicitly owns state,
buffers, timers, guards/actions, byte layout and checksums. IR-generated standalone
C exchanges ARP, TCP connection/four-byte bidirectional data/active close, three
UDP payload sizes and three ICMP Echo sizes with independent Linux peers in one
process. The retained virtual-Ethernet observation has25 packets/zero capture
drops and19 actual reference/C/fixed-input Z3 transitions. No new network run is
claimed by a read-only report or regenerated visualization.

## Qualification channels

- Original77-case delivery rechecks with its exact hash-matched original Git core;
  initialized depth-one563 negative queries remain UNSAT and one SAT witness
  strictly replays. Old-source rejection by a newer tool is not bypassed.
- Fresh IR-generated C passes24 supplementary default paths; cumulative execution
  observes102/335 rules. Model/C/oracle hashes are unchanged.
- Original332 direct UNSAT preservation observations plus three independently
  audited ACK certificates cover defined-transition declared preservation
  obligations, including disabled/vacuous branches. Scheduler/wire/compiler/full
  correctness is not implied.
- Raw nonvacuity161SAT/11UNSAT/163UNKNOWN remains intact. Thirteen separate SAT
  witnesses preserve all original constraints and their saved concrete assignments
  independently simplify every assertion to true. This gives174 with SAT
  certificates,11 excluded short-header branches and150 without SAT certificates.
- DeepSeek assisted proposal/analysis and independent source review. Model claims
  never replace actual reference/native/solver evidence. Findings and rejected
  attempts remain in the original evidence bundles.

## Reproduce

Start with [generated C](../code/README.md) for a fresh build/execution,
[tests](../tests/README.md) for focused regressions and the
[pinned client](framework-client.md) for a new complete task. Read-only checks:

```sh
.venv/bin/python tools/verify_ipv4_ack_certificates.py
.venv/bin/python tools/verify_ipv4_nonvacuity_witnesses.py
.venv/bin/python tools/ipv4_prototype_summary.py
```

They do not execute archived Python/ELF or rerun old solver queries. A new
independent capture requires isolated Linux namespace/TAP privileges and the
[peer harness](../ports/linux-tcp-ipv4-peer/README.md). The project server's lack of
sudo affects that channel only; host networking/SSH is not changed.

## Explicit limits

Fixed single peer/tuple, IPv4 MTU1500, TCP16-byte buffer/SMSS4. Dynamic routing,
fragmentation/reassembly, general TCP congestion/recovery/options, sockets,
IPv6 and upper protocols are excluded. Logical TIME-WAIT expiry is not a new
real-time measurement. The general flow's declared explorer remains10/335 and
its assessment remains `unresolved`; separately aggregated execution coverage is
102/335. Unobserved233 rules are not proved unreachable. Old UNKNOWN and
lwIP2750ms/LinuxTCP Differences remain visible.

Finite delivery and complete validation are separately reported conclusions.
The acceptance contract was not weakened to make this presentation look complete.
