# Frozen spec-flow task-v2 local acceptance

The original 159-file job is retained as data in `run.tar.gz`; all members are
listed in `members.json`. It includes generated native observations and frozen
source files, not a claim of network/PCAP evidence. No standalone build executable
is tracked. The archive may contain the original executable as execution evidence.

`run-summary.json` records the ten actual stages, 13 cases and two independently
fixed trace-contract steps. The logs retain 18 pipeline, 12 native and 24 legacy
flow tests, each run separately; no whole-repository regression is inferred.

For retained verification, use an isolated checkout of the exact commit named in
`source-git-bindings.json` and its Python environment. Validate member hashes and
extract only listed regular data files into a fresh temporary job directory;
reject absolute paths, traversal, links and duplicate members. Run that checkout's
`python -m protocol_lab.pipeline verify JOB --workspace CHECKOUT --task-sha256 SHA`
using the task SHA in `run-summary.json`. Do not execute Python or native programs
from the archive. All 37 source inputs were also checked against immutable Git
blobs at the named commit. Later tool changes require this original source epoch;
do not waive source hashes to make old evidence match new code.

The original retained verification is read-only, not a fresh execution, source
interpretation proof or authenticity attestation. The task digest binds a version;
it does not establish external approval. Original absolute worker paths are
provenance; retained checking uses the supplied checkout and frozen relative files.
TCP/IPv4 wire and second-spec portability gates remain open.
