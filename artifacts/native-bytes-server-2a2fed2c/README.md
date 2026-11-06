# Actual native-byte server milestone

Source: `2a2fed2cb5cec7e023cc0c4fc86a07a26c96a985`.
The separate Linux release contains184 immutable Git files. Its source archive
SHA is in release-build.json; the original evidence archive has1188 regular files,
including generated C, original ELF, compiler logs, native stdin/stdout, fixed-input
SMT/witness reports and the three baseline flow jobs. No venv or private API store
is archived. Python3.12.3 and original compiler version are retained in environment.json.

Actual server gates:63 methods (20 pipeline,9 wire,8 migration,12 scalar,14 byte),
three baseline tasks and verify,15 TCP data cases with independent fixed-input
Z3 match,101 connection cases with native/reference match. Sanitizers passed on
both local and Linux compilers. No whole-repository regression is claimed.

Run `.venv/bin/python artifacts/native-bytes-server-2a2fed2c/accept.py` from the
repository. It safely unpacks only bounded regular data, checks184 files against
named Git blobs, exports that Git tool version, re-verifies three retained jobs,
re-renders C and re-compares116 original native observations against reference
execution. It checks15 retained symbolic reports/SMT hashes without rerunning the
solver. It never executes archive Python or ELF, and does not claim a fresh native
run or externally authenticated proof. Both raw archive corruption and native
stdout tampering with an updated outer archive digest are rejected (audit-faults.json).

The single bounded DeepSeek review was truncated by its1536 output-token cap:
5092 total tokens. Its prompt, rejected original response and controller assessment
are retained; this is not an accepted independent review and was not retried.
Total provider usage across this and the previous milestone is5 calls/35611 tokens,
including7808 cache-hit input tokens. Deployment/testing makes no API calls.

Scope: exact event-level byte/seq/ACK/window/timer correspondence for fixed inputs.
Per-value/intermediate byte capacity4096, signed64 arithmetic and finite source
string domain are explicit execution bounds. No generator correctness proof,
all-input TCP proof, payload PCAP/Linux TCP data evidence or complete IPv4 endpoint
is claimed. Original depth6 UNKNOWN and2750ms lwIP discrepancy stay unchanged.
