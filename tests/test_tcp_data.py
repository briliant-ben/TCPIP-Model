import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from protocol_lab.capture import decode, normalize
from protocol_lab.flow import ROOT, read, run_scenario, write
from protocol_lab.ir import HALF, MOD, Machine, ModelError, Uncovered, load, model_files
from protocol_lab.packets import compare, write_pcap
from protocol_lab.profiles import control_packets, profile_inputs, run_profile
from protocol_lab.symbolic import crosscheck_trace, encode_trace, model_hash, replay


def established(window=8, initial=None):
    m = Machine(load(ROOT / "model/tcp-data.json"), initial)
    m.dispatch("app.connect")
    m.dispatch("net.synack", {"seq": 9000, "ack": (m.values["iss"]+1) % MOD, "window": window}, 10)
    return m


def packets(m):
    return [p["fields"] for r in m.trace for p in r["emitted"] if p["message"] == "tcp_data"]


def ack(m, number, t=30, window=8):
    m.dispatch("net.ack", {"seq": m.values["rcv_nxt"], "ack": number, "window": window}, t)


class TCPDataTests(unittest.TestCase):
    def test_data_scenarios_and_inherited_control_regressions(self):
        model = load(ROOT / "model/tcp-data.json")
        for path in sorted((ROOT / "scenarios/data").glob("*.json")):
            with self.subTest(data=path.stem):
                run_scenario(model, read(path))
        # Window is explicit in the extended profile's ACK/SYN+ACK schemas.
        for path in sorted((ROOT / "scenarios/connection").glob("*.json")):
            with self.subTest(connection=path.stem):
                scenario = read(path)
                for step in scenario["steps"]:
                    if step.get("event") in ("net.ack", "net.synack"):
                        step["fields"]["window"] = 8
                run_scenario(model, scenario)

    def test_mss_window_partial_ack_exact_bytes_and_timer(self):
        m = established(window=5)
        m.dispatch("app.send", {"data": [0, 128, 255, 4, 5, 6]}, 20)
        m.dispatch("app.transmit", time_ms=21)
        m.dispatch("app.transmit", time_ms=22)
        m.dispatch("app.transmit", time_ms=23)
        self.assertEqual([p["payload"] for p in packets(m)], [[0, 128, 255, 4], [5]])
        self.assertEqual(m.timers, {"rtx": 1021})
        self.assertEqual(m.values["snd_buf"], [6])
        ack(m, 1003)
        self.assertEqual(m.values["rtx_buf"], [255, 4, 5])
        self.assertEqual(m.timers, {"rtx": 1030})
        ack(m, 1003, t=31)
        self.assertEqual(m.timers, {"rtx": 1030})
        m.tick(1030)
        self.assertEqual(packets(m)[-1]["payload"], [255, 4, 5])
        self.assertEqual(packets(m)[-1]["seq"], 1003)
        self.assertEqual(m.values["snd_nxt"], 1006)
        self.assertEqual(m.timers, {"rtx": 3030})

    def test_old_and_future_ack_cannot_free_buffers_or_restart_timer(self):
        m = established()
        m.dispatch("app.send", {"data": [1, 2, 3]}, 20)
        m.dispatch("app.transmit", time_ms=21)
        for number in (1000, 1005):
            ack(m, number)
            self.assertEqual(m.values["snd_una"], 1001)
            self.assertEqual(m.values["rtx_buf"], [1, 2, 3])
            self.assertEqual(m.timers, {"rtx": 1021})
        self.assertEqual(packets(m)[-1]["payload"], [])

    def test_ack_partition_near_half_space_uses_one_reference_point(self):
        m = established()
        m.dispatch("app.send", {"data": [1, 2, 3]}, 20)
        m.dispatch("app.transmit", time_ms=21)
        for delta, rule in [(HALF-1, "D-ACK-FUTURE"), (HALF+1, "D-ACK-OLD"),
                            (HALF+2, "D-ACK-OLD"), (HALF+4, "D-ACK-OLD")]:
            ack(m, (1001+delta) % MOD)
            self.assertEqual(m.trace[-1]["transition"], rule)
            self.assertEqual(m.values["rtx_buf"], [1, 2, 3])
            self.assertEqual(m.values["snd_una"], 1001)

    def test_uncovered_inputs_are_explicit_and_transactional(self):
        m = established()
        m.dispatch("app.send", {"data": [1, 2, 3]}, 20)
        m.dispatch("app.transmit", time_ms=21)
        for event, fields in [
            ("app.close", {}),
            ("net.ack", {"seq": 9001, "ack": 1002, "window": 0}),  # shrinking right edge
            ("net.ack", {"seq": 9001, "ack": (1001+HALF) % MOD, "window": 8}),
            ("net.ack", {"seq": 9001, "ack": (1004+HALF) % MOD, "window": 8}),
            ("net.ack", {"seq": 9001, "ack": 1004, "window": -1}),
            ("net.data", {"seq": 9001, "ack": 1004, "window": 8, "data": [1]}),
            ("net.data", {"seq": 9001, "ack": 1001, "window": 9, "data": [1]}),
            ("net.data", {"seq": (9001+HALF) % MOD, "ack": 1001, "window": 8, "data": [1]})]:
            with self.subTest(event=event, fields=fields):
                before = m.snapshot()
                with self.assertRaises(Uncovered):
                    m.dispatch(event, fields, 30)
                self.assertEqual(m.snapshot(), before)

    def test_capacity_failure_preserves_all_queued_octets(self):
        m = established()
        data = list(range(16))
        m.dispatch("app.send", {"data": data}, 20)
        m.dispatch("app.send", {"data": [255]}, 21)
        self.assertEqual(m.values["snd_buf"], data)
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"]["code"], "send_buffer_full")
        m.dispatch("app.send", {"data": []}, 22)
        self.assertEqual(m.values["snd_buf"], data)

    def test_receive_overlap_delivers_each_octet_once_and_tracks_window(self):
        m = established()
        def data(seq, body, t):
            m.dispatch("net.data", {"seq": seq, "ack": 1001, "window": 8, "data": body}, t)
        data(9003, [3, 4], 20)  # deliberately discarded future bytes, no reassembly
        self.assertEqual(m.values["rcv_buf"], [])
        data(9001, [0, 128, 255], 21)
        data(9002, [128, 255, 4, 5], 22)
        data(9001, [0, 128, 255], 23)
        self.assertEqual(m.values["rcv_buf"], [0, 128, 255, 4, 5])
        self.assertEqual(m.values["rcv_nxt"], 9006)
        self.assertEqual(packets(m)[-1]["window"], 11)
        m.dispatch("app.receive", {"count": 3}, 30)
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"]["data"], [0, 128, 255])
        self.assertEqual(m.values["rcv_buf"], [4, 5])
        self.assertEqual(packets(m)[-1]["window"], 14)

    def test_data_pcap_projection_checks_payload_and_window_and_keeps_default_strict(self):
        scenario = read(ROOT / "scenarios/data/segmentation-cumulative-ack.json")
        m = run_scenario(load(ROOT / "model/tcp-data.json"), scenario)
        expected = control_packets(m, scenario)
        profile = read(ROOT / "packet-profile.json")
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "model.synthetic.pcap"
            write_pcap(path, expected)
            frames = list(decode(path))
            self.assertEqual(list(frames[3]["tcp"][20:]), [0, 1, 2, 3])
            observed, meta = normalize(path, profile, expected, "synthetic", projection="tcp-data-v1")
            self.assertEqual(meta["capture_origin"], "synthetic")
            self.assertEqual(compare(expected, observed, projection="tcp-data-v1")["status"], "match")
            for key, value in [("payload", [255]), ("window", 99)]:
                changed = copy.deepcopy(observed)
                changed[3][key] = value
                result = compare(expected, changed, projection="tcp-data-v1")
                self.assertEqual(result["status"], "mismatch")
                self.assertEqual(result["differences"][0]["field"], key)
            with self.assertRaisesRegex(ModelError, "payload"):
                normalize(path, profile, expected)


