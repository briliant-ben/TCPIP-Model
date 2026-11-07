# UDP/IPv4 header-descriptor migration case

This second specification exercises the unchanged generic flow with a different
protocol, event/message schemas, Boolean configuration, arithmetic, discard rules
and independent output contracts. It is a finite UDP header/service descriptor
model, not a UDP stack or byte-preserving datagram implementation. It provides no
UDP PCAP evidence; the separate TCP task supplies the first native IPv4 wire gate.

## Specification versions and interpretation

- RFC768, 28 August1980, Fields page1: source port zero denotes an unused source
  port. Fields page2: UDP length includes its eight-octet header and data; checksum
  zero denotes absent checksum. User Interface page2 motivates send/receive
  descriptors. Protocol Number page3 identifies UDP as IP protocol17.
- RFC1122, October1989, section4.1.3.4 page78: default checksum generation on;
  optional application control; silently discard received nonzero invalid
  checksums. This IPv4 profile chooses to deliver checksum-absent datagrams.
- Both full official source texts are pinned in the task. Structural clause/hash
  binding records an interpretation; it does not prove the English-to-IR step.

## Scope and input contract

`model/udp-header.json` is the only authority for the modeled decisions. It
contains all guards, ordered assignments, emissions, counters, invariants and
requirement references. No UDP Python callback or independent hand-coded UDP
transition implementation is added to the interpreter, solver or native backend.

One prebound local receive port8080 and a fixed validated IPv4-address context are
assumed. Ports and checksum are represented by integers constrained by IR guards;
`available_length` is the number of available IPv4 payload octets, at most65515
for the selected no-IP-options profile. `sum_valid` is an explicit input fact from
an assumed checksum validator. The model does not compute or prove checksum
arithmetic. IPv6's checksum rules, invalid IP addresses, fragmentation/options,
ICMP/port-unreachable behavior, binding lifecycle and queues/socket APIs are
excluded. A different receive port or impossible header-domain values produce a
model-gap rejection, not a silently modeled drop or RFC response.

A UDP length below8 or beyond available bytes is discarded by an explicit parser
profile rule. Extra available bytes do not become UDP data: delivered descriptor
length is the declared UDP length minus8. A nonzero invalid checksum is silently
discarded without network/application emission; internal counters are diagnostic.
Repeated valid datagrams may each deliver a descriptor; no duplicate suppression,
reliability or delivery guarantee is introduced. Source port zero is admitted.

The send service emits source/destination ports, total length and checksum-presence
metadata. It defaults checksums on, supports explicit on/off configuration, and
admits payload lengths0..65507. Larger/negative requests produce an explicit local
profile error. Payload byte content/copying, checksum zero-to-65535 serialization,
raw UDP/IP encoding and real datagram delivery are excluded; metadata agreement
must never be described as proving any of them.

## Acceptance

Run `protocol_lab.pipeline run flows/udp-header.json --workspace . --out NEW`
with an independently approved `--task-sha256`, then retained `verify`. The same
fixed ten stages and backends must run without UDP-specific executor changes.
Bounded exploration must cover all seven declared rules and retain wrong-port/
impossible-port model-gap negatives. Three pinned scenario0.2 fixtures fix literal
send lengths/default flags, zero-source-port/zero-checksum acceptance, silent
checksum/length discard, extra-IP-byte length interpretation, duplicate delivery
and upper bounds. Those expected messages are not computed from candidate IR.

Z3 safety/overlap checks are depth-bounded relative to the declared IR and input
abstraction; UNKNOWN cannot be promoted. Correct native/reference agreement alone
does not establish normative completeness. Fault variants must show that an
incorrect checksum-zero policy or send-header length is rejected by independent
contracts, and unsupported new semantics remain explicit backend rejection.
