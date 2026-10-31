# Native IPv4 virtual-link acceptance

This archive retains the original ten-stage task-v3 job: 13 scalar cases and five
complete wire cases, including independently fixed scenario0.2 trace expectations.
The PCAP recorder wraps stimulus ingress plus unchanged native C-produced egress;
it does not encode expected model outputs. The independent decoder checks both
checksums, and comparison checks absolute as well as normalized packet fields.
Virtual time/link only: no Linux TCP, physical network, payload/options/fragments
or full IPv4 behavior claim. TCP decisions remain generated from the single IR.

The original 205 regular files are data in `run.tar.gz`, each bound by members.json.
The archive includes original compiled programs as evidence; do not execute them
for retained audit. No standalone local executable is tracked. Logs retain nine
native wire, 20 pipeline, 12 scalar native and 24 legacy methods, run separately.
A whole-repository regression is not inferred. Fault tests include a native output
sequence shift and a native checksum defect while event traces still match.

For retained verification use an isolated checkout of the exact commit named by
source-git-bindings.json. Verify hashes and unpack only listed regular members
into a fresh JOB; reject absolute paths, traversal, links and duplicate names.
Use trusted code from that Git checkout, not archive Python, and run:

```
python -m protocol_lab.pipeline verify JOB --workspace CHECKOUT --task-sha256 SHA
```

SHA is the task_sha256 in run-summary.json. All 42 original inputs were checked
against immutable Git blobs, and a separate safe unpack was read-only verified.
Later checker changes require the original source epoch; never waive old hashes.
Retained verification is not fresh native/solver execution or authentication.
Second-spec migration and server handoff acceptance remain open.
