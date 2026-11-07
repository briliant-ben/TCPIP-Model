# TCP live reconstruction failure: overwritten lifecycle receipt

Head 58390dbe78c71bd8e130b81dff4257dd7d157e8b, run 42352031515,
job 128342013870, artifact 13565393524, 53 original files.
ZIP SHA256 e897c03b23336d7b5eee93cd113b135df9db07f960e69cbafd95b6b730679a03.

The runtime gate succeeded, including fixed-input Z3 SAT/replay. Separate readonly
verification failed its timeline ordering: finally cleanup overwrote the already
recorded peer-exit time after the native-close receipt and symbolic analysis.
It reported 376409565940ns instead of the original earlier exit. Capture-stop
357726202976ns and native-close 357749019027ns are retained unchanged.
This archive remains a failed verification, not accepted evidence. The correction
preserves an existing exit receipt; no ordering check or tolerance is weakened.
Original archive contents were inspected without executing archived code/ELF/SMT.
