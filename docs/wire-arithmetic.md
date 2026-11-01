# IR0.4 pure packing and Internet checksum arithmetic

## Types and exact semantics

IR0.4 currently admits atomic-ordered-v1 only, with the IR0.2 data types/operators
and three new pure total expressions. Rational/clock-v3/post targets are not
silently admitted. Old IR versions reject these new operators. Other proposed
UDP-specific callback operators remain unsupported. No protocol guard, address,
port, layout or checksum-presence policy is embedded in these operators.

| Operator | Argument/result | Exact total value |
|---|---|---|
| bytes_pack8_mod | int -> bytes | one octet n modulo256 |
| bytes_pack16be_mod | int -> bytes | two big-endian octets of n modulo65536 |
| bytes_internet_checksum16 | bytes -> int | complement of end-around-carry16-bit sum of big-endian pairs; final odd octet paired with zero |

Packing is explicitly modular, including negative/unbounded reference integers.
It is not checked uint8/uint16 admission: protocol IR guards must separately reject
invalid wire fields. Existing signed64 native input/literal limits remain explicit;
reference and symbolic integer domains stay mathematical integers. Byte capacity
remains4096 per input/state/intermediate in native code, with no truncation.
Checksum returns0..65535; empty/all-zero sequences return65535 and[255,255]
returns0. UDP transmit0-to65535 mapping and receive absent-checksum acceptance
must remain explicit protocol IR expressions; they are not arithmetic semantics.

The algorithm interpretation follows RFC1071§1 (September1988), equations1/2,
with the numerical vector in§3:0001 f203 f4f5 f6f7 has folded sum ddf2, checksum
220d. RFC1071 is an informational techniques memo, not a protocol standard.
The official original text is pinned by the task. RFC768 supplies UDP-specific
checksum policy later; this contract is not a UDP wire implementation.

## Independent execution and limitations

Reference sums a full Python integer list of words, then folds high carry until
none remains. Z3 independently defines an exact recursive finite-sequence/BV16
sum: pair head octets, recursively checksum the remaining sequence, widen both
words to17 bits before addition, then fold bit16 into the low16. The final result
is unsigned BV2Int of BVNot. No runtime checksum function is used to construct
symbolic expressions, no length cut-off, Python precomputation or length-only
approximation substitutes for content. Exported SMT includes the recursive
definition and is round-trip checked in a fresh solver. General recursive goals
may time out/return UNKNOWN and must keep that status.

Native C folds a uint32 accumulator after each word and complements once; thus
each addition fits17 bits. C packing uses explicit uint8/uint16 modulo conversion
and network byte order. Native backend ID changes to direct-c99-wire-arithmetic-v3;
old native artifacts require the original Git checker, not relaxed old hashes.
The length-projection backend rejects every new operator. Existing Rocq trial
compilers accept their old closed IR0.2 slice and do not establish IR0.4 theorems.

The finite contract checks packed length and checksum range, not universal checksum
correctness or compiler translation. Literal fixtures include RFC1071, odd/NUL,
carry, both zeros and signed64 limits. A swapped-endian C translation preserves
length/range invariants but is rejected by exact output comparison. New pure ops
do not yet provide receive byte indexing or a complete IP/UDP packet codec.

## Rejected agent design

The raw response in artifacts/udp-wire-design-0001 is retained unmodified. It is
not accepted wholesale: it embeds UDP absent/zero policies in proposed arithmetic
ops despite saying those should be explicit IR; its pseudoheader is inconsistently
called16 bytes (UDP IPv4 pseudoheader is12); width16 cannot retain an addition's
carry without widening. The proposed max512 profile is not a superset of4096.
Fixture AC2 contains nonzero protocol17, UDP length8 and destination port80;
its arithmetic checksum is ff8e, not zero/ffff. AC4 claims an even10-octet
segment but supplies11 octets (three data bytes), so it is not a valid fixed
wire oracle. Those outputs are not silently corrected into accepted agent evidence.
The implemented three operator semantics above are a controller-reviewed subset
with independently fixed literals; no unsupported new operator is silently ignored.
