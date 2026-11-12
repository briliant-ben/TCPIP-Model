# Pinned Formal-Spec-Agent client

This repository owns protocol models, specification/oracle bindings, native
reproduction inputs, network adapters and original evidence. The reusable
framework is the one-way `framework` Git submodule, pinned by commit and all
executable-source hashes in `framework.lock.json`.

```sh
git submodule update --init --recursive
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements-formal.txt
TASK_SHA=$(shasum -a 256 flows/tcp-active-open.json | cut -d ' ' -f 1)
.venv/bin/python tools/run_framework_candidate.py run flows/tcp-active-open.json \
  --workspace . --out /tmp/tcp-framework-run-001 --task-sha256 "$TASK_SHA"
.venv/bin/python tools/run_framework_candidate.py verify /tmp/tcp-framework-run-001 \
  --workspace . --task-sha256 "$TASK_SHA"
```

The controller must independently approve the digest; local calculation only
binds a version. Outputs must be fresh and outside the framework tool tree.
The client checks commit/source identity and starts another process from the
framework directory. It never mixes both same-named packages in one process or
silently falls back to the historical implementation. Missing/changed pins reject.

Ordinary IR event/raw-byte tasks, including `flows/udp-header.json` and
`flows/ipv4-prototype-closeout.json`, use this interface with their own original
scope. New execution has a new tool/hash epoch and cannot retroactively validate
an old run. The old benchmark-specific TCP `wire` codec stays in this repository;
the generic backend explicitly rejects that extension. The full byte-producing
IR prototype does not require it.

`protocol_lab/` is frozen historical compatibility code, checked by
`docs/frozen-legacy-framework.json`. New generic semantics/backend work happens
only in Formal-Spec-Agent, then an explicit pin update and fresh benchmark run
consume it. Do not weaken source hashes or delete old checkers to clean the tree.

Qualification includes actual external TCP/UDP task execution/verify and four
client tests: changed-pin/source rejection, legacy source identity, a TCP flow,
and complete335-rule IR producing the same C SHA19ce9855 and executing a frozen
native scenario. This does not establish new PCAP or compiler/full-TCP correctness.
