# Supplementary ICMP Echo invariant induction

`flows/icmp-echo-inductive.json` applies the explicit task-v4
`sequence-invariant-induction` strategy to the unchanged finite ICMP Echo model.
The original `flows/icmp-echo.json` remains the independent depth-2 bounded task
with its 60000 ms query budget. Its historical UNKNOWN and separately successful
runs remain valid records; this supplement does not convert either result.

The new task differs only in task ID, schema and formal strategy. Model, pinned
RFC interpretations, independent byte oracle, thirteen seeds, exploration,
limits and protocol scope are byte-for-byte the same task values. The generic
checker uses the default 10000 ms per-query budget, full Seq(BV8), arbitrary typed
legal prestates satisfying the declared invariants and exact rule transitions.
It does not call the reference interpreter, project bytes to lengths, limit
payload content, or assume the desired poststate.

The claim is limited to these two existing invariants:

- `ECHO-REPLY-BOUND`: stored reply length is at most 1500 bytes.
- `ECHO-DROP-EMPTY`: a disposition other than `reply` leaves no stored reply.

The thirteen obligations comprise initial invariant validity (UNSAT), initial
nonemptiness (SAT), five transition preservation checks (UNSAT), five transition
nonvacuity checks (SAT) and one guard-overlap check (UNSAT). A fault that omits
clearing a stale reply on `SHORT` produces a SAT preservation counterexample;
its arbitrary prestate is not asserted reachable from initialization.

The separate task still executes all ten stages, including real generated-C
execution and byte-oracle comparison. These finite cases do not prove universal
checksum correctness, wire contents, event completeness, compiler correctness,
whole ICMP behavior or the complete IPv4 endpoint. The IR/parser, encoding, Z3,
legal-transition scheduler and compiler remain trusted at their respective
boundaries. Checksums and echo byte semantics are covered by the unchanged
independent literal scenarios and deliberate fault tests, rather than by these
two length/disposition invariants.

To create fresh evidence, use a new output directory:

```sh
TASK_SHA=$(shasum -a 256 flows/icmp-echo-inductive.json | cut -d ' ' -f 1)
.venv/bin/python examples/run_spec_candidate.py --workspace . \
  --task flows/icmp-echo-inductive.json --task-sha256 "$TASK_SHA" \
  --out /tmp/icmp-echo-inductive-new
```

The existing checker writes exact SMT before solving, binds all thirteen query
hashes and results, refuses a nonempty output directory, and never emits a
completed passing report after interruption. Historical evidence must continue
to use its original Git checker. A local run is not a Linux peer/capture run.
