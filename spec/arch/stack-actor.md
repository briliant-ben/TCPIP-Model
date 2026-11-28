# Single-Writer Stack Actor Protocol (`stack_actor`)

## Scope
Formalizes the single-writer stack actor loop (`STOPPED`, `IDLE`, `DISPATCHING`) coordinating inbound frame RX events, application API events, and timer ticks without internal locking inside generated protocol state machines.

## States
- `STOPPED`: actor inactive (`q_depth == 0`).
- `IDLE`: actor idle waiting on mailbox/poll/timer deadline (`0 <= q_depth <= 64`).
- `DISPATCHING`: actor currently executing a deterministic state-machine batch.

## Safety Invariants
1. `SA.Q_BOUNDS`: `0 <= q_depth <= 64`.
2. `SA.TOT_NONNEG`: `dispatched_total >= 0`.
