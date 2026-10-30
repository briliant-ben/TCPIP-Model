# Official fresh-certificate unit CI checkpoint

GitHub Actions run41079885224 / job124145857544 succeeded for source head
13ff8c934ad8e1d58467495997d316ea09f46beb. Checkout merge commit was
748b94abd50b844d8998a1dd3cbd2fe809434d20. Official artifact12988842253 has original
ZIP SHA256242375bb9cf92880da0098fc72293500ee1e9a0d4c39accb0eaea03654602ff6.
The ZIP, public API provenance, decoded job log and all five original members are
retained without transient download URLs.

67/67 selected methods passed in10.319269s with no failures/errors/skips. Input
and environment bindings remained unchanged. All1268 captured source hashes were
checked against immutable named Git blobs at source head13ff8c93, and the test-ID
vector matches the local67-method suite. This is a selected unit suite, not the
complete478-method discovery.

Runtime: Python3.12.3, Z3 package4.15.4.0, Linux7.0.0-1017-azure x86_64. The fresh
Linux Z3 binary hash1bfaf5bb... differs from the retained Mac checker2f4cc814...;
no old binary gate was changed. Each unit fixture generated its own certificates.

```
.venv/bin/python artifacts/query-verification-ci-13ff8c93/accept.py
```

This offline command checks the fixed official ZIP/report/log/source bindings.
It does not rerun the Linux unit tests locally, verify the retained Mac protocol
query bundles, compile/check Rocq, execute Linux TCP or produce PCAP evidence.
The job/report explicitly records those scope exclusions. The raw official output
and observed host/tool epoch are not relabeled as protocol implementation proof.

The decoded official job log is losslessly compressed as decoded-job.log.gz. Its
original UTF-8 SHA is fixed in the verifier; no raw whitespace is normalized.
