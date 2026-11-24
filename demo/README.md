# Demo & packet captures

This directory provides both a **live communicating demo** for the current
C99 executable and the **retained historical recording** from the original Linux
TAP experiment.

## Live communicating prototype (`live_demo.py`)

Run a live client + server IPv4/TCP/UDP/ICMP/ARP session against an independent
wire peer over `127.0.0.1` UDP loopback sockets (falling back to an `AF_UNIX`
`socketpair` only when `AF_INET` sockets are denied by a restrictive sandbox):

```sh
python3 demo/live_demo.py --out /tmp/tcpip-live-001
tcpdump -nn -v -r /tmp/tcpip-live-001/live-capture.pcap
# or open /tmp/tcpip-live-001/live-capture.pcap in Wireshark
```

Useful flags:
- `--mode all|client|server`: exercise TCP active open + UDP/ICMP (`client`), passive TCP echo server (`server`), or both (`all`, default).
- `--transport auto|udp|unix`: `udp` requires real `127.0.0.1` UDP loopback sockets with no fallback; `--port-a` / `--port-b` pin fixed UDP loopback ports for live host sniffing.
- `--mode tap --tap <ifname> --duration 15`: bridge the compiled C stack (`T.app.listen`) to a Linux `/dev/net/tun` TAP interface and record real kernel TAP traffic into `live-capture.pcap`.
- Custom payloads: `--client-message`, `--server-message` (1..16 bytes, matching `T.local_window`), `--udp-message`, `--icmp-message`.

Each run writes `<out>/live-capture.pcap` (`DLT_EN10MB`), `<out>/frames.txt`,
`<out>/tcpdump.txt` (when `tcpdump` is installed), and `<out>/summary.json`.

## Retained historical Linux TAP recording (`build_review.py`)

Open [review.html](review.html) locally for 19 actual transitions and 25 original
packets from the pre-optimization Linux TAP recording. Expand a transition to inspect
its IR rule/actions/source references, or a packet to inspect its raw bytes.
[capture.pcap](capture.pcap) opens directly in Wireshark.

```sh
python3 demo/build_review.py
```

The viewer reads only the original [recording.zip](recording.zip), verifies its
fixed digest and model/packet/trace bindings, and renders HTML. It never runs
archived Python or native binaries. [provenance.json](provenance.json)
records the original source, hashes and trust boundary.

Logical C time and measured capture time remain separate. Regenerating
[review.html](review.html) is not a new network execution or proof. The live
prototype (`live_demo.py`) exercises the current optimized C binary (`code/generated/protocol.c`)
in local loopback or TAP bridging, whereas the archived `recording.zip` / `capture.pcap`
retains the pre-optimization C hash in `provenance.json`.
