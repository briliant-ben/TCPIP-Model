# Finite ARP + IPv4/UDP transmit composition

This is the first explicit cross-layer slice, not a complete IPv4 endpoint. One
expanded IR0.5 EFSM owns ARP/cache/retry timers, a latest-packet pending slot,
UDP/IP byte construction and Ethernet output. No adapter/Python protocol dispatch
or host stack joins models. `model/arp-udp-transmit.json` declaratively extends
unchanged arp-endpoint.json through existing rule removal and explicit disjoint
QUEUED/UNQUEUED rule expansions; preserved action prefixes are checked. Its UDP
construction AST is explicit, with regression checks against the unchanged
udp-wire-transmit.json guard and twelve set actions. The latter is a pinned
component reference, not another runtime oracle or independently executed model.

## Sources and scope

RFC826 Packet Generation/Reception and RFC1122 October1989 §§2.3.2.1/2.3.2.2:
save at least the latest packet to each unresolved destination, and transmit it
once resolved. Here there is one fixed peer, one latest-packet slot. New accepted
sends replace the queued packet without resetting ARP retry budget. Defaults and
raw ARP admission are exactly inherited: local192.0.2.1/MAC020000000001,
peer192.0.2.2 with admitted source MAC prefix02; EMPTY/PENDING/RESOLVED;
1000ms once retry, failure2000ms, cacheTTL60000 configurable through3600000.
These constants are profile choices. Timer deadlines precede same-time external
events. ARP-only query without a UDP packet still behaves exactly as before.

UDP/IP headers are the existing fixed transmit profile:40000→8080, TTL64,
DF1/MF0/off0/ID0, no options, IPv4 MTU1500/data<=1472, RFC768/791/6864 and
RFC1122 §4.1.3.4. Checksum generation defaults on, optional disable; computed UDP
zero usesFFFF. Packet bytes/checksum policy are frozen when app.send is accepted;
a later configuration change never re-encodes an already queued datagram.

RFC894 April1984 Frame Format/address mapping: EtherType0800, learned destination
MAC, local source MAC, IP datagram followed by zero padding to at least46 payload
bytes. Padding is excluded from IP/UDP lengths/checksums; full frames60..1514
without FCS. Original RFC894 text's1500 minimum typo is interpreted using official
verified erratum570 (maximum1500), separately pinned; original text not edited.

## Events, queue and output order

app.send(data) in EMPTY builds the full IP/UDP bytes, queues them and starts ARP.
In PENDING it replaces the slot, preserving retry_count/query deadline. RESOLVED
builds and emits an Ethernet IPv4 frame immediately. Successful local ARP receive
merges peer MAC and completes inherited actions first, then conditionally emits
one queued IPv4 frame and clears the slot. If that receive is a simultaneous
ARP request, output order is ARP reply, inherited neighbor.resolved, IPv4 frame.
No IPv4 emission on nonlocal ARP while PENDING. Duplicate replies never resend a
cleared slot. Expired cache is processed before a same-time app.send, which queues
and starts fresh ARP rather than using stale MAC.

ARP failure emits inherited neighbor.failed, then udp.send_failed(reason=arp_timeout)
only if a packet was queued, and clears the slot. Empty UDP data is a real28-byte
queued IP packet, not absence of a packet. Over-MTU input remains atomic model_gap
in every state; no fragmentation/drop oracle or timer reset is silently added.
All ingress network frames remain the inherited finite ARP profile; IPv4 receive,
UDP receive/demux, ICMP/TCP, general routing/PMTU/options/fragments, multiple peers,
general caches/socket service and physical/Linux composed peer are not included.

## Acceptance

Seventeen independent struct-built scenarios are frozen before IR execution:
cold/empty/cached, replacement/latest, loss/retry/failure, same-time retry/expiry,
checksum-policy freeze, unsolicited learning, ARP-only resolution, simultaneous
requests, no stale replay, MTU, one/no padding, UDPzeroFFFF, empty replacement and
nonlocal peer handling. Thirteen original ARP scenarios must replay unchanged on
the composition. Relevant formal bounds/results must be reported from actual
runs: declared state/timer/queue/packet-size contracts are not universal wire
checksum/compiler correctness. Tests use literal frame/time/queue expectations,
positive/reference/independent fixed-input Z3/actual C and deliberate queue/MAC/
ordering/policy faults. A virtual generated-frame trace or PCAP is not live Linux
Ethernet-peer evidence; that channel needs separate isolated execution/capture.

## Separate invariant induction acceptance

The current task explicitly uses schema v4/sequence-invariant-induction; see
sequence-invariant-induction.md for assumptions and trusted components. One
initial-validity UNSAT, one initialization SAT,30 full-Seq preservation UNSAT,
30 rule nonvacuity SAT and4 overlap UNSAT obligations are required (66query files).
This is not a changed answer to the original depth3 BMC: its safety UNKNOWN and
overlap UNSAT remain in arp-udp-bmc-linux-f4417ab1. No protocol guard/action, input
domain, invariant or frozen byte expectation is weakened. The distinct induction
claim only concerns listed contracts on defined legal transitions. It does not
prove output-byte correctness, event coverage, compiler/scheduler correspondence
or a complete protocol. Independent literal/native/peer checks remain necessary.
