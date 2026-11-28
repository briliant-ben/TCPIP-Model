# Generated C

## 1. 10-Module Generated TCP/IPv4 Stack (`generated/stack/`)

[generated/stack/](generated/stack/) is generated directly from
`model/tcpip-stack-system.json` and the 10 IR `0.6` models via `Formal-Spec-Agent`
`system-codegen` (`fsa-system-v1` + `c99-lib-v1`), pinned in
[stack_framework.json](stack_framework.json) (`a11c5e860d0e8552332caf42a0ba9f305bad889e`):

- `fsa_lib_runtime.h` + `tcpip_stack.{h,c}`: shared runtime primitives, static inter-module event bus, slot allocators, and software-architecture hooks.
- `fsa_{sys_port,frame_pool,stack_actor,eth_ip,arp,reass,udp,tcp,dhcp,dns}.{h,c}`: generated C99 state machines (`84,490 B` / `82.51 KiB` total `-Os` `.text` across all 11 `.o` files).
- [host_runtime.h](host_runtime.h) & [host_runtime.c](host_runtime.c): thin protocol-agnostic OS/wire/PCAP adapter supporting `FSA_HOST_NO_SYS=1`, POSIX `pthread` actor mode (`FSA_HOST_NO_SYS=0`), and `FSA_HOST_FREERTOS`.

```sh
python3 code/build_stack.py --out /tmp/tcpip-stack-build --run-size-check --check-freertos
python3 code/regenerate_stack.py --framework ../Formal-Spec-Agent --verify
```

## 2. Preserved v1 Standalone Snapshot (`generated/protocol.c`)

[generated/protocol.c](generated/protocol.c) (`SHA256`:
`42386d6a7b2c7c7081a3b189b707c5141f4967b381c2fcaebb54484ac91b64ae`) and
[generated/manifest.json](generated/manifest.json) remain untouched and pinned to
[framework.json](framework.json) (`500a9a3daf779c48a1678744e32521bc1fd5f2aa`):

```sh
python3 code/build.py --out /tmp/tcpip-case-001 --run-example
python3 code/regenerate.py --framework /path/to/framework-v1 --out /tmp/tcpip-regen-001
```

Next: [tests](../tests/README.md).
