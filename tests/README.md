# Verification & Conformance Tests

```sh
python3 -m unittest discover -s tests -v
```

- **[test_case_study.py](test_case_study.py)**: Unchanged v1 conformance gate verifying the strict 6-directory repository layout, frozen v1 model/C SHA-256 digests (`fixture.json`, `example.in`, `expected.json`, `optimization-regression.json`), live v1 loopback demo, and Lean manifest integrity.
- **[test_generated_stack.py](test_generated_stack.py)** & **[stack_suite.c](stack_suite.c)**: End-to-end verification of the 10-module generated C99 stack across `FSA_HOST_NO_SYS=1`, multithreaded `FSA_HOST_NO_SYS=0` POSIX actor mode, `-DFSA_STRICT=1` runtime invariant/conflict/rollback checking, ASan+UBSan (`make stack-asan`), and ThreadSanitizer (`make stack-tsan`):
  - `sys_port`, `frame_pool`, and `stack_actor` live accounting invariants
  - ARP pending queue + resolution flush + timeout expiry, ICMP Echo, UDP Port Unreachable, and TCP RST
  - IPv4 2- and 3-fragment TX split + in-order & out-of-order RX reassembly + timeout
  - Multi-endpoint UDP (`bind`, `connect`, `send`, `sendto`, `close`)
  - 8 concurrent passive/active TCP connections, payload echo, and 4-way FIN / `TIME_WAIT` reclamation
  - Impaired-wire TCP chaos (SYN drop RTO, segment loss + 3-dupACK fast retransmit + out-of-order coalescing, zero-window persist probing + window updates, FIN retransmit)
  - 2 MiB TCP bulk transfer with exact byte-by-byte verification
  - DHCPv4 DORA lease auto-configuration + DNS A resolution & timeout fallback

Next: [demo](../demo/README.md).
