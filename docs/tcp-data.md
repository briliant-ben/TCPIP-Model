# TCP finite data profile

`model/tcp-data.json` is an IR 0.2 declarative extension of `tcp-connection.json`. The loader expands it into one validated EFSM; the interpreter and independent Z3 encoder receive that same expanded model. No Python callback contains protocol decisions. The data profile remains **partial**, not complete TCP or an implementation-conformance oracle.

## Supported boundary

One connection, 16 octets of total unsent/outstanding send storage, 16 octets of receive storage and MSS=4. Data is allowed only in ESTABLISHED. `snd_buf` owns unsent bytes; `rtx_buf` owns a contiguous outstanding byte interval starting at SND.UNA; `rcv_buf` owns contiguous accepted but unread bytes. The retransmission queue is a byte interval that may be repackaged, not a list of original packet boundaries (RFC 9293 §3.8 permits repackaging).

Application SEND queues bytes or reports a full buffer without partial acceptance. `app.transmit` is an explicit model scheduling request to send at most one MSS within the peer window; it is not an OS API or the RFC 9293 §3.9.1.7 FLUSH call. It preserves the existing retransmission deadline when extending a nonempty flight. Full and partial cumulative ACK remove the exact acknowledged prefix. Partial ACK restarts rtx; full ACK cancels it. Timeout sends up to MSS oldest outstanding bytes, doubles the current RTO and rearms the same `rtx` timer used by the connection model. No duplicate sequence consumption occurs on retransmission.

The extension enriches `net.synack` and `net.ack` with an explicit `window` field. The peer's handshake window is stored on entry to ESTABLISHED. Acceptable established ACKs require seq=RCV.NXT, a 0..65535 window and acknowledgement of at most the outstanding flight. WL1/WL2 freshness guards protect window updates. This first slice excludes shrinking the advertised right edge below remaining flight, nonexact receive sequence on ACK-only segments, and half-space ambiguous ACKs; these produce model coverage gaps rather than a protocol verdict. Duplicate/old ACKs do not advance SND.UNA; future ACK sends an ACK and preserves the queue.

ACK classification uses one reference point: forward distance from SND.UNA. Zero is duplicate, 1..flight is new, flight+1..2^31-1 is future, and greater than 2^31 is old. Comparing old/future separately against UNA/NXT can overlap near the half-space boundary because circular order is not globally transitive; a regression explicitly covers that case. Exact half-space distance to UNA or NXT is excluded.

`net.data` carries seq/ack/window/data. This slice requires a non-advancing ACK (ack=SND.UNA) and an unchanged advertised send window; piggybacked ACK advancement/window update is explicitly uncovered. Payload length is 1..16. In-order bytes and left-overlap suffixes are trimmed at the receive right edge, accumulated and immediately ACKed. Entirely duplicate or future segments produce a duplicate ACK; future segments are **not queued for reassembly**, so a later retransmission is needed. Out-of-order storage recommended by RFC 9293 SHLD-31 is pending, not a completed SHOULD implementation. Window-zero data does not advance RCV.NXT. Application reads return a prefix and advertise reopened capacity. There is no delayed ACK, SWS avoidance or persist probing.

CLOSE/peer FIN requires all three buffers drained; data during FIN states and FIN acknowledging outstanding payload are uncovered. ABORT and exact reset discard buffers. The inherited connection lifecycle and control timer rules remain authoritative. `local_window` parameterizes connection emissions (legacy default 65535; data profile 16); receive/read/reset update it explicitly in IR. SYN/FIN consumption and RTO configuration come from the shared connection model, including its post-SYN-retransmission RTO choice.

## Traceability and checks

- RFC 9293 §3.4: modular sequence space, cumulative ACK and receive intervals.
- RFC 9293 §3.9.1.2 / §3.9.1.3: application send/receive interface interpretation.
- RFC 9293 §3.10.7.4: ESTABLISHED ACK, WL1/WL2 window update and text processing.
- RFC 6298 §5.1–5.6: start/restart/cancel/retransmit/backoff timer subset. RTT sampling, Karn, min/max policy and full congestion/recovery remain pending.

IR invariants bind outstanding length to SND.NXT, timer activity to the queue, send/receive capacities and the advertised receive window. They do not prove arbitrary packet content or every RFC requirement. Each scenario records raw model events, rule/source IDs, packets and synthetic PCAP. Fault variants check wrong retransmission sequence advancement, omitted timer cancellation and incorrect partial ACK prefix removal.

The suite saves `expanded-model.json`, hashes both the overlay and all base models and rejects stale bases. Unknown/timeout formal results remain `formal_pending`, never proof of safety. Explicit scenarios and constrained symbolic replay are distinct from all-input bounded checking.

The expanded data profile currently has 117 rules (96 inherited and 21 data rules), with 15 data scenarios. Tests also run the 101 connection scenarios against the expanded profile after supplying explicit handshake/ACK windows. The data suite deliberately lists its own coverage gaps, including stale-window branches; those control regressions do not turn its 15-scenario coverage into a full TCP claim. With `suite --formal`, each data scenario saves `symbolic/path.smt2`, its concrete solver witness and full state/timer/output replay comparison. Rule choices and input fields are fixed in those queries, without assuming poststates or invariants; they do not establish uniqueness of enabled rules or all-input safety. The separate depth-6 safety and overlap queries currently both return unknown under the 10-second solver limit.

The optional PCAP projection `tcp-data-v1` compares payload octets and advertised windows as well as the original timing/seq/ack/flags/direction fields. The default active-open projection still rejects payload and retains its existing evidence gate. The data profile does not yet have a Linux packetdrill or lwIP data execution adapter or a data closed-loop acceptance gate; synthetic round trips only validate codecs/oracles. A projection match cannot be presented as Linux evidence.

Each data suite scenario saves a synthetic normalized packet trace, checksum/ISS metadata and Difference report bound in the artifact hashes. `evidence_scope=synthetic_codec_roundtrip_only` and `wire_roundtrip=match_synthetic_only` prevent confusing these checks with implementation evidence. The declared wire profile is also an input hash.
