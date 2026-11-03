# Real isolated Linux UDP peer evidence

Subject checkpoint b10fca8dd5287552f61b415ad5cf614a93a24b3a; tested merge
 d2d9fa03fc019ecb6f79790b7cfe2381ed16cddf has the identical Git tree. Reachable
head source is used for portable audits. Run41568756821/job125696495591,
artifact13199869218, SHA256
0b2fb5daf2757ff9d92d391f62dfc701335ba1a420094ff2d2fe1e2b55e825bf.

Actual Linux7.0.0-1017-azure in a distinct network namespace: generated C TX
writes original complete IPv4/UDP bytes to a nonpersistent TUN; independent Linux
UDP socket receives and echoes empty, odd/NUL and1472-byte payloads; generated C
atomic-ID RX accepts unchanged kernel reply bytes and delivers exact payloads.
Independent tcpdump captures six actual IPv4/UDP packets,6 filter receipts,
0 drops. Runtime verification passes. Linux default IDs/TTL/PMTU and packet bytes
are not forced/rewritten. This is actual Linux virtual-interface execution,
not synthetic fixture PCAP or physical Ethernet capture.

Original ZIP retains370 files,82 immutable Git source bindings, C/ELF/stdin/
stdout/raw TUN bytes/PCAP/kernel/tool/namespace/config/log/Difference, plus the
atomic-ID IR flow (22 cases/6 literal trace steps/9 model gaps; depth2 payload/
drop-empty safety and overlap UNSAT) and5 actual native/fixed-input exact Z3
cases with original SMT/result/hash. The five adapter and four atomic methods
also run in Linux. The old ID0 IR, source oracles and hashes remain unchanged.
The new ID-independent atomic policy is an explicit RFC6864 IR extension, not
an observer callback. IP checksum still includes the original actual ID bytes.

```
.venv/bin/python artifacts/linux-udp-peer-b10fca8d/accept.py
```

Audit exports exactly82 original named Git blobs, checks artifact/source/tree
hashes, invokes that source's offline peer verifier and pipeline checker,
reconstructs all6 network/model/native byte bindings and Differences, then
rerenders/recompares5 fixed native cases and checks all original symbolic query/
result hashes. It executes no archived Python/ELF or fresh solver/native code.
The saved original runtime gate and external trusted CI provenance are required;
hashes alone are not execution authenticity. No new Linux run is claimed by this
local audit. The failed43f4e3d7 capture/model gaps stay unaccepted in their own
immutable artifact; no retrospective promotion.

This is two IR modules paired by a byte harness, not a single composed endpoint
IR, general IP/UDP/TCP, ARP/ICMP, arbitrary peer or full protocol implementation.
Wire timestamps are retained independently of logical IR event time0; no UDP
latency contract. No universal checksum/compiler or unbounded proof follows.
Project server192.168.71.74 remains connection-refused and is not deployed here.
No paid model API calls, upstream patches or weakened packet/hash/tolerance gates.
