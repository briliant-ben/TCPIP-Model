import copy
import json
from pathlib import Path
import struct
import tempfile
import unittest

from protocol_lab.explore import explore
from protocol_lab.flow import ROOT, build, read, run_scenario, verify_sources
from protocol_lab.ir import Conflict, Machine, ModelError, Uncovered, infer, load
from protocol_lab.packets import compare, normalize_trace, packetdrill, write_pcap


class FlowTests(unittest.TestCase):
    def setUp(self):
        self.model = load(ROOT / "model/tcp.json")

    def scenario(self, name="syn-loss"):
        return read(ROOT / f"scenarios/{name}.json")

    def test_sources_are_pinned(self):
        self.assertEqual([x["rfc"] for x in verify_sources()], [9293, 6298])

    def test_all_scenarios(self):
        for path in (ROOT / "scenarios").glob("*.json"):
            with self.subTest(scenario=path.stem):
                machine = run_scenario(self.model, read(path))
                self.assertEqual(machine.state, "ESTABLISHED")
                self.assertFalse(machine.timers)

    def test_timeout_is_not_early_and_backoff_uses_doubled_rto(self):
        machine = Machine(self.model)
        machine.dispatch("app.connect")
        machine.tick(999)
        self.assertEqual(len(machine.trace), 1)
        machine.tick(1000)
        self.assertEqual(machine.values["retries"], 1)
        self.assertEqual(machine.timers, {"syn_rto": 3000})
        machine.tick(2999)
        self.assertEqual(len(machine.trace), 2)
        machine.tick(3000)
        self.assertEqual(machine.timers, {"syn_rto": 7000})
        syns = [row["emitted"][0]["fields"]["seq"] for row in machine.trace]
        self.assertEqual(syns, [1000, 1000, 1000])
        self.assertEqual(machine.values["snd_nxt"], 1001)

    def test_cancelled_timer_does_not_emit_later(self):
        machine = run_scenario(self.model, self.scenario())
        count = len(machine.trace)
        machine.tick(1000000)
        self.assertEqual(len(machine.trace), count)

    def test_serial_numbers_wrap_at_both_peers(self):
        machine = run_scenario(self.model, self.scenario("sequence-wrap"))
        self.assertEqual(machine.values["snd_una"], 0)
        self.assertEqual(machine.values["snd_nxt"], 0)
        self.assertEqual(machine.values["rcv_nxt"], 0)
        self.assertEqual(machine.trace[-1]["emitted"][0]["fields"]["ack"], 0)

    def test_equal_deadline_runs_timeout_before_network_event(self):
        machine = Machine(self.model)
        machine.dispatch("app.connect")
        machine.dispatch("net.synack", {"seq": 9000, "ack": 1001}, 1000)
        self.assertEqual([r["transition"] for r in machine.trace],
                         ["T-ACTIVE-OPEN", "T-SYN-RETRY", "T-ACCEPT-SYNACK"])

    def test_timer_cannot_be_injected(self):
        machine = Machine(self.model)
        machine.dispatch("app.connect")
        with self.assertRaisesRegex(ModelError, "cannot be injected"):
            machine.dispatch("timer.syn_rto")

    def test_uncovered_is_not_accepted_or_silently_ignored(self):
        machine = Machine(self.model)
        machine.dispatch("app.connect")
        before = machine.snapshot()
        with self.assertRaises(Uncovered):
            machine.dispatch("net.synack", {"seq": 9000, "ack": 1000}, 1001)
        self.assertEqual(machine.snapshot(), before)
        self.assertEqual(machine.now_ms, 0)  # Whole dispatch rolls back, including elapsed timeout.
        self.assertEqual(len(machine.trace), 1)

    def test_overlapping_guards_report_conflict(self):
        duplicate = copy.deepcopy(self.model["transitions"][0])
        duplicate["id"] = "T-CONFLICT"
        self.model["transitions"].append(duplicate)
        with self.assertRaises(Conflict):
            Machine(self.model).dispatch("app.connect")

    def test_plain_integer_ordering_on_seq32_is_rejected(self):
        with self.assertRaisesRegex(ModelError, "expects"):
            infer({"op": "le", "args": [{"var": "snd_una"}, {"var": "snd_nxt"}]}, self.model)

    def test_unknown_code_expression_is_rejected(self):
        with self.assertRaises(ModelError):
            infer({"python": "print('unsafe')"}, self.model)

    def test_missing_requirement_is_rejected(self):
        self.model["transitions"][0]["requirements"] = ["missing"]
        with self.assertRaisesRegex(ModelError, "Unknown requirement"):
            Machine(self.model)

    def test_model_checker_distinguishes_gaps_from_violations(self):
        result = explore(self.model, read(ROOT / "model/exploration.json"))
        self.assertEqual(result["status"], "bounded_pass")
        self.assertTrue(result["uncovered"])
        self.assertFalse(result["counterexamples"])
        self.assertFalse(result["uncovered_transitions"])
        self.assertGreater(result["cutoff_prefixes"], 0)
        self.assertFalse(result["independent_formal_proof"])

    def test_mutation_missing_timer_cancel_has_replayable_counterexample(self):
        rule = self.model["transitions"][2]
        rule["actions"] = [a for a in rule["actions"] if "cancel" not in a]
        result = explore(self.model, read(ROOT / "model/exploration.json"))
        self.assertEqual(result["status"], "fail")
        counterexample = result["counterexamples"][0]
        machine = Machine(self.model, counterexample["initial"])
        with self.assertRaisesRegex(ModelError, "INV-ESTABLISHED-NO-SYN-TIMER"):
            for step in counterexample["steps"]:
                if step.get("tick"):
                    machine.tick(step["at_ms"])
                else:
                    machine.dispatch(step["event"], step["fields"], step["at_ms"])

    def test_mutation_sequence_advance_on_retry_is_caught(self):
        self.model["transitions"][1]["actions"].append({"set": {"var": "snd_nxt", "value": {"op": "seq_add", "args": [{"var": "snd_nxt"}, 1]}}})
        machine = Machine(self.model)
        machine.dispatch("app.connect")
        with self.assertRaisesRegex(ModelError, "INV-SYN-ONE-SEQUENCE"):
            machine.tick(1000)
        self.assertEqual(machine.now_ms, 0)

    def test_bad_network_field_fails_validation(self):
        machine = Machine(self.model)
        machine.dispatch("app.connect")
        with self.assertRaisesRegex(ModelError, "Bad event value"):
            machine.dispatch("net.synack", {"seq": -1, "ack": 1001}, 10)

    def packets(self):
        scenario = self.scenario()
        return normalize_trace(run_scenario(self.model, scenario), scenario)

    def test_loss_annotation_is_at_sender_capture_point(self):
        packets = self.packets()
        self.assertEqual(len(packets), 4)
        self.assertEqual([p["packet_id"] for p in packets if p["dropped_after_egress"]], ["e0001:out:0"])

    def test_bad_drop_pointer_fails(self):
        scenario = self.scenario()
        scenario["environment"]["drop_outgoing"] = ["nonexistent"]
        with self.assertRaisesRegex(ModelError, "nonexistent"):
            normalize_trace(run_scenario(self.model, scenario), scenario)

    def test_pcap_framing_and_checksums(self):
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "trace.pcap"
            write_pcap(path, self.packets())
            data = path.read_bytes()
        self.assertEqual(struct.unpack("<IHHIIII", data[:24]), (0xa1b2c3d4, 2, 4, 0, 0, 65535, 101))
        pos, records = 24, []
        def valid_checksum(data):
            total = sum(int.from_bytes(data[i:i+2], "big") for i in range(0, len(data), 2))
            return (total & 0xffff) + (total >> 16) == 0xffff
        while pos < len(data):
            sec, usec, captured, original = struct.unpack("<IIII", data[pos:pos+16])
            pos += 16
            raw = data[pos:pos+captured]
            pos += captured
            self.assertEqual((captured, original), (40, 40))
            self.assertTrue(valid_checksum(raw[:20]))
            pseudo = raw[12:20] + b"\x00\x06\x00\x14"
            self.assertTrue(valid_checksum(pseudo + raw[20:]))
            records.append((sec*1000+usec//1000, raw[33], int.from_bytes(raw[24:28], "big")))
        self.assertEqual(records, [(0, 2, 1000), (1000, 2, 1000), (1010, 18, 9000), (1010, 16, 1001)])

    def test_packetdrill_relative_numbers_and_line_mapping(self):
        script, mapping = packetdrill(self.packets())
        self.assertIn("+1.000 > S 0:0(0) <...>", script)
        self.assertIn("+0.010 < S. 0:0(0) ack 1 win 65535", script)
        self.assertIn("+0.000 > . 1:1(0) ack 1", script)
        self.assertEqual(len(mapping), 4)
        self.assertIn("< S.", script.splitlines()[mapping[2]["line"]-1])

    def test_oracle_uses_independently_authored_fixture(self):
        observed = read(ROOT / "tests/fixtures/syn-loss.observed.synthetic.json")
        self.assertEqual(compare(self.packets(), observed)["status"], "match")
        observed[-1]["ack"] = 9002
        diff = compare(self.packets(), observed)
        self.assertEqual(diff["status"], "mismatch")
        self.assertEqual(diff["differences"][0]["event_id"], "e0003")
        self.assertIn("TCP-ACCEPT-SYNACK", diff["differences"][0]["requirements"])

    def test_oracle_detects_missing_packets_and_reordering(self):
        packets = self.packets()
        self.assertEqual(compare(packets, packets[:-1])["status"], "mismatch")
        self.assertEqual(compare(packets, list(reversed(packets)))["status"], "mismatch")

    def test_oracle_timing_tolerance_and_malformed_input(self):
        packets = self.packets()
        observed = copy.deepcopy(packets)
        observed[-1]["time_ms"] += 50
        self.assertEqual(compare(packets, observed)["status"], "match")
        observed[-1]["time_ms"] += 1
        self.assertEqual(compare(packets, observed)["status"], "mismatch")
        with self.assertRaises(ModelError):
            compare(packets, [{}])

    def test_build_is_reproducible_and_reports_external_gates(self):
        with tempfile.TemporaryDirectory() as temp:
            report = build(temp)
            first = {p.relative_to(temp): p.read_bytes() for p in Path(temp).rglob("*") if p.is_file()}
            build(temp)
            second = {p.relative_to(temp): p.read_bytes() for p in Path(temp).rglob("*") if p.is_file()}
        self.assertEqual(first, second)
        self.assertEqual(report["formal"]["status"], "not_run")
        self.assertEqual(report["real_stack"]["status"], "not_run")
        self.assertEqual(report["observation_difference"]["status"], "not_run")


if __name__ == "__main__":
    unittest.main()
