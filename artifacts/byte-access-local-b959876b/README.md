# Byte-access local evidence, b959876b

Immutable source: b959876b8a7e1212be097be7399872c464cd063d. Source closure:
241 named Git blobs in release.json; package hash in build.json. No credentials.

Actual macOS Python3.12.14/Apple clang execution:103 specialized methods,6
server-deployment methods (including budget/privacy guards, no API), one complete
byte-access flow/verify (9 cases,8 literal trace steps, depth2 range/overlap
UNSAT),15 TCP data native/fixed-input Z3 and101 native connection cases.
raw-evidence.tar.gz retains787 original files including generated C/ELF/stdout,
SMT/results/Difference/source snapshots and logs. No new Linux deployment or
network capture: existing server SCP timed out; see deployment.json. The prepared
byte-access package is not counted as server acceptance.

Run from trusted checkout:

```
.venv/bin/python artifacts/byte-access-local-b959876b/accept.py
```

The audit verifies archive hashes and regular paths, exports the named Git source
blobs, uses that checker to reverify the flow, rerenders C and recomputes all116
TCP differences from original stdout, and checks15 retained fixed-input symbolic
query/result hashes. It executes no archived Python, ELF or solver. It does not
re-run103 tests or prove compiler equivalence. Range obligations are not complete
UDP correctness, checksum correspondence or unbounded protocol safety. No UDP
receive/ARP/ICMP implementation is claimed here.

A precommit local flow initially failed the immutable-source audit: one symbolic
sampler comment changed before the final source commit. The rejection and original
787-file bundle remain as precommit-*; a complete fresh flow was rerun from the
unchanged final commit and accepted. No hash or oracle checks were relaxed.
