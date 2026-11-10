# Initialized one-step contracts

Task schema `spec-flow-task-v5` explicitly selects
`formal.strategy: initial-step-contracts`. Versions 1–4 keep their old semantics.
The checker accepts IR 0.6 atomic ordered transitions, nonempty rules/invariants,
no terminal states, depth **one**, and the model's concrete default initial values.
It uses the independent full Seq(BV8)/Int/BV symbolic encoding; no length projection,
fixed payload enumeration or reference callback constructs its constraints.

The fresh current-code renderer preserves action/rule/list order and sorts JSON
object keys. Before solving, it saves two original safety/overlap derivation roots
and every derived obligation. Explicit top-level prestate literal bindings are
substituted, with their original equalities restored for safety branches. No
unbound variable is frozen. Safety is partitioned by every rule choice, idle and
clock; a separate query proves that this set exhausts the original choice domain.
Each initialized conflict disjunct is checked standalone, a stronger UNSAT
obligation. If two original top-level conjuncts constrain overlapping literal
bytes of the same sequence differently, the planner may instead check exactly
that original pair. It verifies AST membership and retains the original leaf
hash and derivation kind. The pair is a weaker query, so proving it UNSAT is a
stronger obligation; no field, byte length, depth or budget is restricted. SAT on such a leaf is not an accepted reachable counterexample.
The first rule's satisfiable one-step path supplies nonvacuity only; its witness
is checked by the existing strict reference replay.

For the 335-rule endpoint this means 337 safety cases, 225 conflict leaves,
one choice-cover obligation and one nonvacuity query: 564 actual solver checks,
of which 563 must be UNSAT and the last SAT/replay-match. The two saved original
queries are derivation roots, not two additional successful solver runs. Negative
queries use fresh Z3 contexts; safety uses `Then(solve-eqs,simplify,smt)` and the
other queries plain Solver. The default remains 10,000 ms per query. Exceptions
or UNKNOWN never pass. Queries survive interruption; an interrupted job has no
completed report and its nonempty journal cannot be reused.

`protocol_lab.initial_step.verify` renders the plan anew using current trusted
code, compares every exact query byte, source/model/solver binding, ordered
manifest, receipt, aggregate and witness replay. It never solves or executes
stored source, ELF or task commands. The outer flow also binds its frozen inputs
and outputs. Missing/extra evidence, changed paths, symlinks, coherently rehashed
query changes and false aggregate promotion are rejected.

The trusted base includes Python, Z3, `ir.py`, `symbolic.py`, the reducer/planner,
the checker and execution provenance. Hash consistency alone cannot authenticate
an attacker who forges every solver answer coherently: external provenance or
proof certificates are needed for execution attestation. This is **not** an
all-state inductive proof, deeper TCP proof, full wire/checksum theorem, compiler
correctness proof or proof that an English RFC was translated correctly. Original
UNKNOWN receipts and older task assessments remain unchanged.
