# Exact conditional SSA query refinement

`conditional_ssa.py` processes an existing single quantifier-free SMT conjunction,
not a second protocol implementation. The original exporter and Python/Z3 remain
trusted. This is neither a Rocq certificate nor an IR translation or TCP proof.

A recipe identifies a target assertion, positive conjunctive source equalities
whose left sides are constants, and paths to actual conditionals in their right
sides. Definitions are substituted in the explicit recipe order. No equality is
inferred from a disjunction, negation or the target. One to four Boolean selectors
are supported; incremental scripts, option changes and quantifiers are rejected.

The producer enumerates **every** Boolean combination. Its coverage query is the
negation of their disjunction, with no original-query assumptions. Each candidate
specialization has a local XOR theorem whose only premises are the selected
original equalities and its case facts. Every leaf retains **all original
assertions**, in order, then adds case facts and the redundant specialized target.
No original guard, domain, variable or timing assumption is removed or weakened.

The verifier does not trust the producer's substitution or simplification. It
reconstructs source clauses/selector paths and coverage, inspects the actual leaf,
reconstructs the local XOR around that leaf, checks complete assertion coverage
and runs fresh Z3 CLI processes on the coverage, context, local theorems and
admitted leaves. Claimed UNSAT must reproduce. Every CLI has the unchanged 10s
budget. Original context without the target is checked separately: SAT supports
nonvacuity, UNSAT is explicitly vacuous, UNKNOWN remains unresolved. SAT in an
inductive query does not establish a reachable implementation bug.

```
.venv/bin/python formal/conditional_ssa.py original.smt2 --recipe recipe.json --out fresh-directory
.venv/bin/python formal/conditional_ssa.py original.smt2 --out fresh-directory --verify
```

Source/checker/dependency/solver hashes and all original and derived scripts and
logs are retained. The optional original path in verification binds the source
snapshot to the expected query. A self-contained bundle by itself does not prove
that a query came from any particular IR: that provenance must be checked by its
caller. Do not overwrite completed evidence or replace primary UNKNOWN reports.

`artifacts/ack-conditional-ssa/run.py` extracts original disjuncts 092 and 280 from
the committed single-target archive, checks members.json hashes and configures
actual exported ACK assignments. The names in this recipe select source syntax;
TCP transition semantics continue to reside only in Protocol IR. These are
conditional source-query refinements, not closure of the full ACK destination,
parent invariant basis, bounded model, byte semantics or TCP specification.
