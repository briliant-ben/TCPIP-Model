# 4. Standalone generated C

[generated/protocol.c](generated/protocol.c) is an inspectable **derived snapshot**
of the complete finite IPv4 model, not a hand-written protocol stack. The
[manifest](generated/manifest.json) pins its authoritative IR, framework version
and C hash. Edit the IR and explicitly regenerate; do not add protocol behavior
only to this C file or an adapter.

Generate, compile and execute a frozen reference/native example with the pinned
framework, writing all local outputs outside the repository:

```sh
.venv/bin/python code/build.py --out /tmp/tcpip-code-001 --run-example
```

The output contains `generation/protocol.c`, source bindings, compiler logs,
`build/protocol-native`, the actual native trace and the exact comparison result.
The C process needs no Python or existing protocol stack at runtime:

```sh
printf 'B\nD 0 T.app.connect\n' | /tmp/tcpip-code-001/build/protocol-native
```

The committed source also builds directly:

```sh
cc -std=c99 -Wall -Wextra -Werror code/generated/protocol.c -o /tmp/tcpip-reference
printf 'B\nD 0 T.app.connect\n' | /tmp/tcpip-reference
```

This produces an ARP request as raw emitted bytes. A real interface uses the
case-specific [Linux peer harness](../ports/linux-tcp-ipv4-peer/README.md);
logical event execution is not a new PCAP or Linux network observation.
No compiled binary is committed. The generator/C runtime remains maintained
only in Formal-Spec-Agent.

Next: [tests](../tests/README.md).
