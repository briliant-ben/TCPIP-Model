# Retained formal results

[results.json](results.json) summarizes the original qualified runs. It does not
execute a checker or upgrade an old UNKNOWN. Full SMT queries, receipts, failed
attempts and versioned checkers remain at the pinned historical report links.

- Finite prototype delivery: pass under the explicitly limited contract.
- Initialized one-step checks:563 negative obligations UNSAT and one SAT witness
  with strict replay.
- Defined-transition invariant preservation:332 direct UNSAT observations plus
  three separately audited ACK certificates, including vacuous disabled branches.
- Nonvacuity:174 with SAT certificates,11 excluded short-header branches and150
  without SAT certificates. The original raw UNKNOWN records are unchanged.
- Accepted default-initial execution coverage:102/335. Unobserved rules are not
  thereby proved unreachable. The general flow remains `unresolved`.

These are different claims: finite execution, bounded checks, retained evidence
consistency and complete correctness must not be conflated. No universal
compiler, scheduler, English-specification or whole-protocol proof is claimed.
New formal runs belong to the external Formal-Spec-Agent workflow and need new
versioned evidence; this example's build/test commands do not create such proofs.

Next: [generated C](../code/README.md).
