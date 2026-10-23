# Upstream reference implementation

`lwip/` contains unmodified upstream lwIP 2.2.1 at commit
`77dcd25a72509eb83f72b033d219b1d40cd8eb95`, tag `STABLE-2_2_1_RELEASE`.
Repository: https://github.com/lwip-tcpip/lwip

Its BSD-style license is preserved in `lwip/COPYING` and individual source headers.
`lwip.lock.json` pins every source/header/license file used by the build. The
protocol model, C port and runner have separate hashes; no upstream source is
patched to force agreement with the model.

The runner compiles the IPv4/TCP/UDP/ICMP/ARP-enabled NO_SYS profile configured in
`ports/lwip/lwipopts.h`. Only the two active TCP handshake cases are exercised by
this harness. Compiled functionality must not be counted as modeled or validated
protocol coverage. IPv6 and socket APIs are disabled in this build.

The initial vendoring command was:

```bash
git clone --depth 1 --branch STABLE-2_2_1_RELEASE \
  https://github.com/lwip-tcpip/lwip.git third_party/lwip
```

Building and running the checked-in source tree needs a C99 compiler, but no
network, TUN, raw sockets, root or Docker.
