# Initial Linux release not accepted

Immutable f94725934c06cbbe250fa6e1ac9867662715ba35 passed the nine actual native
packet/oracle checks but the top-level test failed because the formal status was
UNKNOWN. A separate original-source diagnostic retains full-depth safety/overlap
SMT/result: both UNSAT, and only the subsequent existential sample search canceled.
It is a fresh diagnostic of the unchanged original source, not recovery of the
already-cleaned unittest temporary job. The old sampler did not export its SAT
query; that missing artifact is not reconstructed or claimed as retained.
Original bootstrap log/source remain. No success marker or weakened oracle.

New sampling uses existing exact fixed-choice encoding for a one-event witness,
then any one-event witness, then original unrestricted sampling. One legal event
is a sufficient existential nonvacuity witness and may be extended by idle steps.
Full-depth all-input safety/overlap are never narrowed. Each attempt's query,
result/hash and replay are retained; all-input UNKNOWN must still stop acceptance.
Future failed test jobs are copied into the release result before temp cleanup.
