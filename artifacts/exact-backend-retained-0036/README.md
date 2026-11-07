# Tested experimental exact-v1 candidate, not production adoption

Original server TAR SHA256:
`093fccca2addf2583b66a516e96f3e4adc05685b0dfeb09b58efaeb054283b64`.

DeepSeek 0033 supplied tests and canonical policy/tactic/source binding additions
to candidate 0027. Its first actual run failed: invalid fixture fields, guessed
report keys and an unpersisted embedded stage mutation. Controller 0034 reused
an already schema-validated fixture, corrected the actual API fields and saved
the mutated stage before rehashing. It also required real complete pipeline
execution rather than fabricated stage envelopes. All corrections are recorded;
no model, oracle, invariant or solver obligation was weakened.

0034 and a fresh retained-evidence run 0036 each passed eleven tests, zero
errors/failures/skips. Three actual ten-stage active-open pipelines passed,
with positive independent verifier calls; three coherently rehashed policy,
tactic and source-string attacks were rejected for the intended reasons.
0036 retains all three complete jobs and their source workspaces before mutation,
including generated C, ELF, stdout, SMT and original manifests. ICMP independently
returned depth-two safety/overlap UNSAT at the unchanged 60-second budget.

`audit.py` reads archive bytes and checks all retained job outputs/source hashes;
it does not execute archived code, ELF or solver. Server execution provenance
requires trust in the controller and SSH collection, not just a self-authored
manifest. This is neither CI acceptance nor a proof of compiler correctness.

Independent DeepSeek review 0037 reported no blocking findings, but identified
a real tautological recursive-function assertion that still needs replacement.
Some additional suggestions concern unexercised combinations or future code
changes rather than demonstrated current defects. Before production adoption:
repair the assertion, journal SMT before solving, perform relevant regressions
and run fresh immutable CI. Prior UNKNOWN results remain unchanged. No live TCP,
PCAP or full IPv4 endpoint evidence is supplied by this package.
