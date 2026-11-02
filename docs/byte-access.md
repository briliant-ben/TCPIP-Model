# IR0.5 exact total byte access

bytes_at_or_zero(bytes,int)->int returns the selected octet only when
0<=offset<length, otherwise0. Negative offsets do not index from the end; zero
outside the range is a declared total value, not packet acceptance or an implicit
protocol drop. Protocol guards MUST still check required input/header lengths.

IR0.5 is the IR0.4 atomic-ordered-v1 data subset plus this operator; earlier
versions reject byte access. IR0.4 packing/checksum also work in0.5. Rational,
clock/post semantics remain unadmitted in the native subset. No packet parser or
protocol policy is added to host callbacks. Existing buffers4096 and signed64
native integer/intermediate domain remain explicit; reference offsets and symbolic
Int are unbounded mathematical integers. No read truncates a byte buffer to fit.

Reference uses explicit Python bounds before indexing. Independent Z3 uses an
integer range guard and BV2Int of Seq(BV8) indexing on the valid branch, zero
otherwise; unspecified out-of-range SeqNth never affects the result. No reference
lookup constructs the symbolic term. The length-only projection rejects byte
access. C tests the sign and unsigned offset against length before indexing,
without offset+1 overflow; invalid buffer capacity rejects separately.

New native ID direct-c99-byte-access-v4 requires fresh generation/build. Original
v3 artifacts stay bound to their original Git checkers. Bounded range checking and
fixed lookup/translation tests do not prove a universal compiler correspondence.
This capability is a prerequisite for explicit raw IPv4/UDP receive IR, which is
not implemented by this arithmetic/lookup contract. Receive models must classify
short, malformed, unsupported and out-of-scope inputs in their own IR guards.
