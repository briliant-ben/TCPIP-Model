# Exact solver candidate regression and final source

Original TAR SHA256:
`226843d626e4c8a33b0ab8adf72ed94a2c2b5d235459d55a2ba244fbeab81359`.

Twelve related modules / 115 distinct test methods passed using the final
applicable run for each module. 0041 first failed two pipeline tests because
the controller's export omitted original `bindings/` files, and clock tests
could not import the omitted original `formal/` package. The original failures
and logs are retained. 0042/0043 restore those unchanged Git e0629985 files in
new copies, with archive hashes and no paid API retry or mutation of 0041.

0043 also closes a real verifier omission: absent exact-v1 tactic/source fields
must be rejected, rather than defaulted to the expected values. Two fully
rehashed metadata-deletion tests pass. Final four modules: clock 15, pipeline
20, preprocessing 13, interrupted journals 7. Other eight modules' original
successful logs remain in 0041. Repeated runs are not summed as new methods.

The archive includes all original status/provenance/controllers/logs and the
seven exact source files integrated from this candidate. Source hashes and
test results detect changes but require trust in the SSH-collected server
execution; this is not a whole-repository regression, CI attestation, live TCP
or an unbounded/compiler proof. The later CLI call-site correction and two
actual CLI tests are separate integration changes, not fabricated 0043 results.
