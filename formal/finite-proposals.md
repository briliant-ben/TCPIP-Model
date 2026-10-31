# Untrusted raw finite proposals

`tools/propose_finite_certificate.py` proposes complete finite-case data for the
existing unchanged finite, piecewise and exact-tactic checkers. It introduces no
IR operation or protocol callback. The selector, all values and positive source
bounds use the same recipe as `finite_specialization.py` (at most64 integer
values, excluding the declared violation from coverage assumptions).

The proposal retains every original assertion. Each case adds its equality and
a raw substituted conjunction. It serializes that query first, reads the actual
proposal back and binds the local XOR to that parsed expression. This matters
because SMT printing/parsing can reassociate a large shared AND differently in
a query and an XOR. The old generator's all-positive native route labels were
correctly rejected by the unchanged structural checker; the generator was fixed.
The rejected data, source and unknowns remain under
`artifacts/diagnostics/ack-prefix-proposal-serialization`.

Both each local equivalence and each leaf receive explicit source-bound exact
tactic certificates, with the existing10s budget and fixed pipeline. Generation
alone is `native_routes_complete_unverified` or `native_routes_incomplete`.
Acceptance requires a separate fixed `query_certificates.verify` call. No status
label, proposal code, substitute result or simplification is proof authority.

```
.venv/bin/python tools/propose_finite_certificate.py original.smt2 --out /tmp/new-proposal --recipe recipe.json
.venv/bin/python formal/query_certificates.py /tmp/new-proposal --source original.smt2
```

Use fresh output directories. The default finite strategy is deliberately not
executed during this proposal phase, and its rows explicitly say `unknown` /
`default strategy not run`; they do not relabel an old solver observation. The
existing verifier still reconstructs and runs its default checks, then requires
every selected alternate equivalence and leaf route to pass a fresh native CLI.
Missing routes, incomplete coverage, changed originals, false equivalences or
forged positive status labels cannot establish acceptance. All old default
UNKNOWN reports remain unchanged.

Four new methods cover actual independent acceptance, a rehashed false proposal
with a forged positive tactic result, a satisfiable original promoted only by
metadata, and the real large shared-conjunction serialization regression. The
77-method focused suite binds the generator, tests, checker versions, input
hashes and logs. These checks do not establish IR translation, byte/time,
reachability, implementation or protocol correctness. Real protocol applications
also require a separate model/export/source anchor and evidence acceptance.
