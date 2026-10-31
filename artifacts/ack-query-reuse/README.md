# Checked dependencies for original ACK queries292/300

The targets are the unchanged ledger mass-conservation clause292 and slot0 head
geometry clause300 within S-ACK-VALID -> ESTABLISHED. Every raw source has444
assertions. These proofs concern this finite ledger state/length checkpoint only,
not all ACK/capacity invariants, the parent basis, byte contents/time, reachability,
independent implementations or full TCP.

All58 dependencies have their own original query and data certificate. The generic
verifier replays each using its fixed tactic/modulo/piecewise/finite checker,
checks exactly the same443-assertion context, and only then adds the negated parent
violation. Each augmented target keeps all444 original assertions and appends58
proved conclusions. A Boolean-only composition schema independently checks the
cut step. Unsat cores selected candidates, not proof; every selected parent is
actually checked. No current target or cyclic conclusion can justify itself.

Producer/fresh CLI target times are approximately1.76/1.76s for292 and5.91/5.98s
for300. A separate verification directory replays all parents and targets; its
new query times are approximately1.82/5.99s. Context is SAT and the10s query budget
is unchanged. Parent default UNKNOWN records remain unchanged wherever an exact
alternative certificate supplies the proof. This is no metadata/status-label pass.

anchor.py additionally checks the current resolved tcp-sent-ledger IR hash, exact
original export hash, all1260 frozen source/spec/encoder inputs and every selected
partition reconstructed from that export. This binds the named current model
checkpoint but does not prove the trusted IR-to-SMT compiler. It does not silently
transfer the result to a changed model or descendant overlay.

```
.venv/bin/python artifacts/ack-query-reuse/accept.py --out /tmp/new-ack-query-reuse-check
.venv/bin/python artifacts/ack-query-reuse/check.py --out /tmp/new-ack-query-reuse-production
```

The first command extracts a source/member-hash-bound bundle into a fresh
directory, checks the model/export anchor and actually runs all proof checkers in
a separate output tree. The original graph is immutable. The bundle retains
checker versions, raw source/augmented/normalized queries, certificates, parent
results, proof-route logs, composition/context checks and independent outputs.
Certificate-supplied Python/shell commands are not executed.

The parent Git commit records ancestry; the new helper/controller source hashes
record the actual working-tree code executed and are published with this bundle.
The input Protocol IR and encoder epoch are unchanged. Generic helpers and this
application keep Python/Z3 trusted; no new Rocq kernel or Linux execution is
represented. The old primary/refinement UNKNOWN reports are preserved. Further
ACK targets and the full platform roadmap remain open.

This named bundle also binds its original solver binary. Other hosts must generate
new per-host parent certificates with the generic tools; changing an old binary
hash to make a retained bundle pass is not permitted. The Ubuntu CI runs fresh
unit certificates and does not claim replay of these retained Mac proof objects.
