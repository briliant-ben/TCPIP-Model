# CI integration failure retained, not network evidence

Source b81f747e; PR tested merge 75c70a82. Original artifact13559985003 from
run42336058603/job128293137220 has SHA256
`b4bdb557611aad39a4d5da61004fb3fea60e8053c4cd4359d3719da19c9ad308`.
The original ZIP contains three test logs, no live run, packet capture or flow
result. The job failed before the network step: a supplementary ICMP test
hardcoded the prior formal configuration without the newly explicit exact-v1
field. Its other three actual inductive/flow/fault tests passed.

The same failure was independently reproduced locally (four tests, one failed
strict dictionary equality). The correction adds the explicit exact-v1 field to
that equality. The complete unchanged protocol/source/seed comparison against
the supplementary task remains in force; no guard, invariant, source hash or
oracle was relaxed. All four tests then passed locally. New-head CI must verify
this call-site/configuration integration correction separately.

At final inspection b81f747e had 59 checks:55 success, four failures comprising
push/PR copies of the two affected peer workflows. Their failure does not claim
new network evidence. This snapshot cannot be applied to a later Git head.
