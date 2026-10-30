# Exact modulo refinement of68 original ACK disjuncts

The original single-target archive has70 UNKNOWN disjuncts. Earlier checkpoints
closed052 and092. This batch processes the other68 exact original source members,
with every444-assertion vector and the common context preserved. No protocol
model, guard, type domain, budget or oracle changes.

Universal piecewise integer remainder expansion yields48 queries with producer
and fresh CLI UNSAT, while20 remain UNKNOWN. The terminal batch ran720.317614s.
A subsequent checker reconstructs all68 transformations, verifies original member
hashes/common context, checks proof log bindings and runs a third fresh CLI for
every claimed UNSAT. All original scripts, certificates, logs and UNKNOWN outcomes
are retained. The common context is independently SAT.

These numbers concern original exported disjuncts, not specification coverage or
whole ACK/invariant-basis closure. The original primary, tactic and conditional
reports remain unchanged. The separate finite-domain280 checkpoint is an
additional proof route, not a change to this batch's original UNKNOWN280 result.
Combining checkpoints requires explicit source identity; do not count duplicates.

`driver.py` inside the archive is the actual executed source, including its
original temporary output path and starting commit/hash records. `check.py`
independently accepts the entire batch; `accept.py` safely unpacks its retained
archive and runs that checker in a fresh directory. Python/Z3 and the source IR
translation remain trusted; no kernel/byte/implementation/Linux or full TCP claim.

```
.venv/bin/python artifacts/ack-piecewise-remaining68/accept.py --out /tmp/new-ack68-recheck
```

`coverage-index.json` joins original source-member hashes across the prior298
independent checks,052/092/280 and this batch's48 additional results. It lists349
original disjuncts with named UNSAT evidence and19 unresolved indices, without
double counting280. It is a derived checkpoint index, not a new combined368-query
proof or specification coverage claim. Three temporary-copy faults also reject
missing original partitions, rehashed false normalized queries and forged
UNKNOWN-to-UNSAT metadata/logs; the original evidence is unchanged.
