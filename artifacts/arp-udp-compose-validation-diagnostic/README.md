# Rejected draft, not an executed model

The first overlay used emit_if. IR0.5 atomic-v1 validator explicitly refused it:
Conditional emit requires versioned post-target semantics. No C or formal run was
accepted for this draft. The implementation uses explicit disjoint QUEUED/EMPTY
rules for the two PENDING local receptions and query failure instead; no opcode,
semantics downgrade or backend change. The invalid draft is retained for diagnosis,
not executable evidence or an accepted Protocol IR model.

A second valid draft accidentally emitted the raw IP packet as ethernet.tx,
without applying its declared Ethernet frame expression. The independently
frozen full-frame oracle rejected it at checksum-policy-freezes-queued2ms (33
raw IP bytes rather than60 Ethernet bytes). The valid-but-wrong overlay is
retained; the subject model was fixed to apply explicit Ethernet concatenation,
not the expected bytes/oracle. Neither draft is accepted evidence.
