# Basic Nagle policy — development scope

`model/tcp-nagle.json` composes the sent-segment ledger and all parent TCP
connection/data/ACK/window/close/recovery semantics. Protocol decisions remain
explicit JSON guards/actions. Effective send MSS is fixed at four bytes.

Normative basis is RFC9293 August2022 §3.7.4 (SHLD-7/MUST-17). With data in
flight, an explicit new-data choice must be four bytes unless Nagle is disabled;
the ordinary parent cwnd/rwnd/buffer budget still applies. The same full-sized
condition gates automatic Limited Transmit without suppressing ACK processing,
incrementing callback credit, growing cwnd or restarting its existing timer.
Full ACK can unblock a queued short segment; partial ACK cannot empty remaining
flight. Retransmission/persist probes retain the shared parent behavior.

`app.nodelay(enabled: bool)` exposes the disable option in ESTABLISHED/CLOSE-WAIT.
The option changes no bytes, ACK credit or output opportunity itself. A subsequent
transmit/accepted ACK supplies the existing scheduling opportunity. Each new
active/passive open restores default Nagle. This finite API is a modeling choice,
not a claim about when a production socket setsockopt must call tcp_output.

This basic policy deliberately does not encode lwIP's unsent-node-count,
memory-pressure, FIN or fast-recovery exceptions. Source inspection of pinned
lwIP2.2.1 `tcp_priv.h:92-105` and `tcp_out.c:1340-1350` identifies those variations;
they must be separate declared policies if modeled. Complete sender SWS avoidance
and its override timer (RFC9293 §3.8.6.2.1), arbitrary effective MSS, general
allowed output/time/implementation relations and Linux evidence remain open.

The old models, captured PCAPs, canonical oracles and Differences are retained.
Development tests/queries do not imply that the 409-test frozen parent regression
contains this new overlay. This module is not registered or accepted as complete.
