The expanded12-method prototype run failed in two idle cases: idle_before_cwnd
was8 in the parent but4 after flush+choice. Investigation identified duplicate
idle restart prefixes, including a reachable double increment of restart_count.
reproduce.py replays the isolated historical expanded IR and the current IR
against the same parent/source, checks every shared non-choice variable for the
current run, and requires the historical counter difference to be reproduced.
This is a reachable prototype bookkeeping defect, not a demonstrated upstream
or RFC bug. The fix makes flush defer restart; the actual choice executes the
existing parent restart once. No shared idle field is excluded from comparison.
historical-snapshot.tar.gz retains1774 members, with member-hashes.json; it
includes old state-invariant evidence that did not detect the counter mismatch.
Those historical checks must not be attributed to the corrected current model.
