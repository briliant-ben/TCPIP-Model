# Stacked PR integration review — 2026-11-05

## Correction on 2026-11-06

The earlier workflow helper returned only pull-request event runs and omitted
push check runs. Its returned green list was incomplete and is **not approval
to merge #8–#16**. The complete #8 check list includes failed Linux receive
job124784462166: `Quiet observation shorter than source scenario` (invalid
capture). PR#7 is now merged. Leave #8 and dependent PRs held until that gate
and the retargeted integration checks are resolved. #17/#19 still have ICMP
formal failures; UNKNOWN is not a protocol counterexample or a pass.

At #20 heada0915d79, job127213432338 passes9 endpoint,17 composed and13 ARP
cases, then rejects the TCP data suite because `scenarios/tcp-data` does not
exist. Correct associations are `scenarios/data` (15) and
`scenarios/connection` (101); do not substitute the new wire scenarios under
the old logical TCP model. A server DeepSeek proposer/reviewer job is preparing
the exact two path corrections and running all intended native cases. No merge
has been performed. The historical snapshot below is retained as incomplete
evidence, not a current all-green claim.

There are thirteen open development PRs, #7 through #19. PRs #1–#6 are
already merged. Remote main is 939ff487b72557983757d3f6a98bcc89673c165d
(merge of #6); the local `main` branch was stale and is not the integration
baseline. Read-only GitHub snapshots are retained in
`artifacts/pr-review-2026-11-05/github-snapshot.json`.

These PRs form one dependency chain, not thirteen alternatives. Their code is
useful cumulative prototype work; merging a milestone does not declare the
complete endpoint or its formal correctness finished.

| PRs | Recommendation at the inspected heads | Reason |
| --- | --- | --- |
| #7 → #8 → #9 → #10 → #11 → #12 → #13 → #14 → #15 → #16 | Eligible for staged integration after base retarget/review | All returned latest-head PR workflow runs succeeded. This is path-filtered CI, not a new complete regression or exhaustive review. Includes flow/native byte support, finite UDP TX/RX and real UDP/ARP peers. |
| #17 | Hold | Its ICMP workflow still fails despite a separately passing immutable release. Keep the unresolved direct formal result visible. |
| #18 | Hold with #17 | Its real ICMP peer passed, but it depends on #17 and does not establish all-input correctness. |
| #19 | Hold with #17/#18 | New composition workflow passed; thirteen returned workflows succeeded, but the inherited ICMP workflow failed. |

At #19 head d2abad5c, run41749928642 has a successful immutable-release
job126312207870 and a failed direct job126312208220 at the ten-stage execution
step. The preceding literal/native tests passed. This split must not be called
all-green or repaired by weakening admission. A separately named invariant
induction task may provide a different explicit theorem; it does not replace
the old BMC report or make UNKNOWN UNSAT.

For manual GitHub integration, start at #7. Mark it Ready for review, set its
base to current main, check the resulting diff and checks, then use **Create a
merge commit**. Repeat #8 through #16 with base main, inspecting each retargeted
diff. Preserve source branch ancestry while the remaining stacked PRs are open;
squash/rebase merges complicate these existing child comparisons. Retargeting
and new merge commits require current checks, not an inference from this
snapshot. Do not bulk-merge #17–#19 or delete all development branches first.

This is a bounded integration assessment, including core task/induction/native
admission spot checks and recorded validation. It is not an independent audit
of every changed line or of English specification interpretation. No remote
merge, review comment or approval was submitted by this assessment.

The user stopped scheduled polling. Leave it stopped. Active development uses
local child agents without reopening the exhausted twelve-call DeepSeek budget.
