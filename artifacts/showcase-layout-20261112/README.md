# Case-study presentation qualification

This change reorganizes the reader-facing path into
spec → model → formal → code → tests → demo, with English current guides.
The legacy directory is explicitly an index; protected historical files were
not physically relocated or rewritten. `preservation.json` checks30,508 existing
model/spec/scenario/evidence/legacy-core paths against Gitd7ffb765 using one
complete Git diff and existence checks. The earlier per-file subprocess loop
was stopped as an inefficient read-only audit, not a protocol or solver failure.

Three actual showcase tests pass: the stage/catalog/hash bindings; fresh C
generation, compilation and reference/native execution; and deterministic English
rendering of the original capture with wrong-digest rejection. The44 IR detail/
packet payload blocks are identical to the old view. C remains SHA19ce9855.
Four pinned-framework client tests also pass. These are focused checks, not a
rerun of every old test or a new live network observation.

DeepSeek0224 independently reviewed the actual presentation source and found no
blocking issue. Its16 findings are positive observations, not16 new defects.
Limitations remain: source review alone cannot attest execution or a full
bilingual translation. Actual tests address raw payload identity, regeneration
and pinning; original language in hash-bound inputs is deliberately preserved.
The raw review bundle also retains0223's missing-input preflight failure, zero
API calls; the new0224 request used a corrected, new input and did not retry a
failed provider request. No key/private response or archived code execution is
part of this bundle.
