# Finite sender SWS avoidance

The authoritative `tcp-sws` IR composes `tcp-nagle`, the sent-segment ledger,
ACK/window/data/close and recovery chain. RFC9293 August2022 §3.8.6.2.1 MUST-38
requires sender SWS avoidance; this module instantiates the recommended maximum
window algorithm with fixed effective send MSS4 and Fs=1/2. Current accepted
window and historical maximum remain distinct, including window shrink. All
decisions, variables, push-prefix bookkeeping and timer actions are JSON IR.

Normal first-send choices and automatic LT must select a full-sized segment,
send all queued pushed data, send at least half the historical maximum window,
or have an expired override authorization. Short push/fraction sends additionally
need no flight or disabled Nagle. Actual selected-prefix size is checked, avoiding
an otherwise arbitrary tiny choice when enough bytes could fill a segment.
Timeout only relaxes SWS: parent Nagle, cwnd and rwnd gates remain in force.
Retransmissions and zero-window probes keep their distinct shared parent policy.

The override is a separate `sws` timer, default200ms and configurable100..1000ms.
The first pending transmit, accepted ACK, push or close request begins an epoch;
more writes/requests do not postpone it. Actual first-send progress begins a new
epoch for remaining queued data. Queue depletion, reset and leaving send-capable
states clear the timer and readiness. Expiry grants a same-time scheduling
opportunity, not an automatic packet, and readiness persists until progress or
cleanup. An explicit tick can expose that opportunity before a selected choice.
Unusable windows/budgets can still block output; fairness is not proved.

`app.push` marks the current queued prefix in ESTABLISHED/CLOSE-WAIT and grants
an opportunity. Later writes do not inherit that prefix's pushed status. Close
marks its current queued prefix similarly. This is finite application coalescing
intent; the current wire schema has no PSH flag. No production socket API timing
or observed hidden lwIP call causality is implied.

The invariant records why normal data was permitted, maximum-window history,
push-prefix bounds, timer ownership and expiry metadata. The current IR has no
timer-deadline expression: metadata/actual deadline equality is not a standalone
state invariant. Arm actions and the expiry guard use the declared metadata;
exact timed reference/SMT traces and early/late-arm faults test that relation.
State/length checks alone do not prove a universal timer implementation bridge.

Dynamic MSS, window scaling, arbitrary queue capacities, wire PSH, lwIP queue-node
and FIN/memory-pressure/recovery variations, Linux evidence and general refinement
remain excluded. Old model profiles/oracles and the2750ms differences are retained.
This is an unregistered development overlay; acceptance must distinguish finite
scenarios, conditional preservation, parent unknowns and any implementation gaps.
