# IPv4 endpoint input-header admission slice

Initial module toward the agreed IPv4 endpoint stack, not a full IPv4 host.
RFC791 September1981 section3.1 defines version/IHL/total length representation;
RFC1122 October1989 sections3.2.1.1/3.2.1.2 require invalid-version/checksum silent
discard, and3.2.1.7 forbids rejecting a received datagram solely for TTL below2.
This module therefore accepts otherwise valid receive TTL0 and TTL1 without
router decrement. Outbound TTL policy is separate.

The event is a typed header descriptor, not raw packet bytes. Addresses are
assumed valid and already local, fragmentation is absent and checksum arithmetic
is abstracted by `header_checksum_valid`. Scope is no options (IHL>5 remains an
uncovered model gap). The accepted IR explicitly constrains version0..15,IHL0..5,
length/available bytes0..65535 and TTL/protocol0..255. Outside-domain values are
model gaps, not promised RFC behavior. Within scope, IHL<5, total_length<20 or
total_length>available_length silently discard as explicit parser profile rules.
Version failure precedes checksum failure, then supported-header length failure.
No response is emitted on discard. Valid delivery metadata preserves protocol and
TTL and uses declared length minus20; extra available link padding is ignored.

The IR is authoritative for all modeled decisions. No native codec callback hides
admission policy. This slice is not yet composed with the earlier TCP wire codec,
which has its own explicitly limited positive-TTL input profile. Header checksum
computation, address policy, options, reassembly, ICMP and payload-byte/native wire
behavior remain separate open implementation milestones.

DeepSeek modeler and independent scenario reviewer proposed data separately. The
controller rejected the modeler's initial JSON-format failure without automatic
retry; one later explicit format correction used provider prefix caching. Before
acceptance the controller removed an erroneous accepted no-op claiming to be a
model gap, added missing wire-domain guards/malformed-IHL handling, and corrected
the reviewer's discarded-count3 to4 for its four literal discard events. Original
responses and review deltas are retained. No candidate output became an oracle
merely because it came from a second model.
