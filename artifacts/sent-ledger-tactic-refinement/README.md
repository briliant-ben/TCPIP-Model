# Retained exact tactic recheck: target still unknown

The original S-ACK-VALID -> ESTABLISHED state/length obligation remains unknown. All368 exact violation-disjunct groups and the disjunction-equivalence query were reconstructed from the original SHA-bound primary query, with every other assertion retained. The fixed Z3 CLI pipeline has the unchanged10000ms resource budget.

Result:298 groups plus equivalence independently UNSAT in two fresh CLI processes each;70 groups remain UNKNOWN. No additional group or destination closes relative to the prior single-disjunct attempt. The archive contains all original group scripts, exact canonical execution scripts, producer reports/logs and separate verification reports/logs. Member and whole-archive hashes were checked. This seals partial evidence; the root status remains refinement_unknown and the original primary/partition reports are unchanged.

An exploratory Python tactic run returned UNSAT on group052, but the fresh CLI could not reproduce it within the budget. That result was not promoted. Simple redundant assignment substitution also failed to close it. Exploratory logs are in artifacts/tactic-recheck-preparation; they do not prove a kernel-checked lemma, whole target or encoder correctness. The next encoding work should address modular arithmetic and large conditional/ring assignments, rather than accumulating more solver heuristics.

Run formal/tactic_recheck.py on one extracted source group in a fresh directory, then --verify; a source override allows rechecking retained temporary-path metadata. To reproduce the complete original coverage reconstruction, use run.py in a fresh evidence snapshot. It refuses to overwrite started.json. Raw work files remain at the work_dir recorded in started.json as well as in the committed compressed bundle. No existing uncommitted refinement directory was changed.

Trusted components include Python SMT parsing/correspondence logic and Z3 tactics/CLI. No Rocq/kernel certificate, full-byte/time/interpreter/translator/implementation correspondence, reachable failure, full TCP or unbounded proof is claimed.
