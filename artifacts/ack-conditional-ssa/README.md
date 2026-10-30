# ACK conditional SSA checkpoint

Two exact original S-ACK-VALID single-disjunct queries (092: RTT sample state;
280: callback count versus retransmission length), each with all 444 original
assertions, were split on two actual exported assignment conditions. All four
Boolean combinations are retained for each query. Each local XOR and coverage
query passed in producer and fresh verifier CLI processes. Original contexts
without the violation were SAT in both checks.

The independent final leaves are:

| Query | false,false | false,true | true,false | true,true |
|---|---|---|---|---|
| 092 | UNSAT | UNKNOWN | UNKNOWN | UNSAT |
| 280 | UNSAT | UNSAT | UNKNOWN | UNSAT |

Both original queries remain **UNKNOWN**. Five leaves reproduce UNSAT twice;
three remain unknown at the fixed 10s budget. No original unresolved disjunct,
whole destination or TCP model is newly closed. The earlier exploratory
serialization got one additional 092 leaf UNSAT; it is not substituted for this
checkpoint. Search/serialization sensitivity remains a practical limitation.

`evidence.tar.gz` retains every original, recipe, context, coverage, local theorem,
leaf query, producer/fresh CLI log, result and independent verification report.
`members.json` binds all members; `acceptance.json` also binds the source archive
and original member hashes. The five positive leaves are query-level facts,
conditional on the original inductive premises, not reachable implementation or
protocol proofs. Python/Z3/translation remain trusted; no kernel proof is claimed.

```
.venv/bin/python artifacts/ack-conditional-ssa/accept.py --out /tmp/new-ack-ssa-recheck
.venv/bin/python artifacts/ack-conditional-ssa/run.py --out /tmp/new-ack-ssa-production
```

Each output path must be fresh. Rechecking runs actual new CLI processes; a new
unknown does not count as a reproduced positive proof. The source runner is
retained as producer-run.py with its original acceptance hash. run.py only selects
a fresh output location. Original user refinement directories and primary
reports are unchanged. No network stack execution is represented by this bundle.
