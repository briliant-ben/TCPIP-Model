# Exact query recheck with an explicit Z3 pipeline

`tactic_recheck.py` accepts one exported SMT conjunction, not an IR model. It rejects incremental commands, option changes, multiple checks and unsupported command forms. It compares every parsed assertion in order before execution. No assumption, violation branch, domain, state or timer condition is removed. It does not add poststate invariants.

The fixed pipeline is `simplify → propagate-values → solve-eqs → simplify → smt`. These are trusted Z3 transformations, not a new protocol semantics or a kernel-checked proof. The original conjunction remains in the exported script and its source bytes are SHA-bound. A `check-sat-using` command applies the pipeline with a10000ms Z3 resource budget; a15s external process deadline records `unknown` rather than a pass. Resource deadlines are not exact wall-clock theorem bounds.

```sh
.venv/bin/python formal/tactic_recheck.py original.smt2 --out artifacts/new-attempt
.venv/bin/python formal/tactic_recheck.py --out artifacts/new-attempt --verify
```

Use a fresh output directory. Verification checks the source, all assertions, fixed strategy/budget, CLI binary/version and output bindings, then starts another Z3 process. A forged/rehashed UNSAT report still needs a fresh UNSAT result. SAT means the supplied SMT conjunction is satisfiable; it does not establish protocol reachability. Unknown remains unknown. The CLI is expected beside the active Python executable; missing CLI blocks this recheck only.

The checker does not by itself establish that a query correctly encodes Protocol IR. Exact assertion correspondence links it to the original query, whose translation and abstraction assumptions remain explicit. It does not upgrade whole-model BMC, invariant induction, content, timing or implementation claims. Python parsing/checker logic and Z3 remain trusted.

The sent-ledger application separately reconstructs the original S-ACK-VALID destination's Boolean partition and every retained premise from its SHA-bound primary query. All368 disjunct groups plus an exact-disjunction equivalence query must independently pass before that one destination may close. Otherwise the application reports `refinement_unknown`. The old primary and partition reports remain unchanged. See `artifacts/sent-ledger-tactic-refinement/run.py` and its completed result when available; `started` or `progress` files alone are not acceptance.
