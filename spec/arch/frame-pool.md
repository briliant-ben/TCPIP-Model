# Fixed Frame Pool Accounting Protocol (`frame_pool`)

## Scope
Formalizes static slab accounting (`128` fixed frame slots) for RX/TX framing, ARP pending queuing, IPv4 reassembly, and TCP retransmission/OOO buffering inside the generated stack with zero heap allocation (`malloc`/`free`).

## States
- `ACTIVE`: steady-state pool tracking `free_slots` and `used_slots`.

## Safety Invariants
1. `FP.CONSERVATION`: `free_slots + used_slots == 128`.
2. `FP.BOUNDS`: `free_slots >= 0 && used_slots >= 0`.
