# Layer 3: IPv4 Validation, MTU Fragmentation, Reassembly & ICMPv4 Specification

## Scope
Covers RFC 791 IPv4 validation/checksum/2-or-3-fragment TX splitting and RFC 792 ICMP Echo Reply & Port Unreachable generation (`model/stack/eth_ipv4_icmp.json`), plus 2- and 3-fragment in-order and out-of-order reassembly (`model/stack/ipv4_reass.json`, 4-slot table).

## Requirements
- `L3.IP4`: Reject truncated/non-v4/bad-checksum/non-local packets; generate ICMP Echo Replies preserving identifier/sequence/payload; generate ICMP Port Unreachable (Type 3, Code 3) on unmatched UDP ports and TCP RST on unmatched TCP segments; split outgoing payloads exceeding `mtu` into 8-octet-aligned fragments.
- `L3.REASS`: Bounded 4-slot fragment reassembly table (`IDLE`, `COLLECTING`) supporting up to 3 fragments in any arrival permutation (`hdr <= 60` B, each `f0`/`f1`/`f2 <= 1500` B, total reassembled `<= 4500` B) with `5000` ms expiry.
