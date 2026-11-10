# Exact CI reproducibility closeout

This is the final refinement of the finite prototype delivery. Code source
`938dfe572e4c2f1e5e00405f264ef888e67ea147` has **46 successful CI runs**;
`implementation-source-ci.json` records their actual source SHA and conclusions.
The server actually passes118 targeted methods and the77-case task. Formal:
563 negatives UNSAT plus one SAT/strict replay match, at the original10s budget.
The reference-stage limit remains600s. No model, oracle, depth or input domain was
changed. General complete-rule exploration remains **unresolved**; execution
coverage stays71/335,264 open gaps. See `delivery.json` and the earlier complete
[335-rule matrix](../ipv4-closeout-20261109/rule-matrix.json).

The earlier6f1 push failure is preserved separately in
[the raw CI failure](../ipv4-closeout-ci-6f1-failed/diagnostic.json): one overlap
query UNKNOWN/10s and the reference worker killed after70/77 at600s. A PR sibling
passed, and the timed-out query was byte-identical to the successful server query.
Neither that UNKNOWN nor the deadline failure has been promoted to pass.

DeepSeek0180 supplied a pure necessary-literal-clash helper and passive scenario
snapshot patches. Controller qualification corrected test-only Z3 context/API
errors and replaced its invalid toy-observer tests with real IR/literal/timer
checks. The helper returns **only two original top-level conjuncts** with
contradictory literal slices of the same sequence. The planner checks AST
membership. Removing other conjuncts weakens the query, so proving the pair
UNSAT is a stronger obligation, with the full original byte domain preserved.
When no pair is recognized, the original complete leaf remains. Query derivation,
original-leaf hash and helper source hash are bound by the verifier.

Positive reference cases previously ran the interpreter twice. The unchanged
literal trace/final/timer gate now optionally records initial/operation/settle
snapshots, and its validated machine supplies the same reference projection.
There is no protocol callback. Negative execution and comparison are unchanged.
**All77 reference JSON files are byte-identical** to the prior accepted run.
Same-server observed reference time415.48→217.57s and formal99.39→48.43s are
reported in `measured-runtime.json`, not promised for every host.

The read-only audit confirms340 original global/safety/choice queries byte for
byte,149 unchanged conflict queries byte for byte, and76 weaker conflict queries
consisting only of original AND subexpressions. No new solve/C execution was used
for the audit. The first0181 audit incorrectly used Z3 recursive declaration
object identity; its failure is retained.0182 had a zero-API script syntax error,
also retained.0183 first checks exact bytes; typed/name/sort/operator-parameter
comparison is available for identity fallback, but **zero** queries needed it.

Independent DeepSeek review returned no blocking items and three findings, all
retained verbatim. The controller disposition and actual conservative fallback
counterexample explain why structural base identity is safe (missed optimization
checks the full leaf), why fresh-process canonical rendering already addresses
naming stability, and why larger contradictory subsets remain an optimization
limit. No finding or severity was erased. Hash consistency is not external
execution attestation; initialized-depth1 is not deeper/all-state/compiler/RFC proof.

`originals.tar.gz`:1812 exact original members, SHA-256
`825cf6a69e572d67547f0f4794ad00e0f43cca00311bd59f1bc9195a0be8496e`.
The bundle retains0180 proposals,0181 complete run/frozen inputs/native outputs,
118 tests, initial audit failure,0183 audit/review and0182 syntax diagnostic.
1099 selected source files match exact Git938dfe57 blobs. No archived code,
ELF or solver was executed in the local read-only audit. Current trusted code
re-renders the complete plan and replays original witnesses. Private key/ledger
and provider reasoning are excluded. Original IR7d5a8254/C19ce9855 still join the
previously accepted25-packet, zero-drop same-C Linux observation; no new network
capture is claimed by this audit. Old TCP/ICMP UNKNOWN, lwIP2750ms and LinuxTCP
differences remain. Framework extraction is not started; automation stays paused.
