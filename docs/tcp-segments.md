# ACK, window and payload composition profile

`model/tcp-segments.json` declaratively extends the reassembly/data/connection chain. It preserves the existing reassembly action sequence through an exact anchored edit, prepends an explicit ACK phase, and replaces the established ACK-only/retransmission rules. Expanded scope: 109 rules and 84 state invariants, single connection, 16-byte buffers/receive interval, payload length 1..16 in ESTABLISHED.

## Processing order

`net.data` represents a validated ACK-bearing TCP segment with nonempty payload; `net.ack` represents ACK-only. The declared profile follows RFC 9293 §3.10.7.4:

1. Validate receive sequence using Table 6. ACK-only can use any sequence in the offered positive window, or exactly RCV.NXT at a zero window. Nonempty text uses the first/last-octet test from the reassembly profile.
2. On unacceptable sequence, send an ACK and ignore ACK/window/text fields. Even an otherwise valid cumulative ACK cannot free the send queue through this path.
3. On accepted sequence, classify ACK with the one-reference-point SND.UNA forward distance. Future ACK sends ACK+drop. Old ACK does not update send state/window but accepted text continues to processing. New ACK removes the exact outstanding prefix; full ACK cancels rtx, partial ACK restarts it. Duplicate/old ACK does not restart it.
4. For ACK in [SND.UNA,SND.NXT], update SND.WND/WL1/WL2 only if the original accepted wire SEG.SEQ/SEG.ACK is fresh according to the RFC WL1/WL2 formula.
5. Insert accepted payload into the inherited queue, drain every contiguous octet, then send one cumulative ACK. This profile processes an acceptable ACK on arrival even when its accompanying text is ahead of a gap. It retains raw SEG.SEQ for WL1 rather than silently replacing it with a trimmed text position; this is an explicit modeling interpretation of the header-based window formula.

ACK and receive phases operate on the same connection variables and timers. `seg_acceptable`, ACK distance/classification and conditional effect flags are explicit IR variables. Nothing is dispatched to a Python TCP callback. ACK-only success emits no ACK, avoiding loops. Exact half-space sequence ambiguity remains uncovered; accepted-sequence half-space ACK ambiguity is uncovered, while an unacceptable-sequence segment is dropped before ACK comparability matters.

## Window shrink and probing boundary

RFC 9293 §3.8.6 MUST-34 requires robust handling when a peer shrinks its advertised window. This profile removes the old nonshrinking-scope invariant `flight <= current_window`. A negative usable window blocks new transmission without dropping outstanding bytes. Positive-window retransmission is limited to min(MSS, flight, current_window), following SHLD-15/16. On timeout with outstanding data and zero peer window, one oldest octet is retransmitted and the existing RTO backs off. No new sequence space is consumed and there is no ESTABLISHED retry-exhaustion abort.

This is **not complete persist**. With zero window and only unsent data, no independent persist timer/probe is implemented yet; zero-window persist with no flight is the next recovery scope. RTT/Karn, delayed ACK, SWS avoidance, congestion/recovery and data during close/FIN remain pending. MAY-7 permits retransmitting beyond a shrunk right edge, but this profile chooses to remain inside a positive peer window. Neither choice makes a unique packet sequence a universal conformance oracle.

## IR additions and evidence

`arm_if` and `cancel_if` are generic IR 0.2 timer actions with explicit Boolean `when`. False leaves timer state unchanged and does not validate the unused delay; true has the ordinary arm/cancel semantics. Reference and independent backends preserve action order. The symbolic positive-delay fault condition includes the enabling predicate; unsupported/content-dependent guards are not silently ignored by the length backend.

Composition supports explicit guard replacement, prepend/append and anchored action edits. Each edit checks the exact expected action at a declared index before replacement; changed parent actions fail closed. Added requirement IDs remain in expanded rule traceability. This avoids copying the 16-cell receiver and prevents unnoticed positional edits when the base changes.

The profile reuses 26 data/reassembly inputs plus 14 new duplex/window scenarios (40 total). Its independent state induction includes 109 rule obligations and 14 guard groups for 84 invariants. Full-byte fixed-input replay, synthetic PCAP normalization and Difference are kept distinct from BMC and state induction. A state certificate does not prove correct ACK order, deadline selection, content or WL freshness by itself; independent expected state/timer/output scenarios and fault variants check those behaviors. Linux and lwIP data implementation evidence remain absent. Original BMC unknown and all older profiles remain visible; no oracle, hash or upstream lwIP change is used to force a match.

Specification sources: RFC 9293 §3.4, §3.10.7.4 (Table 6, ACK processing, WL1/WL2, text ordering), §3.8.6 (window shrink), §3.8.6.1 (probing); RFC 6298 §5.1–5.6 for the inherited fixed/backoff timer subset. Existing saved RFC versions and hashes are unchanged. This is a finite model with explicit choices, not complete TCP specification coverage.
