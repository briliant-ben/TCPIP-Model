# Demo, Live Captures & Benchmarks

## 1. 10-Module Generated Stack Live Demo & Benchmark (`stack_demo.py`, `stack_bench.c`)

Run two live instances of the generated C99 stack (`code/generated/stack/`) over
real `127.0.0.1` POSIX UDP sockets exercising DHCPv4 DORA, ARP, DNS A lookup,
ICMP Echo, UDP echo, and two concurrent TCP streams, writing a standard Ethernet
`DLT_EN10MB` PCAP trace:

```sh
python3 demo/stack_demo.py --out /tmp/tcpip-stack-demo
tcpdump -nn -r /tmp/tcpip-stack-demo/stack-live.pcap
make stack-bench OUT=/tmp/tcpip-stack-out
```

## 2. Preserved v1 Live Prototype & Historical Recording (`live_demo.py`, `build_review.py`)

```sh
python3 demo/live_demo.py --out /tmp/tcpip-live-001
tcpdump -nn -v -r /tmp/tcpip-live-001/live-capture.pcap
python3 demo/build_review.py
```

[review.html](review.html), [capture.pcap](capture.pcap), [recording.zip](recording.zip),
and [provenance.json](provenance.json) preserve the original v1 Linux TAP capture and
trace viewer unchanged.
