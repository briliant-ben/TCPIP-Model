# OS Port Synchronization Protocol (`sys_port`)

## Scope
Formalizes the host OS port lifecycle (`UNINIT`, `READY`, `STOPPED`) and live resource accounting (`sem_live`, `mbox_live`, `threads_live`) used by the thin host runtime (`code/host_runtime.{h,c}`) across `FSA_HOST_NO_SYS=1` (polled), `FSA_HOST_NO_SYS=0` (POSIX threads), and FreeRTOS port targets.

## States
- `UNINIT`: host OS port uninitialized.
- `READY`: OS primitives may be allocated/freed within static bounds.
- `STOPPED`: host OS port shut down cleanly.

## Safety Invariants
1. `SP.SEM_BOUNDS`: `0 <= sem_live <= 256`.
2. `SP.MBOX_BOUNDS`: `0 <= mbox_live <= 256`.
3. `SP.THR_BOUNDS`: `0 <= threads_live <= 64`.
