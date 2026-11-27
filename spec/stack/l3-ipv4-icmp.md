# Layer 3: IPv4 Routing, RFC 815 Fragmentation/Reassembly & ICMPv4 Specification

## Scope
Covers IPv4 packet validation, RFC 1071 checksum verification, outgoing MTU fragmentation, RFC 815 hole-tracking reassembly (`ip_reass_slot.json` / `ip_reass_fsm`), and ICMPv4 Echo / Destination Unreachable / Time Exceeded generation.

## Requirements
- `L3.IP4.CHECK`: Reject packets shorter than 20B, with version != 4, IHL < 5, `tot_len > p->tot_len`, or bad IPv4 header checksum.
- `L3.IP4.FRAG`: Packets exceeding `netif->mtu` (when DF=0) are split into 8-octet-aligned fragments copying IP header + original options as needed; if DF=1, drop or send ICMP Fragmentation Needed.
- `L3.IP4.REASS`: Each active datagram uses one static slot (`TCPIP_IP_REASS_MAX_SLOTS = 4`, max payload `TCPIP_IP_REASS_MAX_LEN = 8192`). Duplicate/overlapping fragments are tolerated up to `frag_count <= 32`. Completion occurs iff last fragment (`MF=0`) arrived and `rcv_bytes == tot_len`. A 30s timeout reclaims incomplete slots back to `FREE`.
- `L3.ICMP.REPLY`: Valid ICMP Echo Requests receive Echo Replies preserving identifier, sequence number, and payload; closed UDP ports trigger ICMP Port Unreachable (Type 3, Code 3).
