# Rejected candidate validation, retained unchanged

Original server TAR SHA256:
`7df10aef596746a08edc4d7ad4cfc113cd6d8d082e5e2df481b54ff48c1b7c0d`.
Contains 30 entries from candidate 0028 and corrected-environment run 0029,
including six patched source files, logs, original queries and results.

0028: nine tests, seven errors and one failure. The controller's source export
omitted scenario files; adding those unchanged fixtures without an API request
produced 0029: nine tests, six errors and one failure. The remaining defects
include an invalid tiny test model, fabricated pipeline retention helper and
wrong recursive SMT token assertion. Neither suite passed or was integrated.

Both runs separately recorded the unchanged ICMP model's depth-two, 60-second
exact-v1 safety/overlap queries as UNSAT. That result does not accept the failing
candidate or replace any earlier UNKNOWN. Later repairs and retained actual
pipeline evidence are in `../exact-backend-retained-0036/`.
