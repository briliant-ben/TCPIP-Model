# Linux finite raw IPv4/UDP receive release

PR13 headf266e4ac0cd26ab22389081a432986350ac4c53d; actual tested GitHub merge
040addc0ce03ce7078c9cd16a2a06bc6a056cd86. Git trees were fetched and checked equal;
provenance.json records the tree. Reachable head source is used for portable audit.
Original artifact13184583736/run41538066860/job125594895419 is release.zip,
SHA25685bda7d5f1e1844cdb699b14fa98f2a653b6c544203de4013ade7883cb75ee2b.

Actual isolated Ubuntu24.04 release:260 immutable source files,111 specialized
methods, eight complete task runs/verify, retained15-data native/fixed-Z3 and101
connection cases, plus nine native UDP transmit packets against six packet oracles.
2161 raw ZIP files include bundle/source bindings, bootstrap source/log, generated
C/ELF, raw ingress/native delivery/stdout, SMT/results, Difference and traceability.
Receive task:27 cases (8 witnesses+12 literal seeds+7 model gaps),13 literal
trace steps; all eight rules covered within64-prefix exploration; depth2 safety/
overlap UNSAT only for declared payload-bound/drop-empty contracts. Linux tests
also perform12 fixed-input Z3 replays; separate12 raw SMT/result/native records
are retained in the local source79d evidence, not relabeled as Linux query files.

```
.venv/bin/python artifacts/udp-receive-linux-ci-f266e4ac/accept.py
```

Audit checks ZIP/inner release hashes, all260 Git blobs and builder/bootstrap
sources, reverifies eight jobs, rerenders/recompares116 TCP observations and all
nine UDP transmit packet traces/oracles, and checks15 TCP fixed-input query/report
hashes. New receive raw input/output evidence is validated through the original
Git ten-stage checker. No archived Python/ELF/solver is executed; it is a retained
CI audit, not a fresh Linux run or proof of execution authenticity. CI provenance
must be trusted separately. Earlier full TCP safety queries stay byte-identical.

This is an IR-generated raw-byte receive entry under the pinned finite tuple/
header/MTU profile. No real UDP peer, new UDP wire capture, transmit/receive/TCP
composition, ARP/ICMP or full modern IPv4 endpoint follows. The existing send
PCAP is virtual-link output, not physical/Linux UDP peer capture. Project server
192.168.71.74 still times out; this successful release is on GitHub's runner.
No private credentials, paid API calls, hash/oracle relaxation or stack patching.
