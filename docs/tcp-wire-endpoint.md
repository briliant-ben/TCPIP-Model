# Finite raw IPv4/TCP endpoint generated from IR

The new IR0.6 tcp-wire-endpoint extends tcp-data, retaining its11 states and117
protocol rules, sequence space, buffers and timers. It re-declares those rules
only to replace external network descriptors with explicit raw-byte guards/reads
and replace tcp/tcp_data emissions in place with explicit IPv4/TCP construction.
Fifty-five per-state wire-drop rules add no TCP state changes. Protocol behavior
remains finite tcp-data:16-byte send/receive buffers, SMSS4, explicit app.transmit,
immediate ACK, fixed initial RTO1000/exponential retransmission, cumulative/partial
ACK, bounded receive trimming and close only after all buffers drain. This is not
complete TCP: piggyback ACK/window advancement on data, out-of-order reassembly,
RTT/Karn/delayedACK/persist/congestion/recovery, arbitrary options/connections and
close with queued/received data remain outside this inherited profile.

## Versions and sources

RFC9293 (August2022)3.1 header/checksum,3.4 sequence space,3.7.1 MSS and
3.9.1.2/.3 PUSH interface; RFC791 (September1981)3.1; RFC6298 (June2011)
retransmission profile and RFC6864 (February2013)4/4.1 atomic IDs are pinned in
spec/tcp-wire-endpoint-oracle.json. Existing tcp-data/connection source clauses
are inherited. The offline independent struct fixture has no IR imports and is
never imported by subject or tests. Literal complete packet bytes and manual
trajectories were frozen before the new wire model executed.

## Admission and failure order

A single raw IPv4 datagram is supplied to net.packet, without Ethernet/padding.
Fixed tuple: peer192.0.2.2:8080 to local192.0.2.1:40000. Require version4/IHL5,
TOS0, DF1/MF0/offset0, TTL1..255, protocol6, arbitrary atomic input ID, MTU1500.
Output IPv4 uses TTL64/ID0/DF1. No route, ARP, Ethernet or host stack replaces the
subject. Addresses, ports, lengths, checksums and policies all appear in IR AST.

The profile's ordered classes are: raw input<40 bytes is drop_short; admitted
fixed IPv4/tuple domain with wrong Total Length is drop_ip_length; then invalid
IPv4 checksum is drop_ip_checksum. Under valid IP, Data Offset<5 or a truncated
24-byte SYNACK header is drop_tcp_length. For admitted TCP shapes, invalid TCP
checksum is drop_tcp_checksum. TCP checksum includes the full pseudoheader,
header/options and data;0000 is a normal checksum field, never UDP-style absent
or remappedFFFF. All drops modify only wire_disposition, not TCP variables or
timers. Normal dispatch still advances original timers first; a drop at a timer
deadline cannot suppress that expiry. The wire parser never slices a malformed
IP length into a valid packet. Unsupported domains are model_gap, not invented
normative drops. No rule means atomic state rejection in the declared domain.

TCP header20 requires zero reserved bits/urgent pointer. Empty S/SA/A/FA/R/RA
map to original SYN/SYNACK/ACK/FIN/RST/RSTACK events. Nonempty A or PA maps to the
original data event. Only SYNACK may alternatively use header24 with exactly one
MSS option kind2,length4,value>=4 and no data. Existing SMSS4 is always below the
peer offer; no new negotiated-MSS state changes original segmentation. MSS<4,
other options, IP options/fragments, ECN/URG, other flags/tuple/TTL0, SYN/FIN/RST
data and packets above MTU remain gaps. Original protocol guards can also reject
otherwise valid wire input, notably unsupported advancing ACK in a data segment.

The old seven descriptor event schemas remain inherited metadata but have ZERO
rules. Direct net.syn/net.synack/net.ack/net.fin/net.rst/net.rstack/net.data calls
always raise model_gap. They are not an alternate runnable subject interface.
Application events and timer semantics retain their existing interface.

## Explicit wire PUSH policy

RFC9293 3.9.1.2 MUST60/MUST61 requires timely sending and PSH on the last buffered
segment when an application PUSH flag is unavailable. This finite wire profile
sets PSHACK on EVERY nonempty emitted data segment, preserving the old abstract
flags expression as the mapping basis; zero-data ACK remains ACK. Input PSHACK
and ACK data use the same inherited sequence/byte rules. Under3.9.1.3 MAY17 the
receive API does not expose a separate PUSH flag. PSH is not a record boundary.
The explicit app.transmit service event remains a scheduling assumption; finite
scenario completion is not a universal no-indefinite-buffering/liveness proof.
A future integrated service must arrange those calls without using a host stack.

## Acceptance and boundaries

Eleven independent literal trajectories cover nonzero bidirectional data with
PSHACK, cumulative ACK/segmentation, receive/read window, drained FIN close,
MSS-only SYNACK, SYN and data loss/retransmission, partial ACK prefix retransmit,
sequence wrap and five wire drop classes. Structural checks must retain every
original rule ID/state/guard/action source, allowing only explicit raw read
substitution, wire scratch construction and emission conversion. Exact literal
bytes, reference, independent fixed-input Z3 and generated standalone C must
agree. Malformed/gap stimuli and payload/sequence/checksum faults are separate.

No new all-input/unbounded TCP proof, compiler correctness, Linux TCP peer,
physical capture, arbitrary sockets or full TCP/IP endpoint is claimed here.
Old TCP depth6 UNKNOWN, Linux differences and lwIP2750ms observations are
unchanged. Generated byte arithmetic uses mathematical reference/Z3 semantics
and explicit C4096-buffer/signed64 capacity boundaries; unsupported codegen
semantics still reject. No handwritten protocol codec implements this module.
