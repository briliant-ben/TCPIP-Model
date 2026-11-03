# Local preparation, not network acceptance

Seven adapter methods pass (one-PID13 live C inputs, literal byte oracle/zero
checksums, malformed/gap inputs, valid-checksum wrongID, reset/ingress/PID/SMT
witness tampering, synthetic PCAP truncation and namespace rejection). Eight
existing ICMP methods also pass13 fixed reference/native/Z3 cases. Initial local
harness omitted scenario.expect; its failure log is preserved, then only harness
expect was fixed. Mac preflight explicitly blocked Linux root/TUN/tools, not a
passed peer run. No paid API or server deployment. Parent4501fdb8 has15 successful
workflows, ICMP two jobs fail; earlierb7 release success remains separate.
