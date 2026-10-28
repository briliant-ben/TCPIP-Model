"""Independent wire fixtures and simulated external records are test inputs only.

Nothing created here is evidence of running a real Linux implementation.
"""
import copy
import importlib.util
from pathlib import Path
import socket
import struct
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from protocol_lab.capture import decode, normalize
from protocol_lab.evidence import assess, binding, check_observation, ensure_snapshot, observe
from protocol_lab.flow import ROOT, build, digest, read, run_packetdrill, write
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.packets import compare
from protocol_lab.symbolic import Encoding, check, replay

HAS_Z3 = importlib.util.find_spec("z3") is not None
PROFILE = {"local": {"ip": "192.0.2.1", "port": 40000}, "peer": {"ip": "192.0.2.2", "port": 8080}}


def wire_fixture(path, link=1, big=False, nano=False, corrupt=False, payload=b"", flags_override=None, vlan=False, rows=None):
    """Hand-built capture: shifted epoch/ISS, SYN options, no production encoder."""
    def ck(raw):
        raw += b"\0" if len(raw) % 2 else b""
        total = sum(int.from_bytes(raw[n:n+2], "big") for n in range(0, len(raw), 2))
        while total >> 16:
            total = (total & 65535) + (total >> 16)
        return (65535-total).to_bytes(2, "big")
    endian = ">" if big else "<"
    magic = 0xa1b23c4d if nano else 0xa1b2c3d4
    result = struct.pack(endian+"IHHIIII", magic, 2, 4, 0, 0, 65535, link)
    defaults = [
        (0, True, 2, 0xffffffff, 0), (1000, True, 2, 0xffffffff, 0),
        (1010, False, 18, 55, 0), (1010, True, 16, 0, 56)]
    for i, row in enumerate(defaults if rows is None else rows):
        ms, outbound, flags, seq, ack = row[:5]
        window = row[5] if len(row) > 5 else 12345
        packet_payload = row[6] if len(row) > 6 else payload
        source, dest = ("192.0.2.1", "192.0.2.2") if outbound else ("192.0.2.2", "192.0.2.1")
        sport, dport = (40000, 8080) if outbound else (8080, 40000)
        src, dst = socket.inet_aton(source), socket.inet_aton(dest)
        options = b"\x02\x04\x05\xb4" if flags == 2 else b""
        body = struct.pack("!HHIIBBHHH", sport, dport, seq, ack, ((20+len(options))//4)<<4,
                           flags_override if flags_override is not None else flags, window, 0, 0) + options + packet_payload
        pseudo = src+dst+b"\0\x06"+len(body).to_bytes(2,"big")
        body = body[:16]+ck(pseudo+body)+body[18:]
        if corrupt and i == 0:
            body = body[:16]+b"\0\0"+body[18:]
        header = struct.pack("!BBHHHBBH4s4s", 0x45, 0, 20+len(body), 100+i, 0, 64, 6, 0, src, dst)
        header = header[:10]+ck(header)+header[12:]
        packet = header+body
        if link == 1:
            packet = b"\x11"*6+b"\x22"*6 + (b"\x81\x00\x00\x07\x08\x00" if vlan else b"\x08\x00") + packet
        elif link == 113:
            packet = b"\0"*14+b"\x08\x00"+packet
        sec, milli = divmod(ms, 1000)
        result += struct.pack(endian+"IIII", 123000+sec, milli*(1000000 if nano else 1000), len(packet), len(packet))+packet
    Path(path).write_bytes(result)


class CaptureTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name)/"capture.pcap"
        self.expected = read(ROOT/"tests/fixtures/syn-loss.observed.synthetic.json")
        for i, packet in enumerate(self.expected):
            packet.update(packet_id=f"p{i}", event_id=f"e{i}", requirements=["test"])

    def test_wire_iss_epoch_options_and_endian_normalization(self):
        for link, big, nano, vlan in [(1,False,False,False),(101,True,False,False),(113,False,True,False),(1,True,True,True)]:
            with self.subTest(link=link,big=big,nano=nano,vlan=vlan):
                wire_fixture(self.path,link,big,nano,vlan=vlan)
                packets, metadata = normalize(self.path, PROFILE, self.expected, "synthetic")
                self.assertEqual(compare(self.expected,packets)["status"],"match")
                self.assertEqual(metadata["wire_local_iss"],0xffffffff)
                self.assertEqual(metadata["wire_peer_iss"],55)
                self.assertEqual(metadata["selected_packets"],4)

    def test_unrelated_connection_is_filtered(self):
        wire_fixture(self.path)
        bad_profile = copy.deepcopy(PROFILE)
        bad_profile["local"]["port"] = 40001
        with self.assertRaisesRegex(ModelError,"initial outgoing SYN"):
            normalize(self.path,bad_profile,self.expected)

    def test_checksum_policy_is_explicit_and_recorded(self):
        wire_fixture(self.path,corrupt=True)
        with self.assertRaisesRegex(ModelError,"checksum"):
            normalize(self.path,PROFILE,self.expected)
        _, meta = normalize(self.path,PROFILE,self.expected,checksum_policy="record_offload")
        self.assertEqual(meta["checksum_warning_frames"],[1])

    def test_truncation_and_unknown_format_are_rejected(self):
        wire_fixture(self.path)
        raw = self.path.read_bytes()
        for content in (raw[:10],raw[:-1],b"\x0a\x0d\x0d\x0a"+raw[4:]):
            self.path.write_bytes(content)
            with self.assertRaises(ModelError):
                list(decode(self.path))

    def test_payload_and_unknown_flags_are_rejected(self):
        for kwargs in ({"payload":b"hi"},{"flags_override":6}):
            wire_fixture(self.path,**kwargs)
            with self.assertRaises(ModelError):
                normalize(self.path,PROFILE,self.expected)

    def test_nonmonotonic_timestamps_are_rejected(self):
        wire_fixture(self.path,link=101)
        raw = bytearray(self.path.read_bytes())
        first_len = struct.unpack("<I",raw[32:36])[0]
        second = 24+16+first_len
        raw[second:second+4] = (1).to_bytes(4,"little")
        self.path.write_bytes(raw)
        with self.assertRaisesRegex(ModelError,"Nonmonotonic"):
            list(decode(self.path))


