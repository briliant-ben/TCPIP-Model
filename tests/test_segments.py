import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.inductive import prove, verify
from protocol_lab.ir import MOD, Machine, ModelError, load, model_files
from protocol_lab.profiles import profile_inputs, run_profile, scenario_paths
from protocol_lab.symbolic import crosscheck_trace, encode_trace, replay


def established():
    m = Machine(load(ROOT / "model/tcp-segments.json"))
    m.dispatch("app.connect")
    m.dispatch("net.synack", {"seq": 9000, "ack": 1001, "window": 8}, 10)
    return m


def send(m, data):
    m.dispatch("app.send", {"data": data}, 20)
    m.dispatch("app.transmit", time_ms=21)
    if len(data) > 4:
        m.dispatch("app.transmit", time_ms=22)


def data(m, seq, ack, window, payload, at=30):
    m.dispatch("net.data", {"seq": seq % MOD, "ack": ack % MOD, "window": window, "data": payload}, at)


def ack(m, seq, number, window, at=30):
    m.dispatch("net.ack", {"seq": seq % MOD, "ack": number % MOD, "window": window}, at)


class SegmentTests(unittest.TestCase):
    def test_new_and_inherited_data_reassembly_and_connection_scenarios(self):
        model = load(ROOT / "model/tcp-segments.json")
        for directory in ("scenarios/data", "scenarios/reassembly", "scenarios/segments", "scenarios/connection"):
            for path in sorted((ROOT / directory).glob("*.json")):
                with self.subTest(scenario=path.stem):
                    scenario = read(path)
                    if directory == "scenarios/connection":
                        for step in scenario["steps"]:
                            if step.get("event") in ("net.ack", "net.synack"):
                                step["fields"]["window"] = 8
                    run_scenario(model, scenario)

    def test_partial_ack_receive_and_shrink_are_one_ordered_event(self):
        m = established()
        send(m, [0, 1, 128, 255, 4, 5])
        data(m, 9001, 1003, 1, [7, 8])
        self.assertEqual(m.values["snd_una"], 1003)
        self.assertEqual(m.values["snd_nxt"], 1007)
        self.assertEqual(m.values["rtx_buf"], [128, 255, 4, 5])
        self.assertEqual(m.values["snd_wnd"], 1)
        self.assertEqual(m.values["rcv_buf"], [7, 8])
        self.assertEqual(m.timers, {"rtx": 1030})
        out = m.trace[-1]["emitted"]
        self.assertEqual(len(out), 1)
        self.assertEqual(out[0]["fields"], {"flags": "A", "seq": 1007, "ack": 9003, "window": 14, "payload": []})

    def test_unacceptable_sequence_precedes_ack_window_and_comparability(self):
        m = established()
        send(m, [1, 2, 3, 4])
        for number in (1005, 1001+(1 << 31)):
            data(m, 9017, number, 0, [7])
            self.assertEqual(m.values["snd_una"], 1001)
            self.assertEqual(m.values["rtx_buf"], [1, 2, 3, 4])
            self.assertEqual(m.values["snd_wnd"], 8)
            self.assertEqual(m.values["rcv_buf"], [])
            self.assertEqual(m.timers, {"rtx": 1021})
        ack(m, 9017, 1005, 0, 40)
        self.assertEqual(m.values["rtx_buf"], [1, 2, 3, 4])

    def test_future_ack_cannot_fill_gap_but_old_ack_carries_text(self):
        m = established()
        send(m, [1, 2, 3, 4])
        data(m, 9003, 1001, 8, [128, 255])
        data(m, 9001, 1006, 12, [0, 1], 40)
        self.assertEqual(m.values["rcv_nxt"], 9001)
        self.assertEqual(m.values["rcv_buf"], [])
        self.assertEqual(m.values["rx_slot_02"], [128])
        self.assertEqual(m.values["snd_wnd"], 8)
        self.assertEqual(m.timers, {"rtx": 1021})
        data(m, 9001, 1000, 1, [0, 1], 50)
        self.assertEqual(m.values["rcv_buf"], [0, 1, 128, 255])
        self.assertEqual(m.values["snd_una"], 1001)
        self.assertEqual(m.values["snd_wnd"], 8)

    def test_stale_window_does_not_prevent_new_ack_or_payload(self):
        m = established()
        send(m, [1, 2, 3, 4])
        ack(m, 9003, 1001, 12)
        data(m, 9001, 1003, 1, [0, 128], 40)
        self.assertEqual(m.values["snd_una"], 1003)
        self.assertEqual(m.values["rtx_buf"], [3, 4])
        self.assertEqual(m.values["snd_wnd"], 12)
        self.assertEqual(m.values["snd_wl1"], 9003)
        self.assertEqual(m.values["snd_wl2"], 1001)
        self.assertEqual(m.values["rcv_buf"], [0, 128])
        self.assertEqual(m.timers, {"rtx": 1040})

    def test_window_shrink_blocks_new_data_and_retransmits_only_permitted_prefix(self):
        m = established()
        send(m, [0, 128, 255, 3, 4, 5])
        m.dispatch("app.send", {"data": [6]}, 25)
        ack(m, 9001, 1001, 2)
        self.assertEqual(m.timers, {"rtx": 1021})
        m.dispatch("app.transmit", time_ms=40)
        self.assertEqual(m.values["snd_nxt"], 1007)
        self.assertEqual(m.values["snd_buf"], [6])
        self.assertEqual(m.trace[-1]["emitted"], [])
        m.tick(1021)
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"]["payload"], [0, 128])
        self.assertEqual(m.values["rtx_buf"], [0, 128, 255, 3, 4, 5])
        ack(m, 9001, 1001, 0, 1100)
        self.assertEqual(m.timers, {"rtx": 3021})
        m.tick(3021)
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"]["payload"], [0])
        self.assertEqual(m.values["snd_nxt"], 1007)
        self.assertEqual(m.timers, {"rtx": 7021})

    def test_ack_only_inside_receive_window_does_not_create_ack_loop(self):
        m = established()
        send(m, [1, 2, 3, 4])
        ack(m, 9016, 1003, 8)
        self.assertEqual(m.trace[-1]["emitted"], [])
        self.assertEqual(m.values["snd_una"], 1003)
        ack(m, 9016, 1005, 8, 40)
        self.assertEqual(m.trace[-1]["emitted"], [])
        self.assertEqual(m.timers, {})

    def test_order_freshness_and_restart_mutants_fail_independent_expectations(self):
        good = load(ROOT / "model/tcp-segments.json")
        for fault, name in [("ack_before_sequence", "seg-invalid-sequence-ignores-valid-ack"),
                            ("stale_window", "seg-ahead-ack-sequence-and-stale-window"),
                            ("no_partial_restart", "seg-partial-ack-shrink-and-payload"),
                            ("future_ack_text", "seg-future-ack-does-not-fill-gap")]:
            model = copy.deepcopy(good)
            rule = next(r for r in model["transitions"] if r["id"] == "R-RECEIVE")
            scenario = read(ROOT / f"scenarios/segments/{name}.json")
            if fault == "ack_before_sequence":
                action = next(a["set"] for a in rule["actions"] if a.get("set", {}).get("var") == "ack_advance")
                action["value"] = {"var": "ack_is_new"}
            elif fault == "stale_window":
                action = next(a["set"] for a in rule["actions"] if a.get("set", {}).get("var") == "ack_window_update")
                action["value"] = action["value"]["args"][0]
            elif fault == "no_partial_restart":
                next(a["arm_if"] for a in rule["actions"] if "arm_if" in a)["when"] = False
            else:
                action = next(a["set"] for a in rule["actions"] if a.get("set", {}).get("var") == "rx_acceptable")
                action["value"] = {"var": "seg_acceptable"}
                scenario["steps"] = scenario["steps"][:-1]
                scenario["expect"] = {"state": "ESTABLISHED", "variables": {"snd_una": 1001,
                    "rtx_buf": [1, 2, 3, 4], "snd_wnd": 8, "rcv_nxt": 9001, "rcv_buf": [],
                    "rx_slot_02": [128], "rx_slot_03": [255]}, "timers": {"rtx": 1021}}
            run_scenario(good, scenario)
            with self.subTest(fault=fault), self.assertRaisesRegex(ModelError, "Scenario .*mismatch"):
                run_scenario(model, scenario)

    def test_profile_reuses_anchored_receiver_and_binds_all_four_model_sources(self):
        path = ROOT / "model/tcp-segments.json"
        self.assertEqual({p.name for p in model_files(path)}, {"tcp-segments.json", "tcp-reassembly.json", "tcp-data.json", "tcp-connection.json"})
        profile = next(p for p in read(ROOT / "profiles.json")["profiles"] if p["id"] == "tcp-segments")
        model = load(path)
        hashes = profile_inputs(profile, model)
        self.assertIn("docs/tcp-segments.md", hashes)
        self.assertIn("scenarios/segments/seg-sequence-wrap-duplex.json", hashes)
        with tempfile.TemporaryDirectory() as tmp:
            result = run_profile(profile, tmp)
            self.assertEqual(len(result["scenarios"]), len(scenario_paths(profile)))
            self.assertEqual(result["status"], "reference_pass")
            self.assertTrue(all(s["wire_roundtrip"] == "match_synthetic_only" for s in result["scenarios"]))
            self.assertFalse(result["protocol_complete"])


@unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
class SymbolicSegmentTests(unittest.TestCase):
    def test_new_scenarios_match_full_byte_independent_semantics(self):
        model = load(ROOT / "model/tcp-segments.json")
        for path in sorted((ROOT / "scenarios/segments").glob("*.json")):
            with self.subTest(scenario=path.stem):
                runtime = run_scenario(model, read(path))
                result = crosscheck_trace(model, runtime.trace)
                self.assertEqual(result["status"], "match", result.get("reason"))

    def test_missing_conditional_cancel_has_full_byte_counterexample(self):
        good = load(ROOT / "model/tcp-segments.json")
        scenario = read(ROOT / "scenarios/segments/seg-full-ack-and-payload.json")
        runtime = run_scenario(good, scenario)
        bad = copy.deepcopy(good)
        rule = next(r for r in bad["transitions"] if r["id"] == "R-RECEIVE")
        next(a["cancel_if"] for a in rule["actions"] if "cancel_if" in a)["when"] = False
        enc = encode_trace(bad, runtime.trace)
        z = enc.z
        enc.solver.add(z.Not(z.And(*[enc.expr(i["assert"], f) for f in enc.frames for i in bad["invariants"]])))
        self.assertEqual(enc.solve(), z.sat)
        result = replay(bad, enc.witness(enc.solver.model()))
        self.assertEqual(result["status"], "runtime_rejected")
        self.assertIn("D-INV-TIMER", result["error"])

    def test_new_induction_certificate_is_separate_from_bmc_and_byte_content(self):
        model = load(ROOT / "model/tcp-segments.json")
        with tempfile.TemporaryDirectory() as tmp:
            result = prove(model, out=tmp)
            self.assertEqual(result["status"], "inductive_invariants_pass")
            self.assertEqual(len(result["preservation"]), len(model["transitions"]))
            self.assertEqual(verify(model, tmp)["status"], "valid_inductive_artifacts")
            self.assertFalse(result["unbounded_protocol_proof"])
