# Whole exported-query partition covers

`query_cover.py` stages a hash-bound plan and independently checks a full Boolean
partition of one labelled exported conjunction. It supports fixed built-in
standalone certificates and checked shared-context DAGs. Plans contain data only;
Python files in referenced archives are never imported or executed. Archives
and complete member manifests are hashed, restored into fresh directories and
checked for duplicate, noncanonical, unsafe or nonregular members.

Every original partition index must occur exactly once. Every mapped proof must
have the entire ordered original context and that exact original violation.
Narrower contexts, omitted/duplicate indices, false composition scripts and
promoted proof claims are rejected. The selected assertion may be anywhere in
the original vector; assertions on either side remain present.

Three explicit native theorems precede fresh parent replay:

1. The selected source assertion equals its complete disjunction, with no
   protocol assumptions as premises.
2. A Boolean-only theorem checks moving the selected assertion while preserving
   every other ordered clause in the source conjunction.
3. A Boolean-only composition theorem joins individually checked A-and-D_i
   UNSAT results into the original A-and-any-D_i UNSAT result.

The verifier then replays each mapped standalone certificate or DAG through the
existing unchanged checkers. An invocation-local fresh session can reuse only
already verified identical certificate trees in the same checker/solver epoch.
No proof status or cache result is loaded from an artifact. Source, input-bundle
and checker hashes are rechecked before success. Every native query keeps10s.
The original context is independently reported as nonvacuous, vacuous or
unresolved; an UNSAT context is not a reachability result.

```
.venv/bin/python formal/query_cover.py --plan plan.json --out /tmp/new-cover-proposal
.venv/bin/python formal/query_cover.py --proposal /tmp/new-cover-proposal --out /tmp/new-cover-check
```

A proposal alone is pending replay. Successful verification closes only that
exact labelled exported conjunction, using trusted Python/Z3 and source
extraction. It does not prove IR translation, the entire invariant basis,
reachability/liveness, byte/time semantics, implementation or protocol
correctness. Protocol applications need an additional IR/export provenance
anchor. Primary native UNKNOWN reports remain distinct from derived proofs.

The five new methods cover a complete nonlast-assertion partition, missing or
duplicate indices, a narrowed source context, rehashed false composition/scope
claims, and explicit vacuity. The82-method focused runner binds this checker,
selected tests and complete input/environment/log evidence. Real TCP coverage
replay and its source-model anchor have separate acceptance artifacts.
