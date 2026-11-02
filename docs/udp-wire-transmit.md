# IPv4/UDP transmit bytes from authoritative IR

## Scope and interpretation

Transmit-only IR0.4, one READY state, fixed192.0.2.1:40000 to192.0.2.2:8080,
TTL64, TOS0, IHL5, DF1/MF0/offset0, ID0, assumed MTU1500 and payload<=1472.
No receive, dynamic address/port binding, ARP, routing, PMTU, fragments/options,
ICMP or physical/Linux peer execution. These are profile assumptions/exclusions,
not full IPv4/UDP conformance. RFC6864§4/4.1 permits arbitrary ID for atomic
DF1/MF0/offset0 datagrams; therefore repeated ID0 is intentional, not reassembly
logic. RFC791§3.1 defines fixed-header fields and checksum; RFC768 Fields pages1/2
UDP length/pseudoheader/checksum, RFC1122§4.1.3.4 checksum default/configuration.
Full official source hashes are pinned before execution. Unknown behavior is not
silently interpreted as implemented. Payload1473 is explicitly uncovered.

## IR authority

All UDP/IP layout, field constants, lengths, default checksum control, UDP zero
mapping, pseudoheader and checksum insertion are ordinary typed IR expressions,
ordered sets and emit. No protocol decision or packet encoder is added to Python
callbacks, native C codec or an existing host stack. Generic pack/checksum ops
are the same independently implemented IR0.4 arithmetic from the prior milestone.
The emitted ipv4.tx.packet is a complete IPv4/UDP datagram. It includes UDP
checksum by default, computed zero maps toFFFF, disabled generation inserts zero.
Odd-byte checksum padding never becomes transmitted payload. No new IR opcode.

## Independent acceptance

Six frozen scenario0.2 seeds and packet oracle come from a separate struct-based
controller fixture construction, without IR execution or native output input.
They cover empty, odd/NUL, real zero-toFFFF, disable/restore, identical repeated
atomic datagrams and MTU boundary. Literal raw hex and decoded fields/timestamps
are pinned as task sources; trace outputs are exact byte arrays. The base flow
still generates rule witnesses/model-gap inputs and independently compares full
state/emission traces. Its bounded safety properties are length/MTU only, not
universal checksum/compiler/English-to-IR proofs. Any UNKNOWN remains unresolved.

examples/run_udp_transmit.py executes the ordinary ten-stage client, then reads
only original generated-C transition emissions. It checks base artifact hashes,
wraps their packet bytes unchanged in DLT_RAW PCAP and independently decodes IP/UDP
lengths/checksums/addresses/ports/payload/time before exact literal-oracle compare.
The decoder never calls IR reference checksum or constructs packet bytes. No
reference packet constructs the PCAP. Case reports keep transition/requirement
IDs; source/spec/clause/hash traceability remains in the base job. Observation
sources/stdout/oracle/PCAP hashes are retained; changes invalidate the gate.
This is generated-native virtual-link evidence, not Linux UDP/TCP/physical capture.
The PCAP carrier is written locally from actual C output, not sniffed on a wire.
The wrapper may retain a passing PCAP channel while a formal channel is unknown,
but never upgrades the overall flow or counterexample to success.
