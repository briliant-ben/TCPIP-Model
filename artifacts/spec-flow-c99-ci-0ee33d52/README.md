# Actual Ubuntu native-generation checkpoint

Source0ee33d52, checkout merge3d3a0d06, CI41212382314/job124569888828.
Official artifact13046537061 ZIP SHA96e5c854... is retained byte-for-byte,
with official API provenance and lossless decoded job-log gzip. The ZIP retains
the Linux ELF as original evidence; no separate local build executable is tracked.
No artifact executable or archive-supplied code is executed by local acceptance.

12 native generation tests pass in3.103s. Ubuntu GCC13.3.0 then generates,
compiles with C99/Wall/Wextra/Werror, and runs the actual active-open syn-loss
input through the independent native implementation. Three transitions, emitted
fields, state and timers exactly match the separate Python reference oracle.
Generated C bytes match the local Mac checkpoint; compiler/executable hashes
remain platform-specific, with no binary-hash waiver.

Ten runtime source inputs are hash-bound by actual stage records. Two additional
workflow/test sources rely on the official checkout/job provenance. All twelve
match immutable named Git blobs. Original ZIP entries and the ELF hash, code
reconstruction, stdin, raw observation and Difference are independently audited.
Run accept.py at this source epoch. This audit is not a local Linux execution or
new native test run. GitHub runner/checkout/toolchain provenance and the trusted
Python bridge/oracle remain part of the evidence boundary.

This verifies an actual Linux build/execution channel for generated scalar code.
It does not count as Linux TCP networking/PCAP, IPv4 input/output, byte-buffer
support, a generator proof, second-spec migration, or completion of the full flow.