@unittest.skipUnless(HAS_Z3,"optional Z3 backend not installed")
class SymbolicTests(unittest.TestCase):
    def setUp(self):
        self.model = load(ROOT/"model/tcp.json")

    def test_symbolic_all_32bit_iss_and_event_fields(self):
        result = check(self.model)
        self.assertEqual(result["status"],"bounded_pass")
        self.assertEqual(result["sequence_width"],32)
        self.assertEqual(result["safety_query"],"unsat")
        self.assertEqual(result["replay"]["status"],"match")

    def test_exported_queries_run_in_a_fresh_solver(self):
        import z3
        with tempfile.TemporaryDirectory() as tmp:
            result = check(self.model,out=tmp)
            for name in ("model.smt2","overlap.smt2"):
                solver = z3.Solver()
                solver.from_file(str(Path(tmp)/name))
                self.assertEqual(solver.check(),z3.unsat)

    def test_missing_cancel_counterexample_replays(self):
        rule = self.model["transitions"][2]
        rule["actions"] = [a for a in rule["actions"] if "cancel" not in a]
        result = check(self.model)
        self.assertEqual(result["status"],"counterexample")
        self.assertEqual(result["replay"]["status"],"runtime_rejected")
        self.assertIn("INV-ESTABLISHED-NO-SYN-TIMER",result["replay"]["error"])

    def test_negative_timer_is_not_silently_pruned(self):
        self.model["transitions"][0]["actions"][-1]["arm"]["delay_ms"] = -1
        result = check(self.model)
        self.assertEqual(result["status"],"counterexample")
        self.assertIn("duration must be positive",result["replay"]["error"])

    def test_dead_end_prefix_is_still_checked(self):
        self.model["transitions"] = self.model["transitions"][:1]
        self.model["transitions"][0]["actions"][1]["set"]["value"]["args"][1] = 2
        result = check(self.model)
        self.assertEqual(result["status"],"counterexample")

    def test_overlapping_rules_are_detected(self):
        rule = copy.deepcopy(self.model["transitions"][0])
        rule["id"] = "T-CONFLICT"
        self.model["transitions"].append(rule)
        self.assertEqual(check(self.model)["status"],"conflict")

    def test_all_reference_scenarios_crosscheck_symbolic_semantics(self):
        for path in (ROOT/"scenarios").glob("*.json"):
            with self.subTest(scenario=path.stem):
                scenario = read(path)
                runtime = Machine(self.model,scenario["initial"])
                for step in scenario["steps"]:
                    runtime.dispatch(step["event"],step["fields"],step["at_ms"])
                enc = Encoding(self.model,len(runtime.trace),["iss"])
                z = enc.z
                enc.solver.add(enc.frames[0]["values"]["iss"] == z.BitVecVal(scenario["initial"]["iss"],32))
                for i,row in enumerate(runtime.trace):
                    rule_idx = next(n for n,r in enumerate(self.model["transitions"]) if r["id"] == row["transition"])
                    enc.solver.add(z.Int(f"choice_{i}") == rule_idx,enc.frames[i+1]["now"] == row["time_ms"])
                    for name,value in row["event"]["fields"].items():
                        enc.solver.add(enc.events[i][row["event"]["name"]][name] == z.BitVecVal(value,32))
                self.assertEqual(enc.solver.check(),z.sat)
                self.assertEqual(replay(self.model,enc.witness(enc.solver.model()))["status"],"match")


class EvidenceTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.out = Path(self.temp.name)/"build"
        build(self.out)
        self.capture = Path(self.temp.name)/"wire.pcap"
        wire_fixture(self.capture)

    def test_missing_results_cannot_pass(self):
        result = assess(self.out,["syn-loss"])
        self.assertEqual(result["status"],"pending")
        self.assertEqual(result["scenarios"][0]["observation"]["status"],"not_run")

    def test_synthetic_capture_cannot_be_promoted_by_relabeling(self):
        observe(self.out,"syn-loss",self.out/"syn-loss/model.synthetic.pcap",PROFILE,"external_capture")
        self.assertEqual(check_observation(self.out,"syn-loss")["status"],"synthetic_only")

    def test_unverified_origin_is_not_real_evidence(self):
        observe(self.out,"syn-loss",self.capture,PROFILE)
        self.assertEqual(check_observation(self.out,"syn-loss")["status"],"unverified_origin")

    def test_capture_matching_requires_explicit_external_assertion(self):
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        result = check_observation(self.out,"syn-loss")
        self.assertEqual(result["status"],"unbound_run")

    def test_tampered_normalized_trace_is_rejected(self):
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        path = self.out/"syn-loss/observation/packets.json"
        packets = read(path)
        packets[-1]["ack"] += 1
        write(path,packets)
        self.assertEqual(assess(self.out,["syn-loss"])["scenarios"][0]["observation"]["status"],"invalid")

    def test_script_change_invalidates_local_snapshot(self):
        path = self.out/"syn-loss/test.pkt"
        path.write_text(path.read_text()+"// changed\n")
        with self.assertRaisesRegex(ModelError,"artifact changed"):
            ensure_snapshot(self.out)
        self.assertEqual(assess(self.out)["status"],"fail")

    def test_stale_observation_binding_is_rejected(self):
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        path = self.out/"syn-loss/observation/evidence.json"
        record = read(path)
        record["binding"]["build_sha256"] = "0"*64
        write(path,record)
        self.assertEqual(assess(self.out,["syn-loss"])["status"],"fail")

    def test_changed_execution_log_is_rejected(self):
        self.simulated_run()
        (self.out/"syn-loss/external.log").write_text("changed\n")
        self.assertEqual(assess(self.out,["syn-loss"])["scenarios"][0]["packetdrill"]["status"],"invalid")

    def test_runner_preflight_does_not_invoke_missing_tool(self):
        env = {"platform":"linux","packetdrill":None,"tun":False,"cap_net_admin":False,"cap_net_raw":False}
        with patch("protocol_lab.flow.preflight",return_value=env),patch("protocol_lab.flow.subprocess.run") as process:
            result = run_packetdrill(self.out/"syn-loss/test.pkt",self.out/"syn-loss")
        process.assert_not_called()
        self.assertEqual(result["status"],"not_run")
        self.assertEqual(result["binding"],binding(self.out,"syn-loss"))

    def test_runner_success_and_timeout_replace_old_result(self):
        env = {"platform":"linux","packetdrill":sys.executable,"tun":True,"cap_net_admin":True,"cap_net_raw":True}
        script, out = self.out/"syn-loss/test.pkt",self.out/"syn-loss"
        completed = subprocess.CompletedProcess(["fixture"],0,"simulated tool output\n","")
        with patch("protocol_lab.flow.preflight",return_value=env),patch("protocol_lab.flow.subprocess.run",return_value=completed):
            result = run_packetdrill(script,out)
        self.assertEqual(result["status"],"pass")
        self.assertEqual(result["log_sha256"],digest(out/"external.log"))
        with patch("protocol_lab.flow.preflight",return_value=env),patch("protocol_lab.flow.subprocess.run",side_effect=subprocess.TimeoutExpired("fixture",30)):
            timeout = run_packetdrill(script,out)
        self.assertEqual(timeout["status"],"fail")
        self.assertNotEqual(timeout["run_id"],result["run_id"])
        self.assertEqual(read(out/"external-run.json")["status"],"fail")

    def test_rebuilding_does_not_hash_external_evidence_as_local_input(self):
        before = digest(self.out/"report.json")
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        assess(self.out,["syn-loss"])
        build(self.out)
        self.assertEqual(digest(self.out/"report.json"),before)

    def test_failed_replacement_cannot_reuse_old_observation(self):
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        self.capture.write_bytes(b"bad")
        with self.assertRaises(ModelError):
            observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        self.assertEqual(assess(self.out,["syn-loss"])["scenarios"][0]["observation"]["status"],"invalid")

    def test_explicit_offload_warning_requires_review(self):
        wire_fixture(self.capture,corrupt=True)
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture","record_offload")
        self.simulated_run()
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture","record_offload")
        self.assertEqual(check_observation(self.out,"syn-loss")["status"],"checksum_review_required")

    def simulated_run(self):
        log = self.out/"syn-loss/external.log"
        log.write_text("simulated subprocess output for unit test\n")
        write(self.out/"syn-loss/external-run.json", {"status":"pass","returncode":0,"binding":binding(self.out,"syn-loss"),
            "script_sha256":digest(self.out/"syn-loss/test.pkt"),"tool_sha256":"f"*64, "kernel":"fixture", "run_id":"fixture",
            "log_sha256":digest(log)})

    def test_observation_cannot_be_reused_for_different_execution(self):
        self.simulated_run()
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        self.assertEqual(check_observation(self.out,"syn-loss")["status"],"pass")
        path = self.out/"syn-loss/external-run.json"
        result = read(path)
        result["run_id"] = "different-run"
        write(path,result)
        with self.assertRaisesRegex(ModelError,"different external execution"):
            check_observation(self.out,"syn-loss")

    @unittest.skipUnless(HAS_Z3,"optional Z3 backend not installed")
    def test_simulated_external_gate_and_stale_formal_query(self):
        # Simulated process results test the gate; they do not establish real-stack evidence.
        result = check(load(ROOT/"model/tcp.json"),out=self.out/"formal")
        result["build_sha256"] = digest(self.out/"report.json")
        write(self.out/"formal/result.json",result)
        self.simulated_run()
        observe(self.out,"syn-loss",self.capture,PROFILE,"external_capture")
        self.assertEqual(assess(self.out,["syn-loss"])["status"],"selected_scenarios_closed_loop_pass")
        path = self.out/"formal/model.smt2"
        path.write_text(path.read_text()+"; stale\n")
        self.assertEqual(assess(self.out,["syn-loss"])["formal"]["status"],"invalid")


if __name__ == "__main__":
    unittest.main()
