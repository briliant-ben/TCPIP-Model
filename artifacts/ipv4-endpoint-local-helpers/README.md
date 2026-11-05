# Finite composed endpoint local helper-lowering results

The original frozen63-rule model SHA68e3da058d64460e862f9597ccd7ea4457410b2dcacddf225e1fdbe0702835d1
and independent literal oracle SHA5c05de68f56cef48835bc9c5863f312bf9675dc9ab70d90c07b4e9d1adc296da
pass nine actual standalone generated-C/reference/literal scenarios and nine
independent exact fixed-input Z3 paths. Original C, compile/executable receipts,
stdout/stderr, complete Differences, nine raw SMT/result/witness sets and all
source snapshots are retained. Ten new specialized unittest methods pass in
12.554s, including thirty atomic unsupported-domain probes, unchanged inherited
thirty-rule prefix/seventeen prior scenarios and reference/native byte mutants.

Generic per-rule guard/action lowering uses unchanged default C99 flags and
runtime/ABI. Stack measurement with -fstack-usage: fire96, max guard482272/action
382336, main1038736 bytes. Original pre-fix failures remain failed in the separate
ipv4-endpoint-native-stack-diagnostic bundle. No stack or optimizer workaround.

These are local macOS fixed-input results, not Linux network capture, ten-stage
flow, all-input induction/checksum theorem, compiler correctness or complete TCP/IP.
The snapshot captured the scope doc before its final reporting-only success update;
model/oracle/core sources and raw execution hashes are frozen at execution.
ZIP/member hashes are in manifest.json. Retained hash integrity does not itself
prove run authenticity or reproduce execution. No archived code needs execution.
