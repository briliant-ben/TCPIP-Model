# 1. Specification and acceptance inputs

Official text is retained in [sources/](sources/). The case study pins the exact
source files and independent scenario/oracle inputs in
[the final task](../flows/ipv4-prototype-closeout.json). Source clauses and the
modeling interpretation are explicitly associated with IR requirements.

| Topic | Pinned source | Case-study interpretation |
|---|---|---|
| Ethernet/ARP | RFC826, RFC894, RFC1122 | Single peer, explicit cache/retry and Ethernet layout |
| IPv4 | RFC791, RFC6864 | Atomic datagrams; fixed profile, no fragmentation/reassembly |
| UDP | RFC768, RFC1122 | Length/checksum policy and exact byte delivery |
| ICMP Echo | RFC792, RFC1122 | Finite Echo request/reply slice |
| TCP | RFC9293, RFC6298 and inherited scope notes | Finite connection/data/close, fixed buffers and timers |

The authoritative full profile is [the virtual-link model scope](../docs/ipv4-endpoint-virtual-link.md).
The `*-oracle.json` files are independent fixed acceptance data; they are not
regenerated from a candidate model to make it pass. Earlier oracle versions
belong to their named profiles, not automatically to the final model.

These files may contain historical wording or non-English annotations. Their
bytes are deliberately preserved: translating a pinned input would create a new
source version and require reapproval. Current presentation guides are English.

Next: [Protocol IR](../model/README.md).
