# First composed Linux diagnostic: failure retained

Original GitHub ZIP SHA-256 `56f45422312b965c08e2828a407878a6d514e1aba19ab989622140d3450f87fe`, run42444105052/job128619305258/artifact13602806911, contains42 originals. Isolated Linux7.0.0-1017-azure ran the generated C continuously as PID2580. Model/C/native source bindings and all42 file hashes are retained.

The driver incorrectly matched unqualified `ethernet.tx`, but the actual IR declares and C emits `L.ethernet.tx`. Native ARP output stayed in services instead of reaching TAP. There were zero selected TAP injections and zero selected PCAP records. TCP timed out and the capture was invalid for acceptance. This is NOT successful ARP/TCP interoperability, a measured54/58-byte model gap, or an RFC bug. No archived code/ELF/solver was executed in the read-only audit.

The next source correction binds the exact declared model wire message through an explicit generic helper argument, validates the IR message schema before link mutation, and adds real qualified-message/partial-write unit counterexamples. Model, packet bytes, oracle, lwIP and capture checks are unchanged. The original failed run is never upgraded.