class CompositionTests(unittest.TestCase):
    def test_extension_is_one_expanded_ir_and_all_sources_are_hashed(self):
        path = ROOT / "model/tcp-data.json"
        model = load(path)
        self.assertNotIn("extends", model)
        self.assertEqual({p.name for p in model_files(path)}, {"tcp-data.json", "tcp-connection.json"})
        profile = next(p for p in read(ROOT / "profiles.json")["profiles"] if p["id"] == "tcp-data")
        inputs = profile_inputs(profile, model)
        self.assertIn("model/tcp-connection.json", inputs)
        self.assertIn("docs/tcp-data.md", inputs)
        self.assertIn("docs/semantics.md", inputs)
        with tempfile.TemporaryDirectory() as tmp:
            result = run_profile(profile, tmp)
            self.assertEqual(result["status"], "reference_pass")
            self.assertEqual(read(Path(tmp) / "expanded-model.json"), model)
            self.assertFalse(result["protocol_complete"])
            self.assertEqual(result["real_stack"], "not_run")
            self.assertTrue(all(s["wire_roundtrip"] == "match_synthetic_only" for s in result["scenarios"]))
            difference = read(Path(tmp) / "sequence-wrap-data/difference.json")
            self.assertEqual(difference["evidence_scope"], "synthetic_codec_roundtrip_only")
            self.assertIn("payload", difference["compared_fields"])
            self.assertIn("window", difference["compared_fields"])

    def test_invalid_base_cycle_and_unknown_amendment_fail_closed(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            write(root / "base.json", read(ROOT / "model/tcp-connection.json"))
            overlay = {"ir_version": "0.2", "extends": "base.json"}
            for extra, pattern in [({"extends": "../outside.json"}, "escapes"),
                                   ({"extends": "overlay.json"}, "Cyclic"),
                                   ({"remove_transitions": ["typo"]}, "Unknown"),
                                   ({"amend_transitions": [{"id": "typo"}]}, "Unknown"),
                                   ({"amend_transitions": [{"id": "C-OPEN", "callback": "code"}]}, "Unsupported")]:
                write(root / "overlay.json", {**overlay, **extra})
                with self.assertRaisesRegex(ModelError, pattern):
                    load(root / "overlay.json")


@unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
class SymbolicTCPDataTests(unittest.TestCase):
    @staticmethod
    def constrained(model, runtime):
        return encode_trace(model, runtime.trace)

    def test_data_scenarios_match_independent_symbolic_states_timers_and_emits(self):
        model = load(ROOT / "model/tcp-data.json")
        for path in sorted((ROOT / "scenarios/data").glob("*.json")):
            with self.subTest(scenario=path.stem):
                runtime = run_scenario(model, read(path))
                enc = self.constrained(model, runtime)
                self.assertEqual(enc.solve(), enc.z.sat)
                self.assertEqual(replay(model, enc.witness(enc.solver.model()))["status"], "match")

    def test_saved_constrained_query_and_mismatching_reference_trace(self):
        model = load(ROOT / "model/tcp-data.json")
        runtime = run_scenario(model, read(ROOT / "scenarios/data/sequence-wrap-data.json"))
        with tempfile.TemporaryDirectory() as tmp:
            result = crosscheck_trace(model, runtime.trace, tmp)
            self.assertEqual(result["status"], "match")
            import z3
            solver = z3.Solver()
            solver.from_file(str(Path(tmp) / "path.smt2"))
            self.assertEqual(solver.check(), z3.sat)
        changed = copy.deepcopy(runtime.trace)
        changed[-1]["after"]["variables"]["rcv_buf"] = []
        self.assertEqual(crosscheck_trace(model, changed)["status"], "semantic_mismatch")

    def test_three_fault_variants_have_constrained_symbolic_counterexamples(self):
        good = load(ROOT / "model/tcp-data.json")
        for fault in ("retransmit_advances", "missing_cancel", "bad_partial_prefix"):
            model = copy.deepcopy(good)
            if fault == "retransmit_advances":
                rid = "D-RETRANSMIT"
                extra = {"set": {"var": "snd_nxt", "value": {"op": "seq_add", "args": [{"var": "snd_nxt"}, 1]}}}
                next(r for r in model["transitions"] if r["id"] == rid)["actions"].append(extra)
                name, stop = "partial-ack-retransmission", 7
            elif fault == "missing_cancel":
                rid = "D-ACK-FULL-WINDOW"
                r = next(r for r in model["transitions"] if r["id"] == rid)
                r["actions"] = [a for a in r["actions"] if "cancel" not in a]
                name, stop = "segmentation-cumulative-ack", 6
            else:
                r = next(r for r in model["transitions"] if r["id"] == "D-ACK-PARTIAL-WINDOW")
                r["actions"][0]["set"]["value"]["args"][1] = 0
                name, stop = "partial-ack-retransmission", 6
            scenario = read(ROOT / f"scenarios/data/{name}.json")
            runtime = run_scenario(good, scenario)
            runtime.trace = runtime.trace[:stop]
            with self.subTest(fault=fault):
                enc = self.constrained(model, runtime)
                props = [enc.expr(inv["assert"], frame) for frame in enc.frames for inv in model["invariants"]]
                enc.solver.add(enc.z.Not(enc.z.And(*props)))
                self.assertEqual(enc.solve(), enc.z.sat)
                result = replay(model, enc.witness(enc.solver.model()))
                self.assertEqual(result["status"], "runtime_rejected")
                self.assertIn("D-INV-", result["error"])

    def test_unknown_formal_result_does_not_become_reference_or_protocol_pass(self):
        profile = next(p for p in read(ROOT / "profiles.json")["profiles"] if p["id"] == "tcp-data")
        profile = {**profile, "symbolic_replay": False}
        with tempfile.TemporaryDirectory() as tmp:
            def inconclusive(*args, **kwargs):
                out = kwargs["out"]
                out.mkdir()
                for name in ("result.json", "model.smt2", "overlap.smt2"):
                    (out / name).write_text("{}")
                return {"status": "unknown", "depth": 6, "backend": "z3-bmc",
                        "model_semantic_sha256": model_hash(args[0]), "solver_version": "unit-fixture"}
            with patch("protocol_lab.profiles.check", side_effect=inconclusive):
                result = run_profile(profile, tmp, formal=True)
            self.assertEqual(result["status"], "formal_pending")
            self.assertEqual(result["formal"]["status"], "unknown")
            self.assertFalse(result["protocol_complete"])
