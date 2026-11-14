# Model

[ipv4-endpoint-virtual-link.json](ipv4-endpoint-virtual-link.json) is the sole
behavioral authority:335 rules,58 variables,65 invariants and61 requirements.
State, typed events/messages, buffers, guards, ordered actions, timers, byte
layout/checksums and specification references are explicit Protocol IR.

For a compact view of all335 rule identifiers, use the [rule index](rules.md).

It is self-contained: no inherited model files, Python callbacks or external
protocol stack is needed to describe its behavior. The generic interpreter,
formal backend and C generator live in Formal-Spec-Agent, not in this repository.

The unchanged model SHA256 is
`7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5`.
[spec/references.json](../spec/references.json) resolves the original source IDs.

Next: [formal results](../formal/README.md).
