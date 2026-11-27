# Zero-Copy Packet Buffer Ownership Protocol (`pbuf_pool`)

## Scope
Formalizes `struct pbuf` lifecycle, reference counting, headroom reservation, and queue handoff between RX/TX drivers, protocol layers, and `memp` slab allocators.

## States
- `FREE`: unallocated slab entry (`ref == 0`, `queued == false`, `len == 0`, `headroom == 0`, `cap == 0`).
- `OWNED`: uniquely owned (`ref == 1`, `!queued`).
- `SHARED`: shared ownership via `pbuf_ref()` (`ref >= 2`, `!queued`).
- `QUEUED`: enqueued in an ARP pending queue, IPv4 reassembly list, TCP unacked/OOO list, or mbox (`ref >= 1`, `queued == true`).

## Safety Invariants
1. `PBUF_REF_CONSISTENCY`: `ref` strictly matches lifecycle state (`FREE => ref == 0`, `OWNED => ref == 1`, `SHARED => ref >= 2`, `QUEUED => ref >= 1 && queued`).
2. `PBUF_SLICE_BOUNDS`: `0 <= headroom`, `0 <= len`, `headroom + len <= cap <= 2048`.
3. Every `pbuf_free()` decrements `ref` by `1` and returns the slot to `FREE` only when `ref` reaches `0`.
4. Prepending L2/L3/L4 headers (`header_delta < 0`) requires `-header_delta <= headroom`; stripping headers (`header_delta > 0`) requires `header_delta <= len`.
