# Finite TCP reassembly profile

`model/tcp-reassembly.json` declaratively extends `tcp-data.json`, which in turn extends `tcp-connection.json`. It replaces only the five receive-text rules with one explicit reassembly transition. The expanded EFSM has 113 rules. Send queues, cumulative ACK/window processing, connection sequence variables and timers remain inherited. The old data profile remains an independent regression baseline; this is a larger finite scope, not a separate sequence or timer implementation.

## Representation and processing

The receive capacity remains 16 octets, shared by contiguous unread `rcv_buf` and 16 explicit byte cells `rx_slot_00`..`rx_slot_15`. Each cell is empty or one octet at the corresponding forward position from RCV.NXT. Empty is an absence marker, not a zero byte. Cells beyond the offered receive right edge must be empty. Slot zero is empty after every completed event because all contiguous data has been consumed into rcv_buf before committing.

`R-RECEIVE` contains all decisions in JSON AST/actions:

1. Apply RFC 9293 §3.10.7.4 Table 6 for nonempty payload: receive window positive and first or last sequence within the offered interval.
2. Save each accepted in-window octet only if its cell is empty. Out-of-window bytes are clipped. Conflicting overlapping content uses **first accepted octet wins**, an explicit deterministic profile policy, not a claim that the RFC mandates one conflict policy.
3. Compute the maximal contiguous occupied prefix, append it to rcv_buf and advance RCV.NXT modulo 2^32 by exactly that prefix length.
4. Shift the remaining queue positions by that amount, update the advertised window, then emit one cumulative ACK. All queued contiguous text is processed before that ACK (MUST-59); future text is retained for later processing (SHLD-31).

The queue is fully explicit, with no arbitrary host-language callback. Generic typed `ite(condition,yes,no)` expressions select values; both branches have the same type. It is a pure expression with the IR's existing eager, side-effect-free expression evaluation. Values still obey snapshot/assignment copy semantics. The reference interpreter, full Seq(BV8)/BV32 encoder and length projection all implement this operation; the projection's conditional-length identity is separately checked against full sequences.

The 16 positions cover arbitrary segmentation and multiple holes inside this finite window, without an extra hidden fragment-count limit. The total queued/unread capacity, cell widths, right edge, empty head, advance bound and chunk length are declared invariants. Application reads free unread bytes while retaining future cells and expanding the right edge. Close/peer FIN also requires an empty reassembly queue. ABORT/exact reset explicitly clears every queue cell.

## Scope and specification choices

The existing data restrictions remain: single connection, payload length 1..16, ESTABLISHED only, non-advancing ACK and unchanged peer send window in payload events, no general piggyback ACK/window, no FIN payload, SACK, delayed ACK, persist, congestion recovery or data implementation adapter. Exact half-space ambiguity is uncovered. Duplicate/entirely outside-window/zero-window text produces an ACK without storing new data. Strict Table 6 is used even when a segment completely spans a small window with neither endpoint in it; that case is tested and not silently broadened.

Sources: RFC 9293 §3.4 for modular sequence space and receive intervals; §3.10.7.4 Table 6 for segment acceptability, SHLD-31 for retaining higher sequence numbers and MUST-59 for draining queued text before ACK. These statements are not a full RFC requirement audit. The saved RFC baseline and hashes are unchanged.

## Evidence

The profile reuses all 15 `scenarios/data` inputs and adds `scenarios/reassembly` cases. `profiles.json` can list multiple scenario directories; duplicate case IDs and paths escaping the repository are rejected, and all sources are hashed. The suite records full state/cell snapshots, rule/source IDs, packets, synthetic PCAP, independent byte/window normalization and Difference, and fixed-input full-byte symbolic replay.

As with the base data profile, synthetic captures are not Linux or lwIP data evidence. BMC and induction retain their own actual statuses; a runtime scenario pass or a full-byte constrained replay must not be promoted to an all-input proof. The original data profile's induction certificate does not automatically cover the new receive rule. New reassembly obligations are run separately against the expanded model.

The separate reassembly induction currently passes initial establishment, 113 rule-preservation and 13 overlap-group obligations over 84 invariants. It includes queue capacity/position and empty-head properties, not byte-content integrity. Tests cover all 24 permutations of four segments plus duplicates, conflicting overlaps, multiple holes, read/shift interaction, wrap, strict Table 6 clipping and reset cleanup. Missing-cell and same-length overwrite mutations fail content scenario expectations; early ACK is found by Difference; incorrect shift produces a full-byte solver counterexample replayed as an invariant failure with transactional rollback.
