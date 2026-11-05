# Actual Ubuntu two-spec flow acceptance

Official run41222440458/job124599629037 completed successfully at source
d72b7f3d4f0832a876ca87967916b47fbb6cb51c, checked-out PR merge snapshot
6a46f71127159d9573e4a837dd4bf0687d5fcddc. The original artifact13050482735 ZIP is
946217 bytes, SHA256 fd69b4bc7c23c6209c863ce339b8acf631d60dfe0b243c7e344efc709c649543.
Official provenance and lossless decoded job logs are retained separately.

Actual20 pipeline,9 wire and8 migration/client tests passed, without skips. The
job also actually ran and verified three tasks: TCP event13 cases; TCP wire13
scalar plus5 wire cases/15 native egress packets; UDP descriptor12 cases/seven
rules/14 fixed contract steps. Each task passed ten stages and depth6 Z3 safety/
overlap checks. Native programs are original Linux ELF, compiled with GCC13.3.
The concurrent-client test actually invokes isolated TCP-wire and UDP candidates.

`accept.py` verifies original ZIP metadata/digest, safely unpacks data, checks all
53 original task/tool/client inputs against immutable Git blobs, exports only
those trusted Git blobs and invokes that original read-only verifier for all
three jobs. The29 generic tool files are identical across tasks. No Python from
the archive, archived ELF or solver is executed by retained audit. No current
source hash is waived to accept an older epoch. Run with rebuilt trusted Python:

```
.venv/bin/python artifacts/spec-flow-migration-ci-d72b7f3d/accept.py
```

The ZIP retains original executable evidence; no standalone local binaries are
tracked. TCP PCAP is stimulus ingress plus unchanged native C egress on a virtual
link, not Linux TCP or physical-network evidence. UDP is header/service metadata,
with payload content, checksum arithmetic and UDP wire excluded. Native agreement
and bounded Z3 do not prove English interpretation, generator correctness or
complete protocols. Artifact/service provenance is a trust boundary, not a
cryptographic authenticity or host-compromise proof.
