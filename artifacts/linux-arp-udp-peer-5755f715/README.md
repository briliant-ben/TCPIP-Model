# First real single-IR ARP → IPv4/UDP transmit exchange

Source5755f715 and tested merge224a394a have identical complete Git trees.
GitHub run42014504643/job127201517338 actually passed on isolated
Linux7.0.0-1017-azure. One generated C PID2960 initialized once, sent ARP for a
cold four-byte datagram, accepted the original kernel ARP reply and automatically
flushed the pending IPv4/UDP Ethernet frame. Cached empty, odd/NUL and1472-byte
sends followed. The recv-only Linux UDP socket delivered all four exact payloads.

Independent immediate tcpdump captured6/filter6/drops0 frames; full quiet
100.0847ms exceeded the required100ms. Capture stopped before C/socket/TAP close.
Original C/TAP/PCAP bytes, complete native/reference traces and a separate actual
five-input-step fixed Z3 query/witness match. This is one query, not five
all-input proofs. The supplementary ICMP ten-stage task and13 invariant
obligations also passed; old ICMP BMC UNKNOWN is not changed.

The original GitHub ZIP has330 files, artifact13407873966,
SHA25605d5000af40390bdb949c8da877be2b750a0a2046d28052728bce422e33835c1.
`provenance.json` binds121 original Git blobs covering both jobs' input sets.
`accept.py` exports only those Git sources, safely extracts the raw evidence,
reconstructs the original runtime bindings and complete ICMP flow offline.
It executes no archived Python, C executable or solver. Trusted CI provenance
is still needed; the audit is not another Linux execution or an attestation.

Recheck with `.venv/bin/python artifacts/linux-arp-udp-peer-5755f715/accept.py`.
Use the reachable named source, not later changed checkers or expired PR refs.

Scope is finite virtual Ethernet, one fixed peer/tuple, outbound UDP and ARP
ingress. No composed inbound UDP/ICMP/TCP, physical Ethernet, live loss/expiry,
full endpoint or compiler correctness is claimed. No project-server deployment
or new paid model call occurred.
