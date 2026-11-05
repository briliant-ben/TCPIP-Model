# Finite TAP IPv4 / UDP / ICMP ingress profile

This derived63-rule IR extends ipv4-udp-icmp-endpoint.json without changing that
canonical Ethernet model, its literal oracle or original domain rejections.
Only the30 newly composed net.frame guards change their ingress envelope; all
33 application/ARP/transmit rules, actions, variables, payload/checksum policies,
ARP timers/cache/queue behavior and emitted bytes remain identical. No new
opcode, callback, Python dispatch or subject host stack implements this profile.

## Interface source and version

Official Linux v6.12 Documentation/networking/tuntap.rst is retained unchanged as
spec/sources/linux-v6.12-tuntap.rst, SHA256
5d32ead748e537c61c7db53c97fed34b9483cea3374a4721c5d99ec942219660.
Sections1 Description and3 Program interface describe userspace replacing
physical media and TAP Ethernet-frame read/write. They establish the interface
role; they do NOT mandate that a particular kernel omits padding. This profile
explicitly admits both interface extents below. Actual short frames from a
specific Linux peer require separate raw runtime observation; neither this
document nor a separately browsed tun.c version proves runner kernel behavior.
RFC/profile versions remain those of the inherited canonical component.

## Exact ingress extent

For fixed-link IPv4 input, admit either exact frame length14+IP Total Length
(unpadded interface frame) or max(60,14+IP Total Length) (canonical fully padded
Ethernet frame). For Total Length>=46 these expressions coincide. Frames with
any intermediate partial padding, arbitrary extra surplus or total extent>1514
remain model_gap. Input fully padded octets may be arbitrary and are ignored.
Generated frames still have zero padding to60 bytes; adapters forward all
subject/peer bytes unchanged and must not append or trim padding.

The raw IPv4 protocol boundary still requires Total Length28..1500 and bounded
extraction only after a valid admitted frame envelope. Total Length<28 or beyond
actual Ethernet payload is handled by the existing protocol-specific length-drop
actions, now also for interface frames42..59. Raw header/peer/port/protocol and
checksum validation order remains explicit IR. No truncation is normalized into
a valid packet. Inherited all-EtherType SHORT rules for frames<42 remain unchanged;
this is an existing finite profile ignore, not a universal RFC discard rule.

The fixed IPv4/MAC tuple, UDP TTL64, Echo TTL1..255, atomic ID handling, absent
UDP policy, exact bytes and Echo return-link policy are unchanged. Unrelated
IPv4 ingress never changes ARP/cache/query timers or pending TX. Unknown domains
remain model_gap and failed probes must leave the machine snapshot unchanged.

## Finite acceptance

An independent offline struct fixture freezes unpadded empty/odd UDP/Echo, MTU,
canonical arbitrary padding, pending queue retention, malformed Total Length and
checksum inputs before this derived model executes. It has no IR imports and is
not imported by subject/runtime/tests. Six gap stimuli cover partial padding,
surplus, wrong MAC/TTL and fragments in all three ARP states. Four unpadded inputs
remain explicit gaps in the original canonical model, protecting the old scope.

Tests require the exact30 guard-envelope amendments, all action/policy/state/
variable identity, reference/literal/native/fixed-input Z3 agreement and padding
or content-corruption negative controls. These are finite local acceptance
channels, not all-input proof, live TAP/PCAP evidence, a compiler theorem, physical
Ethernet conformance or complete TCP/IP. Any actual peer deployment is separate.

Local validation: all six specialized methods passed in9.739s. Eleven literal
scenarios matched reference, default-flag generated C and independent fixed-input
Z3. Eighteen native and eighteen reference domain probes rejected atomically;
four raw unpadded frames remained gaps in the original canonical model. Exact
structural comparisons confirmed only the30 declared ingress guard envelopes
changed. The original nine canonical scenarios also replayed unchanged.
This is local macOS validation; no live Linux peer/capture is claimed here.
