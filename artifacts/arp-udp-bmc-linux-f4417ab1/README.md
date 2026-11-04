# Original single-IR Linux native pass and unresolved depth3 BMC

Sourcef4417ab1 / tested mergec3d8af4b have identical full Git trees.
Run41746259405 native job126299910997 passes25 related methods and30 actual
standalone-C/exact fixed-input Z3 scenarios (17new+13originalARP). Flow job
126299910721 remains unresolved: safety UNKNOWN/overlap UNSAT at depth3/10s.
All other nine stages pass93cases=30witness+30seed+33gap,80 literal-contract input
steps (48new/32old;83 expected trace rows),30rules within600prefix/resourcecutoff.

flow.zip artifact13284515125 retains694 files, SHA76b38082bf94afac260aad005b86a5408056c94401f052be672e8814bf1dcc75.
native.zip artifact13284001749 retains259, SHAecc69d15df272b6fab64ef54a2077b29d5e10bbf6f0a2d6c91b0b503d0ff781a.
accept.py exports94 original immutable Git blobs, verifies both archive sets,
old flow integrity without promoting its UNKNOWN,30 full native traces/ELFs/IR C,
30 original fixed-input SMT/reports and18 generated Ethernet IPv4/UDP frames.
No archive Python/ELF/solver or fresh Linux execution; CI provenance separately
trusted. These are Linux-generated frame bytes, not live network capture/peer.

The follow-up uses a separately declared full-sequence invariant induction
strategy with unchanged model/native/byte oracle. No claim that this original
BMC query passed, no length projection or concrete test restriction of safety.
