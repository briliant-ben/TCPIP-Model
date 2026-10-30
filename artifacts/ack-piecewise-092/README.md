# Original ACK disjunct092

This checkpoint closes **one original exported violation disjunct**, the RTT
sample-state clause within S-ACK-VALID -> ESTABLISHED. It does not close the full
RTT property, ACK destination, parent invariant basis, full model or protocol.
The original source has444 assertions and SHA
b38609a03fbd4f06be0ef4b3a5adf098bdb6417ad63dca1ebc3d7107582bb996.

The exact conditional partition comes from the unchanged committed
ack-conditional-ssa bundle. Both contexts are SAT, all four Boolean combinations
are retained, and their local XOR theorems plus assumption-free coverage are
independently checked. Each leaf retains all444 original assertions.

The new universal modulo expansion retains the original mod outside [-M,2M), so
unbounded integers and every sequence wrap remain admitted. Each leaf has70 or71
congruence-checked replacements. All four normalized queries returned UNSAT in
both producer and fresh CLI processes: approximately0.12–0.34seconds per check,
with the same10second budget. The composed checker then independently rechecked
all parent obligations, modulo certificates/instantiations and normalized leaves.

The prior original/tactic/conditional UNKNOWN reports remain unchanged. Together
with the previously accepted disjunct052, this leaves68 of the original70 unknown
disjuncts unclosed. This is a count for the original partition, not specification
coverage. The callback-count query280 remains UNKNOWN in the separate pilot;
normalization never turns UNKNOWN into a passing result.

`check.py` produces/verifies the composition. `accept.py` extracts and checks the
retained archive in a fresh directory, then runs actual CLI verification.
`faults.py` tests missing cases, a rehashed false normalized query and a substituted
original target in temporary copies. Generic transformation tests also cover
unbounded fallback and hidden-premise/certificate faults. All original evidence
is preserved. No new Linux/PCAP/lwIP execution is represented here.

```
.venv/bin/python artifacts/ack-piecewise-092/accept.py --out /tmp/new-ack092-recheck
.venv/bin/python artifacts/ack-piecewise-092/check.py --out /tmp/new-ack092-production
```

Python, Z3, the exported query's translator and proof orchestration remain trusted;
there is no kernel, reachable implementation-bug or complete protocol claim.
