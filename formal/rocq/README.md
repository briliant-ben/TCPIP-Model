# Rocq IR primitive pilot

This additive proof channel checks six generic value-operation statements in `Check.v`: concatenation length, clamped slice length, prefix/suffix byte-content reconstruction, negative-count slicing, full 32-bit modular-add range and modular-add composition. List statements are polymorphic and therefore apply to octet lists. There are no TCP rules in these files; Protocol IR remains the only protocol model.

`IRPrimitives.v` supplies proofs; `Check.v` fixes the exact theorem wrappers and prints assumptions. Changes to wrappers, definitions, orchestration or CI require independent review. The pilot uses an empty axiom allowlist, compiles fresh sources, audits all six wrappers and runs `rocq check` over both proof objects. Negative controls require an invalid proof to fail compilation and an injected axiom to be exposed and rejected by the audit.

Run on a host with Rocq 9.2.0 installed:

```sh
python3 formal/rocq/check.py --out artifacts/rocq
```

Or use Docker on Linux:

```sh
python3 formal/rocq/check.py --docker --out artifacts/rocq
```

The official `rocq/rocq-prover:9.2.0` amd64 image is locked to digest `sha256:33926fb3757b2b560c3844157bd64173a26b6d338a256be1ae5eec8df2019025` (Rocq 9.2.0, Stdlib 9.1.0). Proof compilation containers have networking disabled. The GitHub workflow preserves `.vo`, exact sources, compiler/kernel/assumption logs, commands, theorem names, versions, source/artifact hashes and remaining trusted components. Missing local tools yield `not_run` with no kernel-checked claim; only successful compilation, assumption audit, kernel recheck and both controls yield `kernel_checked_primitive_lemmas`.

The statement hash binds the full wrapper source, including its definitions/import dependencies through the input hashes. This does not establish that Python's IR interpreter, the Z3 translator or a C implementation computes these definitions for all inputs. Those correspondence proofs, full AST semantics, atomic actions and timer ordering are still pending. Generic content reconstruction is not a proof of TCP reassembly's first-accepted-octet policy. CI itself and checker-output parsing remain trusted; artifact hashes alone provide integrity, not authenticity. The initial workflow is a reviewed code artifact, not a protected base-branch proof acceptance service.

Primary toolchain sources: [official image repository](https://github.com/rocq-community/docker-rocq), [Rocq 9.2.0](https://rocq-prover.org/releases/9.2.0), [standard library](https://rocq-prover.org/doc/v9.1/stdlib/).
