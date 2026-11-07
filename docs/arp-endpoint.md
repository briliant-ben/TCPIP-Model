# Finite Ethernet/IPv4 ARP endpoint

IR0.5 atomic-ordered-v1, one cache slot for192.0.2.2. Local identity is
192.0.2.1 /02:00:00:00:00:01. Input is Ethernet-II ARP with hardware1/protocol0800,
length6/4, opcode1/2; sender protocol address is the one peer, sender MAC starts
with02 and matches Ethernet source. Destination is local or broadcast. Raw length
42..60 admits unpadded virtual Ethernet and up to18 padding bytes; padding content
is ignored. Unsupported shapes, other sender/cache keys, VLANs, MAC domains or
queries are model_gap, not normative packet drops. Short raw entries are ignored
by this profile parser. No FCS/physical Ethernet conformance is claimed. Egress
is explicitly60 bytes with zero Ethernet padding, not a host codec callback.

RFC826 (November1982) Packet Generation describes table lookup and request
construction. Packet Reception describes merging an existing sender entry before
checking target protocol address, then adding a new sender only if local target,
and responding to REQUEST. IR follows that order: a known peer's existing slot
refreshes even on a nonlocal target, but an unknown nonlocal packet creates no
entry. Targeted requests learn and emit a reply using the learned sender MAC;
reply target-hardware bytes are not used as an extra protocol-address test.
Only known request/reply opcodes are admitted; gratuitous ARP, ACD/RFC5227,
security/poisoning resistance and general cache/unknown peers are not covered.

RFC1122 (October1989)2.3.2.1 requires stale-entry removal/flood prevention and
recommends at most one request/second/destination. Profile choices are explicit:
three states EMPTY/PENDING/RESOLVED; query at most once per1000ms with one retry,
then failure at2000ms; pending queries coalesce. Cached hits notify the caller
without transmitting. Cache timeout defaults60000ms, configurable60000..3600000;
refresh restarts it, and configuration while cached rearms from configuration
time. Expiry clears MAC before a same-deadline external event, using existing
IR timer semantics. These constants/retry bound are modeling choices, not RFC
mandates. No opaque Python decision or native ARP parser implements them.

Only a pending resolution emits neighbor.resolved on learning; unsolicited
learning populates the cache but does not invent a waiter. ethernet.tx is a raw
frame emission; neighbor.resolved/failed are service messages, not wire packets.
No pending IP-packet queue or upper protocol service is present. RFC1122 2.3.2.2
packet queuing, multiple interfaces/peers, proxy ARP, eviction policies and full
host conformance remain outside this module. Cross-layer forwarding is future IR
composition, not a callback hidden in the adapter.

The independent offline struct fixture constructor freezes request/reply/cache/
timer contracts first. Tests must use literal expectations, not regenerate them
from IR/native output. Every state/timer/guard/action/message and source is in IR;
no new opcode or backend change. Formal results are bounded declared-invariant/
overlap checks, fixed-input reference/Z3/C correspondence remains separate, and
UNKNOWN is unresolved. Native4096/signed64 resource domains stay explicit.
