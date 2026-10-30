# Sender SWS prototype diagnostics

The first generator used unsupported max, explicitly rejected by IR typing before execution. Current expressions use declared ge/ite semantics; no backend fallback/operator was added. The obsolete component load rejection is retained.

The next prototype confused queue capacity16 with the16-bit advertised window domain. Conditional checks found SAT states with accepted window17, while the unchanged parent permits0..65535. The corrected invariant uses65535 and does not change protocol actions, guards, source inputs or comparison oracles. All original queries/witnesses and compressed IR are retained. Query outcomes: {"unsat": 217, "sat": 24, "unknown": 7}. An isolated ordinary handshake with window17 reproduces an actual old invariant failure; this does not establish reachability of every arbitrary induction counterstate.

The first twelve-method run had eleven passes and one new fixture failure: queued-close FIN was incorrectly expected immediately after first data transmission. The unchanged parent waits for data ACK before FIN. The corrected fixture first ACKs data at sequence wrap, then ACKs FIN; no parent semantic/oracle was changed.

Three historical C executions, independent verification and four port methods passed under the window16 invariant. Their scoped source snapshots are historical, not relabelled as current65535 evidence. Full MSS matches; two tiny-write captures retain valid time Differences with matching public callbacks. Current evidence is regenerated separately. Binaries are ignored and require rebuild.

The next13-method run confirmed the legal-window fix but found the fixture also omitted the parent explicit FIN flush after data ACK. Parent CL-FLUSH-FIN-CLOSE-WAIT is an app.transmit scheduling rule. The corrected fixture supplies that existing event at51ms; original fixture/log are retained, and neither the parent nor an existing oracle is altered.

One independent unconstrained SAT-export rerun timed out at the unchanged10s limit; that failure is retained. All24 original SAT exports were then checked with every original assertion retained plus the saved witness equalities, under the same10s limit. This validates those SAT witnesses without asserting reachability. correction-scope.json confirms exactly one invariant literal changed in the complete raw IR, and three fresh C captures/public summaries exactly reproduce their historical counterparts; these are finite checks, not general refinement.
