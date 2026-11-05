# Original Ubuntu ten-stage event-flow checkpoint

Source987c0994 / checkout mergec1e21ad0, CI41216276646/job124581357915,
artifact13048601703. Official original ZIP SHAbc78a22b... and lossless decoded
job-log gzip retain the complete actual Ubuntu run, not a synthetic fixture.

12 pipeline integration/fault/isolation tests pass. The actual task then passes
all10 stages, depth6 Z3 safety/overlap UNSAT,6 generated witnesses,4 original seeds,
2 model-gap rejection cases and12 exact native comparisons. Source interpretation
is provided by the caller; no English-to-IR proof is claimed. The original task
uses old0.1 seeds and does not establish trace-contract0.2 gate support; a later
checkpoint must cover that separately.

accept.py safe-unpacks data, checks36 source inputs against immutable Git blobs,
exports those approved source bytes to a clean validator tree and runs the ORIGINAL
read-only verifier. It never executes artifact-supplied Python, ELF or solver
queries. This permits future audits without relaxing old source hashes after the
current tool evolves. The Linux ELF stays inside the original ZIP; no standalone
executable is tracked. Compiler and executable hashes remain host-specific.

The result is original CI acceptance and retained integrity, not new native/solver
execution or Linux TCP/PCAP evidence. IPv4, byte/data generation, second-spec
migration, general generator/interpretation proofs and whole-goal completion
remain open. GitHub runner/job/checkout and the named trusted validator/runtime
are explicit trust boundaries.
