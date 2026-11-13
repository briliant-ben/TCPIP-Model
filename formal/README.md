# 3. Formal checks and their limits

The active generic checker is the pinned
[Formal-Spec-Agent framework](../framework.lock.json). This directory explains
what was checked for the TCP/IP case study; it is not a second formal backend.

| Evidence channel | Accepted result | Exact scope |
|---|---|---|
| Final initialized task | 563 negative queries UNSAT; one SAT witness with strict replay | Initialized depth-one contracts, not arbitrary-depth safety |
| Defined-transition preservation | 332 original direct UNSAT observations plus three separate ACK certificates | Declared invariants on defined transitions, includes vacuous branches |
| Nonvacuity | 174 with SAT certificates; 11 excluded branches; 150 without SAT certificate | Existence of typed assignments, not general default-initial reachability |
| Fixed paths | Literal/default paths and actual observed transitions replay against independent Z3 encoding | Correspondence for those inputs, not universal compiler equivalence |

[Initialized checks](../docs/initial-step-contracts.md),
[ACK certificates and scopes](../docs/ipv4-directed-closure.md), and
[the machine-readable summary](../artifacts/ipv4-prototype-delivery-20261112/summary.json)
record the query bodies, source versions, solver budgets and hashes.
Original UNKNOWNs are retained rather than relabeled by newer successful queries.

The general flow still reports `unresolved`: its declared explorer covers10/335,
while the union of separately accepted executions covers102/335. Neither is
complete specification coverage. Unsupported semantics must be rejected; no
length projection, weaker oracle or smaller input domain silently replaces an
admitted obligation.

Run new checks through [the pinned client](../docs/framework-client.md).
Read-only certificate reproduction is available with:

```sh
.venv/bin/python tools/verify_ipv4_ack_certificates.py
.venv/bin/python tools/verify_ipv4_nonvacuity_witnesses.py
```

These audit existing formulas/assignments; they do not execute archived code or
rerun the old solver. Use an original Git/checker epoch to verify its historical
run. Initial interpreter/type checking, symbolic translation, Z3, compiler and
source interpretation remain explicit trusted components.

[Historical backend notes](history.md) preserve earlier experiments and their
original language/version descriptions. Ivy and full unbounded/compiler proofs
are not claimed.

Next: [generated C](../code/README.md).
