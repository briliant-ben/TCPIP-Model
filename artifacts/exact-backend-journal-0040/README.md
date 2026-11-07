# Query journaling candidate: seven plus eleven tests passed

Original TAR SHA256:
`f5cbaa8b4a32cf2bc7c86b454e8bf55fdb89f8f207c1756cf0e2aeea7dc17d19`.

DeepSeek 0039 supplied anchored `check()` journal edits and six tests. Static
checking preserved the ordered AST of solver mutations and Encoding calls.
Its first test run had five errors: a guessed `z3.Solver.solve` API and implicit
`iss` initial-variable selection on a fixture without `iss`.

Controller 0040 corrected only the actual test API to `Encoding.solve`, explicit
empty symbolic-initial lists, and strict successful verdicts. It added sample
SMT persistence before the third solve and a corresponding interruption test.
The earlier tautological recursive-definition assertion was replaced by actual
recursive symbol/body checks and a real empty-checksum SAT value check. No
production protocol model, oracle or solver obligation was changed.

Actual server results: seven journal tests and eleven preprocessing tests passed,
zero failures/errors/skips. Safety, overlap and sample interruptions preserve
their original query files without a completed result report. Nonempty output
directories are refused without modifying their contents; normal results bind
both original query hashes. The default policy remains `none`.

This package retains the original failing run, repaired source and successful
logs. It is not a new all-protocol proof, production adoption or Linux TCP peer
evidence. Broader twelve-module candidate regression is job
`exact-backend-regression-20261107-0041`; inspect its actual terminal results.
The three full earlier pipeline jobs remain separately bound in
`../exact-backend-retained-0036/`. All prior UNKNOWN records remain unchanged.
