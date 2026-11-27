# OSAL Synchronization & Port Protocol (`sys_port`)

## Scope
Defines the formal single-instance behavioral contract for OSAL synchronization objects (`sys_sem_t`, `sys_mbox_t`) across `TCPIP_NO_SYS=1` (`port/nosys/`) and `TCPIP_NO_SYS=0` (`port/posix/`, `port/freertos/`).

## States
- `UNINIT`: storage zeroed, capacity `0`, tokens `0`, waiters `0`, timer inactive.
- `ACTIVE`: initialized with `1 <= cap <= 64`, `0 <= count <= cap`, `0 <= waiters <= 32`.
- `CLOSED`: disposed; tokens `0`, waiters `0`, timer inactive.

## Safety Invariants
1. `SYS_CAP_BOUNDS`: `0 <= cap <= 64`.
2. `SYS_COUNT_BOUNDS`: `0 <= count <= cap`.
3. `SYS_WAITER_BOUNDS`: `0 <= waiters <= 32`.
4. `SYS_WAITERS_NO_TOKENS`: `(waiters == 0) || (count == 0)` — a thread never remains blocked while a token/slot is available.
5. `SYS_CLEAN_WHEN_INACTIVE`: `state == ACTIVE || (count == 0 && waiters == 0)`.
