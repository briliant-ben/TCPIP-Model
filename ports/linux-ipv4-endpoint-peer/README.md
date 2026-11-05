# One generated IPv4 UDP/ICMP subject with an independent Linux peer

This channel uses `model/ipv4-udp-icmp-tap.json`: an explicit virtual TAP ingress
profile derived from the unchanged canonical Ethernet model. Short IPv4 frames
are admitted only at their exact unpadded IP length or the canonical Ethernet
length; partial padding remains outside scope. The adapter never pads, strips,
rewrites or regenerates the bytes delivered to the subject.

On a disposable Linux host with root, TAP, iproute2, tcpdump, ethtool,
iputils-ping, C99 and the formal requirements:

```
sudo .venv/bin/python ports/linux-ipv4-endpoint-peer/run.py --out artifacts/linux-ipv4-endpoint-peer
sudo .venv/bin/python ports/linux-ipv4-endpoint-peer/verify.py --out artifacts/linux-ipv4-endpoint-peer
```

One generated C PID performs cold ARP resolution and queue flush, four UDP
round trips (cold four-byte data, cached empty, odd/NUL and1472 bytes), and
three iputils Echo replies (empty, odd/NUL and1472 bytes). The independent Linux
UDP socket sends back exactly the payload it actually receives, using ordinary
`sendto`. Kernel TTL/ID/PMTU defaults are not forced to match the model; a packet
outside its declared profile is a model gap. Ping uses declared atomic probes
with `-4 -M do` and3600-second intervals so sockets remain open during capture.
The link test identities are192.0.2.1/MAC020000000001:40000 and
192.0.2.2/MAC020000000002:8080, MTU1500. Link offloads are disabled explicitly to
observe complete original checksums; no packet is repaired in the adapter.

A distinct namespace is proven before any `ip`/link operation. Independent
immediate tcpdump has no packet cap. Acceptance requires16 selected original
Ethernet frames, zero capture drops, a complete100ms quiet observation, exact
C/TAP/PCAP byte bindings, independent checksum/field decoding, exact UDP socket
and `udp.rx` deliveries, all three successful ping statistics, one initialization
and C PID, mechanical monotonic/public-timer clock sampling, and full reference
trace equality. All peer sockets, ping processes, C and TAP remain alive until
capture stops. Echo expected bytes are constructed independently only during
post-exchange assessment, never supplied to the subject. A separate Z3 query
replays the actual12-input continuous trace after live exchange completes.

Source/model/tools/generated C/compile/executable hashes, raw frames, original
PCAP, selected/unselected ingress, process/clock/operation transcripts, socket
observations and failures are retained. `verify.py --offline` reconstructs their
bindings with the original checker and requires the original runtime result and
trusted CI provenance; it executes no archived program or solver and is not a
new Linux run. Matching hashes alone do not establish provenance.

Six unit methods run real generated C against explicitly synthetic peer/capture
fixtures, test checksum/partial-padding/ingress/PID/lifecycle/delivery corruption,
and replay the entire fixed trace in independent Z3. They are not Linux peer
evidence. The workflow also checks the supplementary ICMP induction task; that
separate listed-invariant theorem does not promote old BMC UNKNOWN results.

This remains a finite one-peer virtual Ethernet IPv4 UDP/Echo integration.
TCP, ICMP errors, general addressing/routes/ports, fragmentation, options,
physical Ethernet, live loss/cache-expiry tests, full protocol correctness and
compiler correctness are not claimed. Actual PCAP time and logical IR time
remain separate; no wire latency equivalence contract is asserted.
