# Explicit exact solver preprocessing and original query journals

Tasks with schema v1, v2 or v3 may set `formal.solver_preprocess` to `none`
(default) or `exact-v1`. Other values and unknown formal fields are rejected.
The v4 sequence-induction strategy rejects this BMC-only option.

`none` constructs the original `z3.Solver()`. `exact-v1` constructs
`z3.Then("propagate-values", "solve-eqs", "simplify", "smt").solver()`.
The tactic solver retains Z3's model converters; the implementation does not
manually extract a simplified goal and lose eliminated original variables.
See the official [Z3 tactic guide](https://microsoft.github.io/z3guide/docs/strategies/tactics/)
and [tactic summaries](https://microsoft.github.io/z3guide/docs/strategies/summary/).
Z3 and its tactics, the IR-to-SMT encoding and witness reader remain trusted.
This is not a checked proof of the translator or of tactic equivalence.

The model, initial-state domain, typed input domain, depth, guards, actions,
invariants and overlap obligations are unchanged. Full `Seq(BitVec(8))` values
are retained; exact-v1 explicitly rejects the separate length projection.
Existential sample searches use the same selected policy, and only an actual
SAT witness with successful independent reference replay admits nonvacuity.
UNKNOWN and solver exceptions remain UNKNOWN. Prior results are immutable;
a successful new run does not retroactively change an earlier UNKNOWN.

Formal reports name the policy, ordered tactics and construction descriptor.
The flow verifier binds these to the canonical source-pinned task, including
rejection of missing exact-v1 metadata after coherent output rehashing.
Legacy default-none metadata may be absent. These descriptors plus tool/source
hashes bind the invocation; metadata alone does not authenticate an execution
or prove that a compiled/modified checker used a particular solver.

ICMP Echo now opts into exact-v1 at the original depth two and 60-second per
solve timeout. No model, seed, oracle, input domain or invariant was narrowed.
The timer does not claim a 60-second total bound for an entire multi-query flow.
The depth-two contracts are output-bound/drop-empty invariants, not a proof of
all checksum arithmetic, all protocol behavior, liveness or compiler correctness.

When `check(..., out=...)` is used, the output directory must be new or empty.
Safety, overlap and every attempted sample SMT are written **before** the
corresponding solve. An interrupted solve leaves the original query and no
completed result report. Successful reports retain original query hashes.
Nonempty directories are rejected without deleting or overwriting prior evidence.

The public `formal` CLI no longer writes a premature incomplete-result marker
that would itself violate that fresh-directory rule. To reproduce a baseline:

```sh
.venv/bin/python -m protocol_lab build --out /tmp/tcpip-new-check
.venv/bin/python -m protocol_lab formal --artifacts /tmp/tcpip-new-check
```

Choose a fresh path each run. Existing build-snapshot source/hash validation
still applies. Repository `artifacts` are retained snapshots, not empty targets.
Old evidence requiring the old checker must be checked at its original Git source;
updating hashes to make it pass a different checker is not permitted.

Acceptance before integration: twelve related server modules / 115 distinct
methods passed after restoring controller-omitted, unchanged Git binding/formal
files. Original failed runs remain in `artifacts/exact-backend-regression-0043`.
Two additional actual CLI tests pass locally. Earlier three complete generated-C
pipelines and their original SMT/ELF/stdout are retained in
`artifacts/exact-backend-retained-0036`. Fresh immutable CI must validate the
integrated Git head; these candidate results do not establish its CI outcome.
