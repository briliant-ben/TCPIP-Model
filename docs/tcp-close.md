# TCP finite close and data composition

`model/tcp-close.json` extends the segments/reassembly/data/connection chain. All close decisions are explicit IR guards/actions; the reference interpreter and independent backends receive one expanded model. Buffers remain 16 octets, MSS 4 and full 32-bit sequence arithmetic. This profile is partial TCP, not a complete close/recovery conformance oracle.

## FIN and byte ownership

`fin_requested` records local CLOSE; `fin_sent` records the one outstanding FIN; `fin_seq` is its position after the last transmitted byte. In synchronized states, SND.NXT equals SND.UNA plus outstanding byte length plus one iff FIN is outstanding. FIN is not stored as a fake payload octet. Cumulative ACK slices only actual bytes; the final control octet is acknowledged separately. Partial data/FIN ACK restarts rtx; adding FIN to an existing flight preserves its deadline. Retransmission selects oldest bytes first (within the peer window, or one byte at zero window), then FIN at its saved sequence with the current RCV.NXT. Retransmitting FIN never consumes another sequence number.

RFC 9293 §3.10.4 queues CLOSE after preceding SENDs have been segmentized. Active CLOSE enters FIN-WAIT-1 immediately; pending bytes continue through explicit `app.transmit`. In CLOSE-WAIT a queued close remains there until preceding bytes are sent and FIN can be emitted, then enters LAST-ACK. FIN also requires available sequence window; if it is blocked, a later window update and `app.transmit` can emit it. New SEND after local CLOSE is rejected. Repeated CLOSE does not emit a second FIN. Active-close user timeout remains the inherited fixed policy; full persist with no flight is still pending.

## Receive and half-close

Previously accepted unread bytes survive local/remote FIN. FIN-WAIT-1/2 keep the inherited multi-hole receiver, including ACK/window processing and FIN acknowledgment before text. An unacceptable receive sequence cannot acknowledge the local FIN. CLOSE-WAIT can send new data before local CLOSE; its ACK processing continues while bytes are outstanding. Text after peer FIN is ignored. A new contiguous FIN first processes its ACK, advances RCV.NXT by one, clears cells beyond EOF and reports peer_eof once. Application reads remain available through TIME-WAIT; terminal cleanup discards any unread bytes.

The existing `net.fin` is a FIN-only abstract event: it has no payload or peer-window field, and its window is held unchanged. A new FIN is accepted only exactly at RCV.NXT with positive receive space and a nonfuture, nonambiguous ACK. Zero receive-window FIN and ahead FIN are ACKed/dropped; the peer must retransmit. This explicit finite policy does not implement queued out-of-order FIN or combined payload+FIN. Existing duplicate-FIN/TIME-WAIT behavior remains inherited. Full general FIN/window events, unread-data API policies, challenge resets, and recovery algorithms remain open requirements.

## Evidence boundary

Scenarios cover active/passive and simultaneous close with outstanding and unsent bytes, partial ACK, distinct data/FIN loss, receive gaps, zero windows, invalid/future ACKs, wraparound, unread data, abort/reset and user timeout. Independent output expectations and fault variants check FIN position, current ACK, deadline preservation and byte identity. State induction checks only listed length/scalar invariants, not universal content/output correctness. Full-byte constrained replay fixes each scenario's input/rule choices. Original BMC results remain independently recorded, including unknown. Synthetic PCAP/Difference is codec evidence; no Linux or lwIP close/data execution evidence is claimed.

Specification baseline: saved RFC 9293 (August 2022), §§3.4, 3.6.1, 3.10.4 and 3.10.7.4; RFC 6298 §5 for the inherited fixed/backoff timer subset. RTT/Karn, delayed ACK, full persist, congestion/recovery, FIN+payload and queued FIN remain pending. Each newer scope must add its own scenarios, proof obligations and implementation evidence.

The expanded profile declares 173 transitions and 84 state invariants. Its suite reuses the 40 data/reassembly/segments inputs plus 21 close inputs (61 total); legacy connection inputs are also exercised by regression tests after supplying their existing explicit window fields. Fixed input coverage is not RFC coverage.

The FIN-only abstraction does not observe the incoming wire window or implement a FIN-carried window update. The synthetic codec fills that omitted header with its existing default (65535); that filler is not a protocol expectation or evidence of FIN-window handling. A real close adapter must supply an enriched FIN event and a declared projection before implementation acceptance. General FIN-window processing remains pending together with FIN+payload/queued FIN.
