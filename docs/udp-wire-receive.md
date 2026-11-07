# Finite raw IPv4/UDP receive IR

One fixed raw-datagram entry, peer192.0.2.2:8080 to192.0.2.1:40000, version4/
IHL5/TOS0/ID0/DF1/MF0/offset0/TTL64/protocol17, datagram<=1500, payload<=1472.
This is receive-only; it is not composed with transmit or TCP and is not a socket
stack, ARP/ICMP, routing, PMTU, IP options, fragment reassembly or UDP options.
RFC768 (August1980) Fields and RFC1122 (October1989)3.2.1.2/4.1.3.4 are the pinned
baseline, not a claim of complete modern UDP conformance (RFC768 has later updates).

The raw entry requires exactly one IPv4 datagram, without link padding. Inputs
shorter than the required28-byte fixed header are rejected as drop_short by this
profile parser. For>=28 bytes, unsupported header/peer/port/TTL/MTU combinations
have no rule and are explicit model_gap, not normative packet drops. For admitted
headers the ordered validation is: IP Total Length must equal actual raw length;
IP header checksum over20 bytes must be valid; UDP length must be>=8 and<=IP
payload. A UDP length smaller than IP payload but>=8 is an unsupported surplus
area/model gap (no implicit UDP options interpretation). This slice admits only
UDP length exactly equal to IP payload. Packet length/UDP minimum follow RFC791
3.1/RFC768 Fields; raw equality/fixed tuple and surplus exclusion are profile policy.

RFC1122 3.2.1.2 requires invalid IP checksum discard.4.1.3.4 requires invalid
nonzero UDP checksum discard. Zero means absent, not a computed checksum failure;
the receiver configuration require_checksum defaults false (one permitted option)
and can explicitly require checksums. RFC768 Fields defines the pseudoheader and
computed-zero transmitted asFFFF; receivingFFFF uses ordinary checksum validation.
No checksum padding is delivered. A drop clears prior payload and emits nothing;
its disposition is an internal trace classification, not a wire error. Delivery
emits udp.rx.data and retains exact payload octets; a configuration event changes
only the boolean policy. All of these decisions, lengths, byte reads, pseudoheader
construction, checksum guards, ordered sets and emissions are authoritative IR0.5.
No handwritten protocol callback/native decoder or existing stack implements it.

The controller's standalone struct-based fixture constructor in spec/fixtures is
an offline oracle tool, never a runtime/test expectation callback. Literal packet
hex/disposition/payload are frozen first in spec/udp-wire-receive-oracle.json.
Scenarios use exact emission contracts; negative probes retain model-gap rejection.
Reference, independent exact byte-sequence Z3 and actual generated standalone C
must be checked. Fixed-input correspondence, finite exploration and bounded
safety/overlap results are separate; UNKNOWN remains unresolved. No peer/physical
capture/Linux UDP observation or universal translator/protocol proof is claimed.
Native buffers4096 and signed64 remain explicit backend domains.
