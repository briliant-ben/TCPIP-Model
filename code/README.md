# Generated C

[generated/protocol.c](generated/protocol.c) is a derived standalone C99 snapshot,
not a hand-written stack. [generated/manifest.json](generated/manifest.json) binds
it to the authoritative IR. Its unchanged SHA256 is
`19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b`.
No compiled binary is committed.

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
git -C /path/to/framework checkout 93ade66ef40206189f134d1fbbd794d7d4cfe014
# Prepare that checkout's documented Python/Z3 environment first.
python3 code/regenerate.py --framework /path/to/framework \
  --python /path/to/framework/.venv/bin/python --out /tmp/tcpip-regenerated-001
```

The helper checks the external commit/source hashes and requires regenerated C
to equal the committed snapshot. It does not vendor the framework, edit the IR,
overwrite source files or regenerate expected test output.

Next: [tests](../tests/README.md).
