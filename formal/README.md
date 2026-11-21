# Formal checks

## Fresh Lean check

Use the framework commit pinned by [framework.json](framework.json) and Lean
4.35.0. Run the check from this checkout.

```sh
make formal FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean OUT=/tmp/tcpip-lean-proof
```

The checker renders the authoritative IR and checks the reviewed modules in
[lean/](lean/) against it. It covers the admitted initial state, all 335
rule/timer pairings, all 18 guard conflict groups and the scheduler's dispatch
and rollback contracts. For an admitted state and a nondecreasing clock,
declared external events either execute and preserve the invariants or return
uncovered and roll back. The result directory includes the model, kernel
sources, compiler logs and the axiom audit. Python packages are unnecessary
for this command. The [local receipt](lean-result.json) records the result
for the published model. The framework's linked closeout run compared 77
reference and generated C cases. Its exploration covered 10/335 rules,
leaving the overall flow verdict unresolved.

Receive and send proofs compile as separate buffer, link-phase and data-case
lemmas to fit the existing per-module time limit. The model, raw rules and
invariants are unchanged. [proof-evidence.tar.gz](proof-evidence.tar.gz) retains
the complete fresh proof sources, model, compiler logs and axiom audit, with
individual hashes in [proof-evidence.json](proof-evidence.json). No compiled
objects are included. Tests reject a receipt from another framework or
proof-manifest revision.

The same revision passed all 155 framework tests on Linux, split into 154
general tests and one complete endpoint proof, with no skipped tests.
[linux-proof-evidence.tar.gz](linux-proof-evidence.tar.gz) retains the raw
proof and test receipts; [its manifest](linux-proof-evidence.json) binds the
original GitHub artifacts and individual retained files. All 108 Lean source
digests and axiom lists match the local recheck. The read-only audit does not
execute retained code; CI execution provenance remains a trust assumption.

This proof applies to the fixed endpoint profile. It establishes properties
of the model and its Lean scheduler. The C execution and recorded packets
have their own evidence in [tests](../tests/) and [demo](../demo/).

## Historical solver results

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
consistency and complete correctness must not be conflated. The historical solver receipts record their own scopes. The fresh Lean check
above has a separate verdict and input binding.

Next: [generated C](../code/README.md).
