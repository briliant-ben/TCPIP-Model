# Original finite endpoint native stack failures

Original frozen model SHA68e3da05 and direct default lowering produced SIGSEGV.
Original nine-failure unittest log is retained; its temporary per-case outputs
were deleted, so only one explicitly retained original cold-case native run is
claimed here. That run contains original generated C, compile receipt, executable,
empty stdout/stderr, strict Difference and model source reconstructed byte-for-byte
against the original generation-input SHA. Every original generation dependency
is saved and SHA-checked; changed codegen is recovered from immutable HEAD blob.

The subsequent exact offset-normalized attempt has nine complete raw native
failures (-11), nine matched fixed-input Z3 paths with original SMT/results, and
its own source snapshot. It remained unaccepted and was discarded in favor of
the clearer original model. Normalized/model sources are distinct and never
substituted into the original generation manifest. Stack-usage measurement adds
only compile-time -fstack-usage, not optimization or runtime stack changes.

ZIP and every member are SHA256-bound in manifest.json. These are retained
macOS diagnostics, not Linux network evidence, passing protocol proof, or current
implementation results. Subsequent per-rule lowering success does not upgrade
any failure here. Archived code/executables need not be executed for integrity.
