# Generated C

[generated/protocol.c](generated/protocol.c) is a derived standalone C99 snapshot,
not a hand-written stack. [generated/manifest.json](generated/manifest.json) binds
it to the authoritative IR. Its SHA256 is
`e5a3f04adbb50c3c226256f2f43c62ac7c2c8dd62fc38aa44a51ced8a520b5cf`.
No compiled binary is committed.

The v5 framework generator shares exact typed expressions and uses readable C
string literals. With the model unchanged, source size fell from 2,885,072 to
666,457 bytes (76.9%). The dispatcher still checks every eligible rule, and full
traces, ordered assignments and atomic failures remain. [Optimization record](optimization.json)
binds the new source and [24 frozen native paths](../tests/optimization-regression.json)
(157 transitions). Both old/new C and the reference matched these paths. The
standalone tests retain their exact pre-optimization output digests.

The recorded Linux demo still binds the **original** C hash in its provenance;
it has not been relabeled as a network run of v5. This update is generation and
regression validation, not new wire evidence or a compiler equivalence proof.

```sh
python3 code/build.py --out /tmp/tcpip-case-001 --run-example
printf 'B\nD 0 T.app.connect\n' | /tmp/tcpip-case-001/tcpip-reference
```

The build verifies the model/C hashes, compiles the source, sends only frozen
input commands to the subject, then compares its complete output with a
previously qualified reference/native fixture. This is not fresh formal
verification or a network run. Compiler/native logs remain in the fresh output
directory outside this repository.

## Optional regeneration

Use a separate framework checkout at the commit in [framework.json](framework.json):

```sh
git clone https://github.com/briliant-ben/Formal-Spec-Agent.git /path/to/framework
git -C /path/to/framework checkout 5486c43f7ea0ec5e2c9c7ace246ebcd8419145d7
# Prepare that checkout's documented Python/Z3 environment first.
python3 code/regenerate.py --framework /path/to/framework \
  --python /path/to/framework/.venv/bin/python --out /tmp/tcpip-regenerated-001
```

The helper checks the external commit/source hashes and requires regenerated C
to equal the committed snapshot. It does not vendor the framework, edit the IR,
overwrite source files or regenerate expected test output.

Next: [tests](../tests/README.md).
