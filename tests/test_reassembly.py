import copy
import importlib.util
import itertools
from pathlib import Path
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.ir import HALF, MOD, Machine, ModelError, Uncovered, load, model_files
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets, profile_inputs, run_profile, scenario_paths
from protocol_lab.symbolic import crosscheck_trace, encode_trace, replay


def established(irs=9000):
    m = Machine(load(ROOT / "model/tcp-reassembly.json"))
    m.dispatch("app.connect")
    m.dispatch("net.synack", {"seq": irs, "ack": 1001, "window": 8}, 10)
    return m


def receive(m, seq, data, at=20):
    m.dispatch("net.data", {"seq": seq % MOD, "ack": 1001, "window": 8, "data": data}, at)


def queue(m):
    return {i: m.values[f"rx_slot_{i:02d}"] for i in range(16) if m.values[f"rx_slot_{i:02d}"]}


class ReassemblyTests(unittest.TestCase):
    def test_all_data_reassembly_and_connection_scenarios(self):
        model = load(ROOT / "model/tcp-reassembly.json")
        for directory in ("scenarios/data", "scenarios/reassembly", "scenarios/connection"):
            for path in sorted((ROOT / directory).glob("*.json")):
                with self.subTest(scenario=path.stem):
                    scenario = read(path)
                    if directory == "scenarios/connection":
                        for step in scenario["steps"]:
                            if step.get("event") in ("net.ack", "net.synack"):
                                step["fields"]["window"] = 8
                    run_scenario(model, scenario)

    def test_gap_is_retained_and_drained_before_one_cumulative_ack(self):
        m = established()
        receive(m, 9003, [128, 255])
        self.assertEqual(queue(m), {2: [128], 3: [255]})
        self.assertEqual(m.values["rcv_nxt"], 9001)
        self.assertEqual(m.values["rcv_buf"], [])
        receive(m, 9001, [0, 1], 30)
        self.assertEqual(queue(m), {})
        self.assertEqual(m.values["rcv_buf"], [0, 1, 128, 255])
        emitted = m.trace[-1]["emitted"]
        self.assertEqual(len(emitted), 1)
        self.assertEqual(emitted[0]["fields"]["ack"], 9005)
        self.assertEqual(emitted[0]["fields"]["window"], 12)

    def test_all_four_segment_permutations_and_duplicates_deliver_once(self):
        content = [0, 128, 255, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        for order in itertools.permutations(range(4)):
            with self.subTest(order=order):
                m = established()
                for t, part in enumerate(order):
                    body = content[part*4:part*4+4]
                    receive(m, 9001+part*4, body, 20+t*2)
                    receive(m, 9001+part*4, body, 21+t*2)
                self.assertEqual(m.values["rcv_buf"], content)
                self.assertEqual(m.values["rcv_nxt"], 9017)
                self.assertEqual(m.values["local_window"], 0)
                self.assertEqual(queue(m), {})
                m.dispatch("app.receive", {"count": 16}, 40)
                self.assertEqual(m.trace[-1]["emitted"][0]["fields"]["data"], content)
                self.assertEqual(m.values["local_window"], 16)

    def test_conflicting_overlap_keeps_first_accepted_octet(self):
        m = established()
        receive(m, 9003, [128, 255])
        receive(m, 9002, [1, 2, 3, 4], 21)
        self.assertEqual(queue(m), {1: [1], 2: [128], 3: [255], 4: [4]})
        receive(m, 9001, [0], 22)
        self.assertEqual(m.values["rcv_buf"], [0, 1, 128, 255, 4])

    def test_read_retains_queue_coordinates_and_wraps_sequence_space(self):
        m = established(MOD-3)
        receive(m, 2, [4, 5])
        receive(m, MOD-2, [0, 1], 21)
        self.assertEqual(m.values["rcv_nxt"], 0)
        self.assertEqual(queue(m), {2: [4], 3: [5]})
        m.dispatch("app.receive", {"count": 2}, 30)
        self.assertEqual(queue(m), {2: [4], 3: [5]})
        receive(m, 0, [128, 255], 40)
        self.assertEqual(m.values["rcv_nxt"], 4)
        self.assertEqual(m.values["rcv_buf"], [128, 255, 4, 5])
        self.assertEqual(queue(m), {})

    def test_outside_window_and_table6_full_span_do_not_store_payload(self):
        m = established()
        receive(m, 9017, [16, 17])
        self.assertEqual(queue(m), {})
        receive(m, 9001, list(range(14)), 21)
        before = m.values["rcv_buf"].copy()
        # Window [9015,9017); neither endpoint of [9013,9019) is in it.
        receive(m, 9013, [12, 13, 14, 15, 16, 17], 22)
        self.assertFalse(m.values["rx_acceptable"])
        self.assertEqual(m.values["rcv_buf"], before)
        self.assertEqual(m.values["rcv_nxt"], 9015)
        receive(m, 9015, [14, 15], 23)
        receive(m, 9017, [16], 24)
        self.assertEqual(m.values["rcv_buf"], list(range(16)))
        self.assertEqual(m.values["rcv_nxt"], 9017)
        self.assertEqual(queue(m), {})

    def test_close_with_gap_and_unsupported_piggyback_are_transactional_gaps(self):
        m = established()
        receive(m, 9003, [128, 255])
        for event, fields in [("app.close", {}), ("net.fin", {"seq": 9001, "ack": 1001}),
                              ("net.data", {"seq": (9001+HALF) % MOD, "ack": 1001, "window": 8, "data": [1]}),
                              ("net.data", {"seq": 9001, "ack": 1002, "window": 8, "data": [1]})]:
            before = m.snapshot()
            with self.subTest(event=event), self.assertRaises(Uncovered):
                m.dispatch(event, fields, 30)
            self.assertEqual(m.snapshot(), before)

    def test_missing_queue_and_overwrite_mutants_fail_content_scenario_oracle(self):
        for fault in ("missing_cell", "overwrite_cell"):
            model = load(ROOT / "model/tcp-reassembly.json")
            r = next(r for r in model["transitions"] if r["id"] == "R-RECEIVE")
            action = next(a["set"] for a in r["actions"] if a.get("set", {}).get("var") == "rx_slot_02")
            scenario = "ooo-gap-fill-no-retransmission"
            if fault == "missing_cell":
                action["value"] = {"bytes": []}
            else:
                scenario = "ooo-conflicting-overlap-first-wins"
                empty = {"op": "eq", "args": [{"op": "bytes_len", "args": [{"var": "rx_slot_02"}]}, 0]}
                def remove_empty(expr):
                    if expr == empty:
                        return True
                    if type(expr) is dict and "args" in expr:
                        return {**expr, "args": [remove_empty(a) for a in expr["args"]]}
                    return expr
                action["value"] = remove_empty(action["value"])
            with self.subTest(fault=fault), self.assertRaisesRegex(ModelError, "Scenario variable mismatch"):
                run_scenario(model, read(ROOT / f"scenarios/reassembly/{scenario}.json"))

    def test_premature_ack_is_detected_even_when_final_state_matches(self):
        model = load(ROOT / "model/tcp-reassembly.json")
        scenario = read(ROOT / "scenarios/reassembly/ooo-gap-fill-no-retransmission.json")
        expected = control_packets(run_scenario(model, scenario), scenario)
        bad = copy.deepcopy(model)
        r = next(r for r in bad["transitions"] if r["id"] == "R-RECEIVE")
        r["actions"].insert(1, r["actions"].pop())
        actual = control_packets(run_scenario(bad, scenario), scenario)
        result = compare(expected, actual, projection="tcp-data-v1")
        self.assertEqual(result["status"], "mismatch")
        self.assertTrue(any(d.get("field") == "ack" and d["expected"] == 9005 and d["observed"] == 9001 for d in result["differences"]))

    def test_multiple_scenario_sources_and_model_bases_are_bound(self):
        profile = next(p for p in read(ROOT / "profiles.json")["profiles"] if p["id"] == "tcp-reassembly")
        model = load(ROOT / profile["model"])
        self.assertEqual({p.name for p in model_files(ROOT / profile["model"])}, {"tcp-reassembly.json", "tcp-data.json", "tcp-connection.json"})
        inputs = profile_inputs(profile, model)
        self.assertIn("scenarios/data/sequence-wrap-data.json", inputs)
        self.assertIn("scenarios/reassembly/ooo-sequence-wrap.json", inputs)
        self.assertIn("docs/tcp-reassembly.md", inputs)
        for sources in ([], ["scenarios/data", "scenarios/data"], ["../outside"]):
            with self.assertRaises(ModelError):
                scenario_paths({**profile, "scenarios": sources})
        with tempfile.TemporaryDirectory() as tmp:
            result = run_profile(profile, tmp)
            self.assertEqual(result["status"], "reference_pass")
            self.assertEqual(len(result["scenarios"]), len(scenario_paths(profile)))
            self.assertTrue(all(r["wire_roundtrip"] == "match_synthetic_only" for r in result["scenarios"]))
            self.assertFalse(result["protocol_complete"])


@unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
class SymbolicReassemblyTests(unittest.TestCase):
    def test_all_reassembly_scenarios_match_full_byte_symbolic_execution(self):
        model = load(ROOT / "model/tcp-reassembly.json")
        for path in sorted((ROOT / "scenarios/reassembly").glob("*.json")):
            with self.subTest(scenario=path.stem):
                runtime = run_scenario(model, read(path))
                result = crosscheck_trace(model, runtime.trace)
                self.assertEqual(result["status"], "match", result.get("reason"))

    def test_bad_shift_yields_replayable_invariant_failure_and_atomic_rollback(self):
        good = load(ROOT / "model/tcp-reassembly.json")
        scenario = read(ROOT / "scenarios/reassembly/ooo-gap-fill-no-retransmission.json")
        runtime = run_scenario(good, scenario)
        bad = copy.deepcopy(good)
        rule = next(r for r in bad["transitions"] if r["id"] == "R-RECEIVE")
        shifts = [a["set"] for a in rule["actions"] if a.get("set", {}).get("var") == "rx_slot_00"]
        shifts[-1]["value"] = {"var": "rx_slot_00"}
        m = Machine(bad)
        for step in scenario["steps"][:-1]:
            m.dispatch(step["event"], step["fields"], step["at_ms"])
        before = m.snapshot()
        with self.assertRaisesRegex(ModelError, "R-INV-NO-CONTIGUOUS-QUEUED-HEAD"):
            receive(m, 9001, [0, 1], 30)
        self.assertEqual(m.snapshot(), before)
        enc = encode_trace(bad, runtime.trace)
        z = enc.z
        props = [enc.expr(inv["assert"], frame) for inv in bad["invariants"] for frame in enc.frames]
        enc.solver.add(z.Not(z.And(*props)))
        self.assertEqual(enc.solve(), z.sat)
        witness = enc.witness(enc.solver.model())
        result = replay(bad, witness)
        self.assertEqual(result["status"], "runtime_rejected")
        self.assertIn("R-INV-NO-CONTIGUOUS-QUEUED-HEAD", result["error"])
