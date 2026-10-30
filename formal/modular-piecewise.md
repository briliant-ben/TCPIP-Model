# Exact piecewise modulo expansion

`modular_piecewise.py` changes only already-exported quantifier-free SMT formulas.
For every positive literal modulus M, it uses this **unconditional** integer law:

```
x mod M = if -M <= x < 2*M
          then (if x < 0 then x+M else if x >= M then x-M else x)
          else x mod M
```

The last branch retains the original remainder for every integer outside the
interval. There is no assumption that x is a sequence number, no truncation of
large signed offsets, no bound inferred from a whole unsatisfiable protocol query,
and no added protocol guard. The 10s CLI check of the generic equality has **no
query premises**. Boundaries -M, 0, M and 2*M and offsets beyond 2^80 are tested
against both correct SAT results and wrong-result UNSAT controls.

The producer rewrites each original remainder once, from children upward; the new
fallback is not recursively expanded again. A separate verifier checks exact
single-theorem certificate shape, rechecks it with a fresh CLI, instantiates it to
the actual source node, and reconstructs the full assertion vector by congruence.
Every original assertion, including trailing true, remains in order. Rehashed
hidden bounds, false equalities, wrong modulus mapping, omitted assertions and
changed domain/scope claims are rejected. Symbolic/nonpositive moduli, quantifiers
and unsupported command forms are explicitly rejected.

```
.venv/bin/python formal/modular_piecewise.py source.smt2 --out /tmp/new-modulo-expansion
.venv/bin/python formal/modular_piecewise.py source.smt2 --out /tmp/new-modulo-expansion --verify
```

A valid expansion proves query equivalence, not UNSAT: the caller separately runs
the normalized query and retains UNKNOWN/SAT. Source, dependencies, checker,
solver, certificate and normalized-query hashes are bound. Python, Z3, the source
query's IR translation and the mathematical denotation remain trusted; this is
not a Rocq theorem or a general interpreter/translator correctness proof.

The composed checkpoint in `artifacts/ack-piecewise-092` binds all four exact
conditional SSA cases for the original S-ACK-VALID disjunct092. It can close that
one original query only after every local equivalence/coverage, nonvacuity,
modulo-instantiation, unchanged assertion vector and fresh leaf check passes.
The complete RTT invariant includes other obligations, as do ACK and the parent
invariant basis. Source protocol models, action semantics, original reports and
solver budgets remain unchanged. The separate callback-count query remains
unresolved; successful arithmetic is not substituted for byte/time/implementation
or complete TCP verification.
