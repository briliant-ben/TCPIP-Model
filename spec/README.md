# Specification

[sources/](sources/) contains the exact RFC/Linux-link source versions used by
this example. [references.json](references.json) maps each model requirement to
its source hash, clause and immutable original document.

The IR retains its original source identifiers. References to interpretation
notes at former paths resolve through this map to pinned Git documents; they do
not refer to a second model or an implicit protocol implementation.

The supported profile is fixed peer/tuple, Ethernet/ARP, atomic IPv4 MTU1500,
UDP, ICMP Echo and finite TCP buffer16/SMSS4. This is an experimental reference
slice, not an assertion of complete TCP/IP conformance. Source bytes are not
translated or rewritten to match a candidate.

Next: [model](../model/README.md).
