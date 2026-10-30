# Finite source-domain specialization

`finite_specialization.py` refines one already-exported quantifier-free SMT
conjunction by an integer selector whose finite values are justified by explicit
positive conjuncts of original non-target assertions. It never infers a domain
from the violating target and never silently assumes a configured range.

The recipe names the original integer, values (at most64), target assertion and
source paths for domain clauses. A new CLI checks those clauses imply the complete
case disjunction. For each value, the producer substitutes that constant into the
whole original conjunction and simplifies a proposed redundant expression. The
local XOR theorem has **only selector=value as its premise**, not the original
query as an asserted premise. All original assertions remain unchanged in each
leaf, followed by the case equality and proposed expression.

Independent verification checks original paths and every value, reconstructs
coverage, reads the actual proposed leaf, rebuilds the local equivalence theorem
and runs fresh CLI checks. It does not trust producer substitution/simplification.
It separately checks the original context without the target for nonvacuity.
UNSAT claims must reproduce; SAT is not a reachable-bug proof. Missing values,
nonconjunctive or target-derived bounds, forged false specializations, omitted
assertions and changed source/tool hashes are rejected. No scope or time budget
is increased, and no originally admissible state can be removed by an unproved
finite-domain assumption.

```
.venv/bin/python formal/finite_specialization.py source.smt2 --recipe recipe.json --out /tmp/new-finite-proof
.venv/bin/python formal/finite_specialization.py source.smt2 --out /tmp/new-finite-proof --verify
```

This is a query-level exact transformation with trusted Python/Z3, source-query
translation and orchestration. It is not an IR interpreter/translator or kernel
proof. The TCP ring application uses the existing declared head bounds0<=head<16;
its Python recipe selects source syntax and adds no protocol transition logic.
See artifacts/ack-finite-280 for the original callback-count obligation and exact
composition with universal modulo expansion. Complete ACK/TCP/model-basis and
implementation proofs remain separate requirements.
