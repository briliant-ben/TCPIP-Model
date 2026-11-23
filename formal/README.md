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
for the published model.

Receive, send and closing proofs compile as separate buffer, link-phase and data-case
lemmas to fit the existing per-module time limit. The model, raw rules and
invariants are unchanged. [proof-evidence.tar.gz](proof-evidence.tar.gz) retains
the complete fresh proof sources, model, compiler logs and axiom audit, with
individual hashes in [proof-evidence.json](proof-evidence.json). No compiled
objects are included. Tests reject a receipt from another framework or
proof-manifest revision.

[lean/manifest.json](lean/manifest.json) uses `fsa-lean-timed-proof-manifest-v2`
with explicit `compile_groups` to check all 119 modules (32 core framework
modules, 2 framework-generated/audit modules `Approved` and `TimedAudit`, and
85 case modules) under Lean 4.35.0. On Linux CI,
[Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent) revision
`500a9a3daf779c48a1678744e32521bc1fd5f2aa` passed the full framework and
endpoint Lean suite in [CI run 45042703567](https://github.com/briliant-ben/Formal-Spec-Agent/actions/runs/45042703567),
and this repository's `lean-and-regen` job in
[.github/workflows/case-study.yml](../.github/workflows/case-study.yml) freshly
runs `code/regenerate.py` and `make formal` against Lean 4.35.0 with zero third-party Python packages. All 119 Lean module digests and axiom lists match.

This proof applies to the fixed endpoint profile. It establishes properties
of the model and its Lean scheduler. The C execution and recorded packets
have their own evidence in [tests](../tests/) and [demo](../demo/). Compiler equivalence and unmodeled protocol layers remain outside the claim boundary.

Next: [generated C](../code/README.md).
