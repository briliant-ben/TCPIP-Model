# Independent public sent-callback observations

The pinned unmodified lwIP2.2.1 raw API driver records each public sent callback
as its virtual millisecond and acknowledged-byte count, including its boundaries.
It keeps the timer driver's1ms sys_check_timeouts dispatch, <=12000ms, <=64 events,
<=16 written bytes and <=64 peer bytes. No internal PCB state or upstream change.

TCP source inputs are consumed exactly once through the generic witness replayer.
Only declared IR choice events are inserted; they are not extra C API calls.
The tcp-sent-ledger model declares the circular segment accounting and cb_step_bytes.
The Python projection only reads that declared observation variable and compares
the ordered callback records exactly. It does not calculate TCP ACK eligibility.
The complete original reference contract is still required for these new fixtures.
Previous canonical failures and2750ms timer differences remain separate unchanged
evidence. Service agreement never erases a wire Difference.

The original window4 single4-byte candidates are deliberate retained mismatches:
actual tcp_write segmentation is2+2, so ACK1003 retires a real2-byte segment.
Separate window8 experiments test a genuinely partial ACK of a real4-byte segment.
contracts.json records handwritten model-candidate callback contracts and wire
hypotheses, not assertions that every independent implementation run must match.
All actual wire/service differences are retained and independently reconstructed.
Each scenario generation and independent verification uses a fresh CLI process and the unchanged10s
solver limit. Shared-context equivalence timeouts remain failed historical
attempts; future non-unsat query pairs are retained in query-rechecks before the
strict gate rejects them. Neither isolation nor diagnostics relaxes that gate.

Run `.venv/bin/python ports/lwip-service/run.py --scenario <bound-json> --out <dir>`;
then repeat with `--verify`. A valid executed mismatch returns1 on execution.
Use `.venv/bin/python ports/lwip-service/tests.py` for standalone validation.
Set `TCPIP_SERVICE_EVIDENCE_DIR=artifacts/lwip-service` for a retained test run:
the same eight real executions, independent CLI checks and negative controls run,
then fresh exported-query SAT checks seal the persistent index and verification.
This retains the tested captures without executing a duplicate implementation run.
All source/witness/projection/schema/C/compiler/binary/capture/query hashes are
bound. Binaries are rebuilt locally and ignored by Git. Real memory-netif frames
are implementation evidence, not Linux or general TCP/socket refinement proof.
