# Finite raw IPv4/UDP receive: local evidence

Source79d6879f27479c227882b48d73406b03a881bf90;260 named Git source blobs.
Actual macOS/Python3.12.14/clang execution:111 specialized methods+6 deployment
methods pass. New flow executes27 cases (8 model-derived rule witnesses,
12 literal raw packet seeds,7 explicit atomic model-gap rejections),13 literal
trace steps, depth2 safety/overlap UNSAT for payload bound/drop-empty invariants.
Exploration covers all8 rules with a64-prefix resource cap; not exhaustive inputs.
All12 declared cases also pass actual standalone generated C and independent
fixed-input exact Z3 replay, with original queries/results/stdout retained.

raw-evidence.tar.gz retains369 original files, including source snapshots,
C/ELF/native input raw bytes/emitted delivery traces, SMT/results/Difference and
all logs. The approved frozen independent oracle and source clause bindings are
included through release/task snapshots. No reference data is used to construct
native observations. Payload shift, stale data, bad checksums, absent policy and
model-gap negatives are covered by the eight new specialized methods.

```
.venv/bin/python artifacts/udp-receive-local-79d6879f/accept.py
```

This uses immutable Git source to verify source/archive hashes and the ten-stage
flow, rerenders C and recomputes12 native/reference Differences from original
stdout, and checks12 fixed-input symbolic report/query hashes. It executes no
archived Python/ELF/solver and does not repeat the111 tests. The source tree and
oracle checks remain exact. Source79d's dedicated CI selector initially selected
the inherited byte-access test filename; f266 fixes it before PR creation. The
fixed udp-receive release profile already includes all eight receive methods.

This is finite raw-event ingress and generated-byte delivery, not a real UDP
peer, physical capture, TCP/IP composition or complete modern UDP/IPv4. The
separate model gaps are not silently converted into RFC packet discards. No
universal checksum/compiler equivalence, unbounded protocol proof, new Linux
acceptance or project-server deployment follows from this local bundle. API0.
