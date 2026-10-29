# Conditional component preservation

`component_induction.py` checks one named declared IR invariant using the unchanged
immediate-parent invariants plus that property as explicit preconditions. The
report enumerates every assumption. It checks the initial property, every declared
transition destination, quiet-clock progress, timer action faults and active timer
deadlines, and exports a concrete full-byte nonvacuity sample with reference replay.

For the sent ledger, CB-INV-UNSENT-BUDGET has240 obligations over201 rules and all
destinations. Its basis is the200 immediate-parent invariants plus that budget.
This proves a conditional property of the actual declared actions; it does not
prove the other child invariants, that the parent basis is preserved by the child,
guard disjointness, byte contents, whole-model induction or implementation refinement.
Full induction/BMC results remain separate, including their SAT/unknown outcomes.

```sh
.venv/bin/python formal/component_induction.py model/tcp-sent-ledger.json --parent model/tcp-output-schedule.json --property CB-INV-UNSENT-BUDGET --out artifacts/sent-ledger-budget-component
.venv/bin/python formal/component_induction.py model/tcp-sent-ledger.json --parent model/tcp-output-schedule.json --property CB-INV-UNSENT-BUDGET --out artifacts/sent-ledger-budget-component --verify
```

Uses the existing independent encoder, its explicit content-insensitive length
admission checks and full32-bit modular sequence domain, with10s per solver query.
Unsupported content observations are rejected. Parent/child models, selected
property, assumptions, checker sources, version, coverage and exported queries are
bound. Verification reconstructs the complete assertion vector with unchanged
length/order. SMT serialization can change connective/arithmetic AST ordering:
each nonidentical assertion must be proved equivalent without any other premises.
A typed associative/commutative congruence pass can first normalize builtin
and/or, integer/real sum/product and equality symmetry. A separate certificate
traversal checks every leaf, sort, ordered operator and exact operand multiplicity;
hashes order operands but never establish equality. The builtin commutative and
associative laws are independently checked as unconditional Z3 queries. Identical
certified normal forms establish congruence; other pairs still require an exact
SMT equivalence result with the same10s limit. Certificates/law bindings and
equivalence queries are retained; earlier direct-query timeouts remain historical
failed attempts. This optimizer is an explicit trusted component, not a Rocq
kernel proof of the Python implementation. This never substitutes
equivalence under an already-unsatisfiable whole query. Rehashed false artifacts,
changed scope, missing targets and a substituted parent basis are negative tests.
