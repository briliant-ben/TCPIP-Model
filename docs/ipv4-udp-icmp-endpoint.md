# Finite Ethernet / IPv4 / UDP / ICMP composition

This new IR inherits the unchanged ARP+UDP transmit EFSM. One machine owns the
ARP cache/timers/latest pending packet, IPv4/UDP transmission, UDP reception and
ICMP Echo replies. No adapter dispatch, protocol callback or host-stack subject.
This is not complete TCP/IP: TCP, general routing, multiple peers, fragmentation,
options, PMTU, ICMP errors/client and general sockets remain excluded.

## Fixed version, sources and admission

RFC768 (August1980), RFC791 (September1981) section3.1, RFC792 (September1981)
Echo/Echo Reply, RFC894 (April1984) Frame Format and verified erratum570,
RFC1122 (October1989) sections3.2.1.2/3.2.2.6/4.1.3.4 and RFC6864 (February2013)
sections4/4.1 are pinned by the independent oracle source hashes. Existing ARP
and TX component source/profile interpretations are inherited unchanged.

The sole link is local192.0.2.1/MAC020000000001 and peer192.0.2.2/MAC020000000002.
IPv4 ingress requires these exact Ethernet source/destination addresses and
EtherType0800, IHL5/TOS0, DF1/MF0/off0, arbitrary atomic ID, MTU1500. UDP uses
peer8080 to local40000 and TTL64. Echo accepts TTL1..255 and type8/code0.
Input IDs still contribute to IPv4 checksum validation. Ethernet FCS is absent.

RFC894 excludes Ethernet padding from IPv4 Total Length. This finite entry
admits canonical frame size max(60,14+IP Total Length), up to1514. Input padding
may contain arbitrary octets and is ignored; output padding is zero. Only after
checking the full frame bounds, fixed link/header domain and total length does
the IR slice the IP datagram. A Total Length below28 or above actual Ethernet
payload is an explicit profile drop, before any slice can hide truncation.
Noncanonical surplus, frames42..59, over-MTU and unsupported headers remain
model_gap. The inherited ARP SHORT rules ignore all frames shorter than42,
unchanged; this legacy profile choice is not a normative universal discard rule.
For a60-byte frame, Total Length defines where padding starts; the receiver
cannot infer the sender's intended padding boundary from bytes alone.

UDP policy and checksum/drop ordering are copied from the existing atomic raw
receive module. UDP absent-checksum allowance defaults true and is separately
configurable with app.require_checksum; nonzero/FFFF values validate normally.
Payload/disposition are namespaced rxudp_*, Echo scratch/reply/disposition echo_*.
IPv4 and UDP checksums remain explicit IR expressions. A drop clears that module's
stale data, while unrelated TX data and the pending ARP packet remain unchanged.

RFC792 reverses IP addresses and preserves Echo identifier/sequence/data. This
fixed-link profile additionally returns the Ethernet reply to the admitted
source MAC; this is a declared link policy, not a claimed RFC mandate or an
implicit ARP learning operation. Echo never updates ARP/cache/query timers or
the pending UDP packet. Ingress works in EMPTY/PENDING/RESOLVED; timer processing
retains the inherited same-deadline priority.

## Acceptance

The offline independent struct builder spec/fixtures/ipv4_udp_icmp_endpoint_v1.py
has no IR/reference/compiler imports and is not imported by tests/runtime. Its
literal JSON is frozen before model execution. New scenarios cover mixed RX/Echo,
PENDING ingress preserving queued TX, cache hits, checksum drops/stale clearing,
absent policy, nonzero link padding, truncated/too-short Total Length and MTU.
Negative domains are checked atomically in all three ARP states. Exact output
bytes and timer/queue snapshots must match reference, generated standalone C and
independent fixed-input Z3. Deliberate padding-in-checksum, payload-offset, wrong-reply-MAC and queue-clearing
faults are checked against literal contracts. These are bounded fault controls,
not a universal translation proof.

Initial native runs failed with SIGSEGV: the original generated fire-function
frame measured12,986,128 bytes with -fstack-usage. A temporary exact model
offset/length normalization preserved nine Z3 paths but still failed natively;
that unsuccessful candidate is retained separately. The original clearer model
was restored unchanged (SHA25668e3da058d64460e862f9597ccd7ea4457410b2dcacddf225e1fdbe0702835d1).
Generic per-rule guard/action lowering then passed all nine native/reference/
fixed-input Z3 cases with unchanged default build flags and the original frozen
oracle. Fire measured96 bytes; maximum rule guard/action frames482272/382336
bytes, with main still1038736. No stack-size increase or optimizer flag masks
the failure. All ten new specialized methods passed, including actual native
padding/payload-offset mutants rejected by independent literal bytes. These are
local macOS fixed-input results, not Linux network observations or all-input
proof. Original failed results remain failed.

No new ten-stage flow, all-input safety theorem, live composed ingress peer,
physical Ethernet capture, full ICMP or compiler correctness is claimed here.
Existing all-input UNKNOWN and separate peer evidence remain unchanged.
