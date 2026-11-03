# Generated IR C with an independent Linux UDP peer

This experimental channel is separate from fixture PCAP/trace validation. Both
subject executables are generated from the unchanged authoritative TX and RX IR;
no Linux stack, handwritten UDP codec or Python protocol callback implements the
subject. The two modules are paired through raw bytes by a test harness, not
claimed as a composed single-stack IR. Cases are the existing literal empty,
odd/NUL and1472-octet transmit inputs. All header/length/checksum/admission and
receive policy remain the existing model's guards/actions. RX uses the explicit RFC6864 atomic-ID overlay: DF1/MF0/offset0 admits any ID
while the original ID0 model stays unchanged. TTL64 and other finite boundaries
remain; actual peer replies outside them are model_gap, never rewritten.

A dedicated ephemeral Ubuntu CI VM enters a new network namespace and verifies
its identity against the real parent before setup. A nonpersistent TUN device
exists only there, with peer192.0.2.2 and route to subject192.0.2.1. The peer is a
normal Linux UDP socket on8080. Its default TTL/PMTU/ID/checksum behavior is not
changed to match IR. Device offload is disabled only on that TUN for strict wire
checksum observation; command/configuration/tool/kernel provenance is retained.
No host routes, interfaces, sysctls or SSH settings are changed.

Actual generated-C ipv4.tx.packet bytes are written unchanged to TUN. Linux
receives them on the peer socket, checksums/decodes in its own stack, and echoes
the declared payload to40000. This is a transport test fixture, not a new upper
application protocol. The kernel's actual raw reply is read from TUN unchanged,
saved, and supplied as the generated RX net.packet event. Reference interpretation
runs only after native observations exist. Peer socket data must equal the frozen
source stimulus, and generated delivery must equal the same bytes.

Independent tcpdump records all UDP packets on the private TUN, without a packet
cap, through a100ms quiet interval. Captured TX bytes must equal original C
emission; RX must equal the original raw TUN read and native ingress. No packet
headers/checksums/payloads are repaired or normalized to force a pass. The parser
supports explicit classic-PCAP RAW timestamp encodings and validates full IP/UDP
checksums with the independent observation decoder. Unselected IPv6 TUN frames
are recorded/classified, not silently misread as UDP; other unexpected replies
fail. Capture stops before the peer socket/TUN close. Logical IR event time0 is a
fixture clock; actual wire timestamps are retained separately and no UDP timing
contract or latency conformance is claimed.

```
sudo .venv/bin/python ports/linux-udp-peer/run.py --out NEW_OUTPUT
sudo .venv/bin/python ports/linux-udp-peer/verify.py --out NEW_OUTPUT
```

Run only in an expendable Linux VM with root/TUN/network namespace support.
Missing prerequisites block only this channel. Runtime verification binds exact
sources, C lowering/compiler/ELF, inputs/stdout, peer records, PCAP, Difference,
tools/kernel and namespace. Offline reconstruction requires the original bound
runtime verifier and trusted CI provenance; hashes are integrity, not authenticity.
It executes no archived native program. Model gaps/differences stay unresolved.
No full IPv4/TCP stack, ARP/ICMP, real Ethernet/physical capture, arbitrary peer,
unbounded checksum/compiler proof or project-server deployment follows.

Local tests use explicitly synthetic unit fixtures and actual C subprocesses for
adapter checks; they are never Linux peer evidence. A first CI run must execute
and pass the runtime gate before this prototype can be called interoperable.

API basis: Linux kernel TUN/TAP documentation describes TUN raw-IP reads/writes
and ephemeral device lifetime (https://www.kernel.org/doc/html/latest/networking/tuntap.html);
Linux udp(7) documents datagram socket send/receive semantics
(https://man7.org/linux/man-pages/man7/udp.7.html). Protocol interpretations stay in
the pinned existing IR sources; this adapter adds no protocol behavior.

The first43f4e3d7 run is retained as failed in
artifacts/linux-udp-peer-failed-43f4e3d7. Socket transfer completed, but all three
nonzero-ID replies were model gaps, and tcpdump saved0 packets despite6 filter
receipts. That capture is invalid and is never promoted. The explicit atomic-ID
IR overlay has independent literals/checksum/repeated-ID/non-atomic negatives;
no special case names a kernel-observed ID. Capture now requires immediate mode
to deliver buffers before the unchanged100ms quiet boundary. This changes no
packet bytes, timing tolerance, drop accounting or count oracle.
