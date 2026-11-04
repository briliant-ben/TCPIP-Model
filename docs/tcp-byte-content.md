# TCP full-byte one-step content contracts

The observer overlay `model/tcp-byte-content.json` inherits the actual tcp-sws
model, including connection, ACK/window, timer, recovery and close composition.
It adds only explicit IR snapshot/observation variables and four content
invariants. Erasing those assignments recovers all 209 inherited ordered rules.
No behavior is implemented in Python callbacks. Inherited models are unchanged.

The 14 selected rules are queue acceptance, empty/full write rejection, two
ESTABLISHED retransmission rules, the ESTABLISHED ACK rule, and all eight
FIRST/MORE segmentation rules in ESTABLISHED, CLOSE-WAIT, FIN-WAIT-1 and CLOSING.
Unselected rules reset the observer selector, so these properties do not claim
coverage of their behavior. The scope remains the finite parent model; it does
not include all TCP data/FIN/ACK combinations or complete specification coverage.

The four IR properties require:

- Queuing appends the accepted bytes in order to the unacknowledged/unsent stream.
- ACK prefix retirement plus the remaining stream preserves the original content.
- New-data emissions match the exact prefix moved from unsent to retransmit bytes.
- Retransmission/rejected writes preserve both queues, and any observed data form
  the retransmit queue's prefix (empty output is permitted; no progress claim).

The motivation is RFC9293 August2022 §3.4 (per-octet sequence/cumulative ACK),
§3.10.7.4 (ACK processing), and §3.10.8 (front-of-queue retransmission):
https://www.rfc-editor.org/rfc/rfc9293.html . These are model content interpretations,
not a complete formalization of those clauses. Sequence credit/ACK legality,
packet headers/boundaries, general wire ordering, receive reassembly, timing,
reachability, liveness and implementation correspondence remain separate.

`formal/byte_observer.py` checks both inherited erasure and exact immediate
payload observation at every selected tcp_data emission site, including emit_if
conditions. This extra gate prevents stale ghost expressions from hiding changed
actual emissions. It is a trusted structural check, not a kernel proof.

`formal/content_step.py` uses the existing independent full Seq(BV8)/BV32 encoder
at one step with every initial variable symbolic. It retains each complete
selected rule, guard, action sequence, timer semantics and destination. It assumes
neither prestate invariants nor poststate properties and does not assume the
initial protocol state. Thus it proves a conditional content property even from
arbitrary encoded prestates; it does not prove such prestates reachable. No new
payload-length bounds or scalar/length projection are added. The Python encoder
remains trusted. Native CLI budgets remain 10 seconds.

The producer and independent reconstructing replay each record 21 UNSAT content
obligations and one UNKNOWN (S-ACK-VALID / BC-PARTITION). All 14 rule contexts and
22 property applicability contexts are independently SAT. Applicable antecedents
are checked explicitly so a selector mismatch cannot masquerade as a pass.
`formal/content_recheck.py` reconstructs every complete query from actual IR,
compares all parsed assertions, and executes fresh native CLI queries.

Evidence is under `artifacts/tcp-byte-content`: exact original production/replay
archives and member hashes, selection, retained records, observer binding and
logs. `accept.py` audits retained data; `--replay-out /tmp/new-directory` additionally
reconstructs/runs all native queries again. Reading an audit is not new solver
execution. The first smaller observer/pilots, default and fixed-tactic ACK UNKNOWN,
and rejected serialization attempt remain diagnostics. The existing tactic
checker rejected its own reparsed/reserialized candidate for AST mismatch; a
byte-preserving check-command wrapper passed source checks but still returned
UNKNOWN. No checker or source hash was relaxed.

Seven new methods pass: observer/erasure faults, payload/observer divergence,
nonzero queue/send/partial-ACK/retransmit reference execution, a same-length byte
order fault, independent query reconstruction/rehashed-false-query rejection,
and a real satisfiable source mutation. The first unit fixture incorrectly
expected unbounded byte recombination to finish in Z3; its UNKNOWN/failure log is
retained. Reconstruction gating now uses the actual queue rule with native proof;
Rocq's separate recombination theorem is not used to relabel the Z3 result.
Existing seven byte-binding and seven scalar-binding checks pass separately.
The old 495 full regression inputs are unchanged; current 509 combined discovery
has not run. No new Linux TCP/PCAP, lwIP, Rocq-kernel or full TCP evidence is claimed.
The prior length ACK closure, original main UNKNOWNs and 2750ms Difference remain.
