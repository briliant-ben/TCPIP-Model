# Original ten-stage event-flow execution

The original local job runs source integrity, IR, depth6 Z3, bounded test generation,
reference execution, C generation, compilation, native execution, comparison and
rule/source traceability. All ten stages pass within the declared active-open
event-level slice. Z3 safety and overlap are UNSAT with a nonempty witness replay;
this is bounded model checking, not an unbounded or generated-C proof.

Six generated rule witnesses, four original seed scenarios and two generated
model-gap rejections yield12 native comparisons. A rejection test checks agreement
with IR rejection; it does not implement the RFC's unmodeled invalid-ACK response.
No expected reference values are supplied to the native executable.

The original116-file job is retained byte-for-byte in run.tar.gz, including36
input bindings,115 artifact bindings, generated C/binary/tests, queries, exact
stdin/stdout, reference operations, differences, source clauses and worker receipts.
No standalone executable is tracked. accept.py safely unpacks regular data files
and calls the read-only verifier; it does not execute archive code or programs.
The original job and native/solver execution happened before this retained audit.
Integrity is not authenticity; fresh execution requires running the task again.

12 actual pipeline tests pass, including missing compiler channel isolation,
corrupted source, model conflict, backend integer limit, rehashed UNKNOWN promotion,
observation/scope tampering, workspace traversal/command rejection, a real worker
process-group timeout, and two concurrently executed independent jobs.12 prior
native tests and24 old flow tests also pass separately.

This remains an event-level flow prototype. IPv4/wire PCAP, byte/data generation,
second-spec migration and whole-goal acceptance are not claimed. The candidate IR
and source interpretation are supplied by the caller/modeling agent and remain
trusted interpretation; URI/hash binding is not an English-to-IR correctness proof.

All36 original inputs additionally match immutable Git source987c0994. Run the
audit at the recorded source checkpoint; changed/added tool files require a new
flow execution, never a relaxed hash check.
