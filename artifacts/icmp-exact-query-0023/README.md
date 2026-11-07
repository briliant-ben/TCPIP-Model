# Exact preprocessing diagnostic and closure validation

Original TAR SHA256 600285b577c67e8479f35d1505a9968ed6e5b57671062e16d4510f55e944a02b.
Frozen original query SHA412b9d51 from failed CI remains UNKNOWN.
DeepSeek chose propagate-values / solve-eqs / simplify; controller whitelist-only
experiment retained full sequences, no domain/property/depth changes, within
original TOTAL60000ms: UNSAT13.7877s. Preprocessed SMT SHA f75d5335.

Independent reviewer blocked interpretation pending recursive definition check.
Controller then verified entire recursive define-funs-rec token sequence EQUAL,
reloaded preprocessed SMT in a separate fresh Z3context and got UNSAT6.016s.
Separate small SAT int/byte equations checked automatic modelconverter restores
original values. Raw source/queries/receipts/timings/review/closure are retained.
This resolves the diagnostic missing-definition concern, NOT production acceptance:
actual protocol SAT witness reconstruction/replay and full pipeline binding still
required. No archived Python/ELF/solver executed locally, no old result promoted,
no all-TCP/IP, universal checksum, or compiler proof claim.
