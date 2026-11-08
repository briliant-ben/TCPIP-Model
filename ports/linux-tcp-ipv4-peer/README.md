# Composed TCP first-ingress diagnostic

This driver runs **one standalone C process generated from the single composed
Protocol IR** against an ordinary Linux TCP server, on a TAP interface in a new
network namespace. It measures the original peer Ethernet frames and preserves
model rejection. It does not yet verify a complete TCP data exchange, UDP/ICMP
interoperation in that session, or a complete IPv4 endpoint.

The canonical model requires Ethernet padding that may be absent on a virtual
TAP link. A 54/58-byte peer frame is retained unchanged. If it is outside the
model, the diagnostic returns nonzero and reports `model_gap`; the adapter must
not pad packets, force peer policy or call the host stack as the subject. Any
future virtual-link profile needs explicit IR semantics, independent fixtures
and a separate acceptance record.

The workflow `linux-tcp-ipv4-probe.yml` generates and compiles the existing IR,
runs mock failure/lifecycle tests, and starts the diagnostic inside `unshare
--net`. Namespace identity is checked before link setup. The TAP represents the
independent peer `192.0.2.2 / 02:00:00:00:00:02`; the generated subject is `.1`.
No host network or SSH configuration is changed.

A successful result is only `first_ingress_diagnostic_pass`. All results retain
raw frames, original capture, source hashes, model input commands, native session
transcript, process identity and capture stop clocks. The capture must stop
before any peer, subject or TAP close. A failed operation cannot forward frames;
cleanup failures cannot turn into success. Kernel/filter/drop counts, complete
selected byte order and the final capture quiet window are strict gates.

Root performed the generic driver fallback after DeepSeek112 returned an
incomplete API response; that request is not retried. DeepSeek111 source and its
failed unit fixtures remain original evidence. This transport adaptation contains
no TCP/ARP/UDP/ICMP state or packet construction policy: all protocol actions are
still generated from IR. Mock fixtures are transport tests, never Linux evidence.
