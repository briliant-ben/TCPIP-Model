# Exact modular query normalization

This is an additive SMT-query transformation. It does not replace Protocol IR,
change protocol guards/actions, or introduce a new runtime operator. The original
TCP models, primary reports and solver budgets remain unchanged.

## Supported rule and certificates

Inside a positive literal integer modulus, the proposer collects integer sums,
differences and constant-scaled terms, removes nested remainders with the same
modulus, and combines equal atom coefficients modulo that modulus. Different
moduli are not merged. Nonlinear products, conditionals and other integer terms
are opaque atoms; their semantics are retained. Symbolic/nonpositive moduli,
quantifiers, incremental commands, option changes and multiple checks are
explicitly rejected.

For every actual rewrite, a generic equality replaces opaque integer atoms by
fresh integer symbols. A single negated equality is checked UNSAT without any
protocol or query premises. The verifier separately:

1. Replays a postorder traversal of the original query.
2. Obtains atom values only from certified paths in the actual source subtree.
3. Checks that instantiating the generic equality's left side reproduces that
   subtree exactly, and uses its right side as the replacement.
4. Reconstructs every original assertion by congruence, preserving count/order,
   and compares the result with the parsed exported query.
5. Rechecks every generic equality in another Z3 CLI process at10000ms per query.

This validates query equality using trusted Python syntax/instantiation/congruence
logic and Z3 integer arithmetic/CLI. It is not a Rocq/kernel certificate, a universal
IR-to-Z3 or Python-interpreter proof, or a full protocol correctness result. A15s
external process deadline yields unknown. A local-equalities producer report is
not the separate verification gate.

```sh
.venv/bin/python formal/modular_normalization.py original.smt2 --out artifacts/new-modular-attempt
.venv/bin/python formal/modular_normalization.py --out artifacts/new-modular-attempt --verify
```

Use fresh directories; completed result directories are rejected. Source/script,
checker and CLI binary hashes are bound. A satisfiability result for the resulting
query is separate from equality verification; equality alone proves no invariant.

## Scalar IR application

`model/seq32-contract.json` is a one-state, one-transition, seven-variable scalar
contract. All assignments and its two invariants are explicit IR:

- Adding the unsigned forward distance from seq32 a to seq32 b yields b.
- Adding and then subtracting any signed integer displacement restores a.

The probe accepts the full32bit domain for a/b and unbounded integer displacement.
It contains no TCP state machine, network, buffer, ordering or timing proof.
`artifacts/seq32-contract-development/` binds the actual shared encoder's36
assertions, three certified rewrites/equalities, modular induction and fresh CLI
checks. All two declared scalar invariants' induction obligations close in the
existing modular backend. The default BV32 BMC and its CLI remain unknown; they
are not relabelled as a pass.

Eight concrete wrap/half-space/large-offset cases have full reference traces,
independent fixed-input SAT/replay and fresh CLI SAT. Two IR fault variants have
explicit legal SAT witnesses and reference invariant rejection. The initial
unconstrained BV fault search timed out; its failing test/source are retained.
The fixed witnesses demonstrate faults without claiming search completeness.

The independent artifact gate also checks nonidentical API/export assertion forms
by unconditional XOR queries, without other query premises. The observed mismatch
was negative-integer literal representation. Count/order and all other statements
remain checked; no discrepancy is simply ignored. This does not prove the Z3
serializer/parser universally correct, and their trust boundary remains explicit.

## TCP ACK application and remaining work

The previously unknown S-ACK-VALID violation disjunct52 is retained under
`artifacts/ack-modular-normalization/`. It has444 unchanged assertions and zero
modular rewrites. Exact equivalent re-export gives two fresh CLI UNSAT runs near
6.14s, while the original serialization still returns unknown at10s. This is
serialization/search sensitivity, not evidence of a modulo-rewrite speedup.

That one original disjunct now has additional exact UNSAT evidence. It does not
close the whole destination;69 other previously unknown disjuncts remain
unclosed. The old70-unknown partition and59-unknown-destination reports remain
unchanged. No reachability, full-byte/time, universal translation/implementation,
Rocq or complete TCP claim follows. Exposing and simplifying the large conditional
SSA/ring assignments in the remaining original obligations is still required.
