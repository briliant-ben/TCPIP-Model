# IR 0.6 big-endian word packing

IR 0.6 adds one pure total expression:

`bytes_pack32be_mod(int) -> bytes`

For every mathematical integer `n`, set `u = n mod 4294967296` in
`0..4294967295`. The result is exactly four octets in most-significant-first
order: `[floor(u/16777216), floor(u/65536) mod 256,
floor(u/256) mod 256, u mod 256]`. For example, `0x12345678` yields
`12 34 56 78`, `-1` yields `ff ff ff ff`, and `4294967296` yields four zeros.
The operation neither rejects negative/large values nor validates a network
field. A model must express any required uint32 admission guard separately.
A `seq32` value can be represented as an int with the existing
`seq_distance({"seq":0}, value)` expression; no implicit type conversion is added.

The reference uses arbitrary mathematical integers and explicit modulo/quotient.
The independent Z3 backend uses `Int2BV(n,32)` and four `Extract`/`Unit` values
concatenated into a complete `Seq(BV8)`. It never calls reference evaluation.
The native lowering first converts signed `int64_t` to `uint32_t` (the defined
C conversion modulo 2^32), then shifts that unsigned word by 24, 16, 8 and 0.
There is no signed right shift or signed arithmetic overflow. Native input
remains the explicitly bounded signed64 domain; integers beyond it are only
reference/Z3 values and are not silently truncated by the native ABI.

IR 0.6 inherits admitted IR 0.5 byte, packing and checksum expressions, and is
currently restricted to `flat-efsm-atomic-ordered-v1`. Prior versions reject the
new operator; unknown operators still fail validation. Rational/clock/post-target
semantics remain outside the native subset. Length projection rejects all IR
0.6 models. The existing full-sequence invariant-induction checker also rejects
0.6 until its admission is separately extended and validated; this contract uses
the ordinary independent bounded checker instead.

The additive expression uses the existing `direct-c99-byte-access-v4` ABI and
buffer/integer/failure contracts. Generation evidence binds the complete model,
IR version, generator, runtime, symbolic source and generated C hashes. This
retains the existing evidence schema rather than relabeling old generated code;
old evidence is checked with its original Git source. The new runtime helper
changes generated source hashes, so new evidence must be generated afresh.

`model/word32-contract.json` stores and emits the result with a four-byte
invariant. Ten independent literal scenarios pin zero, asymmetric bytes,
unsigned32 boundaries, positive/negative wrap and signed64 endpoints. Dedicated
tests additionally check every octet at each of four positions, arbitrary-Int
symbolic byte-position properties, fixed-input symbolic replay, actual C output,
wrong-endian translation faults and changed-source evidence rejection.
These checks are an arithmetic prerequisite for later explicit TCP/IP layout;
they are not a TCP implementation, network capture, universal compiler proof or
complete-protocol verification.

The first monolithic arbitrary-Int quotient/remainder byte-position query
returned UNKNOWN at 10000 ms and remains an inconclusive diagnostic. A separate
exact decomposition checks three independently exported/reloaded obligations:
all four sequence positions equal their Int2BV32 extracts; unsigned Int2BV32
interpreted as an integer equals `n mod 2^32`; and four arbitrary octets have
their usual big-endian weighted integer concatenation. These connect the exact
four bytes to the mathematical word without fixing `n` or payload content,
adding prestate assumptions, or promoting the original monolithic UNKNOWN.
