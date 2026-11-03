# Interrupted development witness extraction

First test harness used incorrect Machine/trace arguments; fixed before the
second run. interrupted-tests.log is the second development run: native13 passed,
then fixed-input solver reached SAT but materialization repeatedly reevaluated
original emitted sequence octets. The sole test process was interrupted after
several minutes (SIGINT exit130), not accepted as completed replay or UNKNOWN.
symbolic-before.py and model-before.json preserve the actual relevant sources.
No discarded query file was recovered or claimed. New materialization evaluates
only concrete Seq(BV8) Empty/Unit/Concat ASTs once, preserving order/values, with a
generic evaluated-sequence fallback. Encoding/solver/constraints are unchanged.
New tests validate4096-octet extraction with at most2 evaluations, empty/nested
concat/high bytes, and13 complete fixed-input native/reference/Z3 ICMP scenarios.
