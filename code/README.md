# Generated C

[generated/protocol.c](generated/protocol.c) is a derived standalone C99 snapshot,
not a hand-written stack. [generated/manifest.json](generated/manifest.json) binds
it to the authoritative IR. Its SHA256 is
`42386d6a7b2c7c7081a3b189b707c5141f4967b381c2fcaebb54484ac91b64ae`.
No compiled binary is committed.

The v6 framework generator (`direct-c99-typed-text-v6`) shares exact typed
expressions and uses readable C string literals. With the model unchanged,
source size fell from 2,885,072 to 667,125 bytes (76.9%). The dispatcher still
checks every eligible rule, and full traces, ordered assignments and atomic
failures remain. [Optimization record](optimization.json) binds the new source
and [24 frozen native paths](../tests/optimization-regression.json)
(157 transitions). Both old/new C and the reference matched these paths. The
standalone tests retain their exact pre-optimization output digests.

The recorded Linux demo still binds the **original** C hash in its provenance;
it has not been relabeled as a network run of v6. This update is generation and
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
git -C /path/to/framework checkout 500a9a3daf779c48a1678744e32521bc1fd5f2aa
# Requires only Python 3.11+ standard library (no third-party packages).
python3 code/regenerate.py --framework /path/to/framework \
  --python "$(command -v python3)" --out /tmp/tcpip-regenerated-001
```

The helper checks the external commit/source hashes and requires regenerated C
to equal the committed snapshot. It does not vendor the framework, edit the IR,
overwrite source files or regenerate expected test output.

Next: [tests](../tests/README.md).
