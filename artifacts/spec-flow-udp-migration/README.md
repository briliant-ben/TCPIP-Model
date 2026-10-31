# Second-RFC migration and external-client acceptance

The data archive retains the actual UDP header/service descriptor task invoked
through the external client. It uses unchanged protocol_lab source from the TCP
wire milestone: no UDP callback or duplicate transition implementation was added.
See run-summary.json for actual stage/case/coverage counts. Three independent
scenario0.2 fixtures check14 fixed output steps. migration-tests.log retains eight
actual tests, including model defects and concurrent isolated TCP-wire/UDP clients.

Scope: source-port/length/checksum-presence/default/discard descriptors only.
Payload bytes, checksum arithmetic and UDP PCAP are explicitly excluded. sum_valid
is a trusted input abstraction, not a proof of the checksum algorithm. No full UDP
or unbounded-proof claim. Separate TCP evidence supplies native IPv4 wire output.

Each original archive member is a listed regular data file with SHA256. Verify
member hashes before safe unpack into a fresh directory; reject traversal,
absolute paths, links and duplicate members. The archive includes original native
execution evidence; do not execute its Python or compiled programs during retained
audit. No standalone local compiler executable is tracked.

Use a trusted isolated Git checkout of the exact source_commit in
source-git-bindings.json and its rebuilt Python environment. Every original input
and the external client were checked against immutable Git blobs. After safe
unpack, use the trusted checkout's verifier:

```
python -m protocol_lab.pipeline verify UNPACKED/job --workspace CHECKOUT --task-sha256 SHA
```

SHA is the task_sha256 in run-summary.json. Compare the result with original
UNPACKED/verification.json. No old-source hash is waived when tools evolve.
The archive was separately safely unpacked and read-only verified locally; this
is retained integrity checking, not fresh execution or authenticity attestation.
The original caller digest in this local self-check binds a version, not external
approval. The new CI epoch must be accepted separately for Linux server evidence.
