# Two scalar sequence-space IR laws

The authoritative model is model/seq32-contract.json: one state, one probe transition, seven variables and two explicit invariants. Inputs range over all32bit sequence values and unbounded signed integer displacement. Modular induction closes the two declared scalar invariants; the default BV32 BMC and fresh CLI remain unknown. This is not a TCP state/buffer/order/time or universal Python/translator/kernel proof.

The current encoder's36 original modular assertions are independently reconstructed. Three modulo rewrites have three generic integer equality certificates, proved without query premises and rechecked in a fresh CLI. Every original assertion is reconstructed by typed instantiation/congruence. Both original and transformed counterexample queries are independently UNSAT. The existing induction verifier passes, with separate CLI initial/preservation/length-lemma rechecks.

Eight concrete wrap/half-space/very large signed displacement cases have reference traces, full fixed-input SAT/replay and independent CLI SAT. Reversed distance and wrong inverse IR variants have legal fixed counterexamples and reference invariant rejection. The earlier unconstrained BV fault search UNKNOWN and failed test are preserved in diagnostics/seq32-contract-negative-v1; no offset guard or positive input domain was narrowed.

The first strict API/export comparison rejected negative-literal AST syntax differences. These are now handled by nine separately saved unconditional XOR UNSAT checks, without other query premises; the original rejection/source remains in diagnostics/seq32-api-export-v1. The parser/serializer and Python/Z3 proof path remain trusted, not universally verified.

normalizer-tests.log has5 methods; contract-tests.log has3. focused-regression.log combines these with4 tactic,6 partition and13 existing data-semantics methods (31 total). These focused checks do not claim the current442-method complete discovery passed. The prior430-test frozen regression is a separate checkpoint.

Run accept.py for current-source reconstruction/induction/certificate/fixed-witness checks. generate.py refuses an accepted snapshot; use a new evidence directory for regeneration. solver-and-checker.json and archive-hashes.json bind the toolchain, guide and retained artifacts. No synthetic/real PCAP or Linux execution is produced by this scalar experiment. Existing TCP/LwIP/Linux evidence and the2750ms Difference remain unchanged.
