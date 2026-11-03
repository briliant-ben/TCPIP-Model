# Finite raw IPv4 ICMP Echo responder

This profile implements only Echo Request to Echo Reply, not all ICMP or a complete
IPv4 host. RFC792 September1981 Echo or Echo Reply pp14-15, RFC1122 October1989
§3.2.2 and §3.2.2.6, RFC791 September1981 §3.1, RFC6864 April2013 §4/4.1 are pinned
in flows/icmp-echo.json. Updates governing other ICMP messages are outside scope;
no claim of complete modern ICMP conformance. Source versions/hashes and literal
independent oracle are part of the task, not inferred from scenario success.

## Admission and failure contract

Input is exactly one raw IPv4 datagram, no Ethernet header. At least28 and at most
1500 bytes, version4/IHL5, TOS0, DF1/MF0/offset0, positive TTL1..255, protocol1,
peer192.0.2.2 to local192.0.2.1, ICMP type8/code0. Arbitrary atomic IPv4 ID is
admitted and remains part of header checksum; no duplicate semantics use that ID.
Other lengths/fields/types are explicit model_gap, except shorter-than28 inputs
which the profile silently discards. Short handling is a profile choice, not a
claim that all short raw strings are RFC-defined ICMP packets.

For admitted headers, rule priority is disjoint: inconsistent IP total length,
bad IP header checksum, bad ICMP checksum, then Echo reply. Each failure clears
previous reply/intermediate bytes and emits nothing. RFC1122 §3.2.1.2 requires IP
header checksum verification; the RFC792 checksum format motivates explicit validation and discard policy here. Unknown
ICMP types and malformed messages outside this profile remain model_gap rather
than silently claiming a full host discard policy.

## Echo and output profile

Reply uses local/peer source/destination reversed from admitted input, IPv4
IHL5/TOS0/TTL64/protocol1, DF1/MF0/offset0 and ID0 (atomic datagram RFC6864).
Reply total length equals input length. ICMP type0/code0, identifier, sequence
number and all data including NUL/high/odd bytes are returned unchanged.
Checksums are recomputed, padding an odd final octet only for checksum arithmetic,
without transmitting that pad. ICMP checksum0000 is valid and transmitted0000;
there is no UDP absent-checksum or zero-to-FFFF policy. ReplyFFFF is also valid.
Every layout, read, length guard, policy, checksum and emit is explicit IR0.5;
no host-stack subject, ICMP Python callback or handwritten subject codec.

One READY state, no timers, routing, fragmentation/reassembly, options, dynamic
addresses, broadcast/multicast, Echo client, errors, rate limiting, ARP integration
or sockets. Native atomic-v1/4096-byte/signed64 limits apply. Both raw ingress and
output are finite virtual-link descriptions until separate real peer evidence.

## Acceptance

Offline struct oracle is frozen independently before IR execution; runtime/tests
do not import its builder. Positive cases include empty, odd NUL, zero ID/seq,
zero request/reply checksums, atomicIDFFFF, TTL1/255 and MTU1500. Negative cases
cover bad checksums/length/short, stale reply clearing and ten unsupported-domain
probes. Reference/full-byte independent observer, exact fixed-input Z3 replay,
actual standalone C and wrong-byte fault must agree with literal trace contracts.
Ten-stage flow coverage/depth bounds must be reported from actual results; its
bounded state/output-size contracts are not a universal checksum/translation or
compiler correctness proof. No Linux peer/capture evidence is claimed by fixtures.
