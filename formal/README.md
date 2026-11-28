# Formal checks

## 1. 10-Module Generated Stack (`formal/stack/`)

[stack/framework.json](stack/framework.json) pins `Formal-Spec-Agent` commit
`a11c5e860d0e8552332caf42a0ba9f305bad889e` and Lean `4.35.0` across all 10
modules in `model/{arch,stack}/` (`243` raw firings, `145` conflict groups).
Run the hermetic verifier from this checkout:

```sh
make stack-formal FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean OUT=/tmp/tcpip-stack-out
```

[stack/check_stack.py](stack/check_stack.py) verifies framework commit cleanliness,
rejects any `sorry` or user `axiom` declarations, runs `formal_spec_agent lean-timed-check`
for each module against its `manifest.json` (`fsa-lean-timed-proof-manifest-v1`),
and audits `lean_timed_check.inspect` to confirm `status == checked_timed_dispatch_contract`
using only standard Lean axioms (`propext`, `Classical.choice`, `Quot.sound`).

## 2. Preserved v1 Single-Endpoint Proof (`formal/lean/`)

Use the v1 framework commit pinned by [framework.json](framework.json)
(`500a9a3daf779c48a1678744e32521bc1fd5f2aa`) and Lean `4.35.0`:

```sh
make formal FRAMEWORK=../Formal-Spec-Agent LEAN=/path/to/lean OUT=/tmp/tcpip-lean-proof
```

[lean/manifest.json](lean/manifest.json) (`fsa-lean-timed-proof-manifest-v2`) checks
all 119 modules (335 rule/timer pairings and 18 conflict groups), matching
[lean-result.json](lean-result.json) and [proof-evidence.tar.gz](proof-evidence.tar.gz).

Next: [generated C](../code/README.md).
