# Generated rule helpers and observed stack use

The first63-rule Ethernet/IPv4/UDP/ICMP composition exposed an actual lowering
resource failure. The unchanged default C99 build succeeded, but the original
generated executable crashed with SIGSEGV. A separate `-fstack-usage` observation
reported a12,986,128-byte static `fire()` frame. Original source, generated C,
binary, receipts and failed outputs remain in
`artifacts/ipv4-endpoint-native-stack-diagnostic`; a smaller AST experiment also
failed and was not promoted.

The generic generator now emits a separate guard function and action function
for each IR rule. The dispatcher checks every eligible guard in declaration
order, rejects conflicts or expression failures, cancels an expiring timer only
after guard selection, and calls the unique selected action. Assignments,
emissions, target state, invariant checks and trace serialization retain their
order. The unchanged command harness still commits the candidate machine and
log only when the whole command succeeds. Helpers contain generated AST
expressions, never handwritten protocol callbacks.

Using the same local compiler, `fire()` was96 bytes, the largest guard482272,
largest action382336 and main1038736 (unchanged). These are measurements of this
source/compiler, not universal stack bounds. No stack limit, runtime capacity,
IR domain, optimization flag, parser or ABI was changed. Backend semantics
remain byte-access-v4; generation source hashes distinguish the new lowering.
Old evidence must use its original Git generator/checker, as before.

Five new methods exercise64 byte-heavy rules with an explicit unoptimized
1MiB frame warning gate, late conflicts and guard capacity failures, Boolean
short-circuiting, ordered assignments, action/emit/earlier-timer rollback, and
guard-before-expiry cancellation/rearming. The frozen63-rule model's nine
native cases now pass. Thirty-five existing codegen methods plus seven byte-read
and eight arithmetic methods passed separately; this is no whole-repository
regression or compiler correctness proof. Very large individual expressions
and other resource limits can still fail explicitly at build/execution stages.
