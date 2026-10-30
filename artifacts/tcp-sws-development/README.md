# Finite sender SWS milestone

Run from repository root with the rebuilt venv:

```sh
.venv/bin/python -m unittest discover -s tests -p test_sws.py -v
.venv/bin/python artifacts/tcp-sws-development/generate.py
.venv/bin/python artifacts/tcp-sws-development/verify.py
.venv/bin/python formal/component_induction.py model/tcp-sws.json --parent model/tcp-nagle.json --property SWS-INV --out artifacts/sws-component-development
.venv/bin/python formal/component_induction.py model/tcp-sws.json --parent model/tcp-nagle.json --property SWS-INV --out artifacts/sws-component-development --verify
TCPIP_SWS_EVIDENCE_DIR=artifacts/lwip-sws .venv/bin/python ports/lwip-sws/tests.py
.venv/bin/python artifacts/tcp-sws-development/accept.py
```

Generation binds all sources and six handwritten byte/order/time contracts. Codec PCAPs here are synthetic only. The separate lwip-sws directory contains three real memory-netif executions, one strict wire match and two retained timing Differences, with all three public sent callback vectors matching. Its run.py returns1 on a valid mismatch; tests.py returns0 when those explicit differences and independent evidence verify. Binaries are ignored and must be rebuilt.

The248 conditional checks and1863 assertion correspondence checks support only the declared new SWS state property assuming222 parent invariants; parent-basis closure and general interpreter/translator/implementation relations remain unproved. Primary depth6 BMC remains unknown. Expiry grants a declared choice opportunity rather than guaranteeing a packet; fairness/mandatory output liveness, actual timer-deadline metadata equality as an IR state invariant, receiver SWS, wire PSH, dynamic MSS and Linux evidence remain open.

Prototype source/query/witness/failure history and invariant-only correction evidence are retained under artifacts/diagnostics/sws-prototype-v1. The old409-test regression excludes new Nagle/SWS tests; the new standard discovery contains430 methods.
