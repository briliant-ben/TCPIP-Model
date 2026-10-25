import copy
import importlib.util
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario, write
from protocol_lab.inductive import prove, verify
from protocol_lab.ir import HALF, MOD, ModelError, load
from protocol_lab.symbolic import Encoding, encode_trace, replay


@unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
class InductiveTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.model = load(ROOT / "model/tcp-data.json")
        cls.temp = tempfile.TemporaryDirectory()
        cls.addClassCleanup(cls.temp.cleanup)
        cls.out = Path(cls.temp.name)
        cls.result = prove(cls.model, out=cls.out)

    def test_all_initial_preservation_and_overlap_obligations_pass(self):
        r = self.result
        self.assertEqual(r["status"], "inductive_invariants_pass", r)
        self.assertEqual(len(r["preservation"]), len(self.model["transitions"]))
        self.assertTrue(all(x["query"] == "unsat" for x in r["preservation"] + r["overlap"]))
        self.assertEqual(r["replay"]["status"], "match")
        self.assertEqual(r["preservation_query_strategy"], "exact_selected_rule_substitution_fresh_solver")
        self.assertFalse(r["unbounded_protocol_proof"])
        self.assertEqual(verify(self.model, self.out)["status"], "valid_inductive_artifacts")

    def test_exported_obligations_run_in_a_fresh_z3_process(self):
        binary = Path(sys.executable).parent / "z3"
        if not binary.exists():
            self.skipTest("Z3 command line binary not installed")
        for name, count in [("preservation.smt2", len(self.result["preservation"])),
                            ("overlap.smt2", len(self.result["overlap"])),
                            ("length-lemmas.smt2", 1), ("initial.smt2", 1)]:
            with self.subTest(query=name):
                run = subprocess.run([str(binary), str(self.out / name)], capture_output=True, text=True, timeout=60)
                self.assertEqual(run.returncode, 0, run.stdout + run.stderr)
                self.assertEqual(run.stdout.split(), ["unsat"] * count)

    def test_incomplete_inductive_basis_is_not_a_reachable_protocol_counterexample(self):
        model = copy.deepcopy(self.model)
        model["invariants"] = [i for i in model["invariants"] if i["id"] != "C-INV-SYN-SENT-ISS"]
        r = prove(model)
        row = next(r for r in r["preservation"] if r["transition"] == "C-SIMULTANEOUS-SYN")
        self.assertEqual(r["status"], "inductive_obligations_failed")
        self.assertEqual(row["query"], "sat")
        self.assertEqual(row["classification"], "inductive_obligation_failure_not_reachability_proof")
        self.assertIn("C-INV-OUTSTANDING-CONTROL", row["failed_invariants"])
        self.assertEqual(row["projection"]["steps"][0]["transition"], "C-SIMULTANEOUS-SYN")

    def test_three_reachable_data_mutations_fail_preservation(self):
        model = copy.deepcopy(self.model)
        rtx = next(r for r in model["transitions"] if r["id"] == "D-RETRANSMIT")
        rtx["actions"].append({"set": {"var": "snd_nxt", "value": {"op": "seq_add", "args": [{"var": "snd_nxt"}, 1]}}})
        full = next(r for r in model["transitions"] if r["id"] == "D-ACK-FULL-WINDOW")
        full["actions"] = [a for a in full["actions"] if "cancel" not in a]
        part = next(r for r in model["transitions"] if r["id"] == "D-ACK-PARTIAL-WINDOW")
        part["actions"][0]["set"]["value"]["args"][1] = 0
        result = prove(model)
        self.assertEqual(result["status"], "inductive_obligations_failed")
        failed = {r["transition"] for r in result["preservation"] if r["query"] == "sat"}
        self.assertTrue({"D-RETRANSMIT", "D-ACK-FULL-WINDOW", "D-ACK-PARTIAL-WINDOW"} <= failed)

    def test_bad_initial_value_and_overlapping_guards_cannot_pass(self):
        model = copy.deepcopy(self.model)
        model["variables"]["rto_ms"]["initial"] = 0
        duplicate = copy.deepcopy(next(r for r in model["transitions"] if r["id"] == "D-ACK-DUP-WINDOW"))
        duplicate["id"] = "D-CONFLICT-FAULT"
        model["transitions"].append(duplicate)
        result = prove(model)
        self.assertEqual(result["status"], "inductive_obligations_failed")
        self.assertEqual(result["initial_query"], "sat")
        group = next(r for r in result["overlap"] if r["state"] == "ESTABLISHED" and r["event"] == "net.ack")
        self.assertEqual(group["query"], "sat")
        self.assertEqual(group["classification"], "overlap_in_invariant_state_not_reachability_proof")

    def test_byte_content_tests_are_explicitly_rejected(self):
        for target in ("invariant", "guard", "action"):
            model = copy.deepcopy(self.model)
            expr = {"op": "eq", "args": [{"var": "snd_buf"}, {"bytes": []}]}
            if target == "invariant":
                model["invariants"].append({"id": "CONTENT", "assert": expr, "requirements": ["DATA-SCOPE"]})
            elif target == "guard":
                model["transitions"][0]["guard"] = expr
            else:
                model["transitions"][0]["actions"].append({"set": {"var": "active_open", "value": expr}})
            with self.subTest(target=target), self.assertRaisesRegex(ModelError, "byte-content equality"):
                prove(model)

    def test_query_tampering_missing_case_and_stale_models_are_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            out = Path(tmp)
            for name in (*self.result["query_hashes"], "result.json"):
                (out / name).write_bytes((self.out / name).read_bytes())
            (out / "preservation.smt2").write_text("; tampered")
            with self.assertRaisesRegex(ModelError, "query changed"):
                verify(self.model, out)
            (out / "preservation.smt2").write_bytes((self.out / "preservation.smt2").read_bytes())
            report = copy.deepcopy(self.result)
            report["overlap"] = report["overlap"][:-1]
            write(out / "result.json", report)
            with self.assertRaisesRegex(ModelError, "overlap obligation"):
                verify(self.model, out)
        model = copy.deepcopy(self.model)
        model["variables"]["snd_wnd"]["initial"] = 9
        with self.assertRaisesRegex(ModelError, "stale"):
            verify(model, self.out)

    def test_modular_integer_encoding_matches_full_byte_reference_traces(self):
        for name in ("sequence-wrap-data", "partial-ack-retransmission", "receive-overlap"):
            with self.subTest(scenario=name):
                m = run_scenario(self.model, read(ROOT / f"scenarios/data/{name}.json"))
                enc = encode_trace(self.model, m.trace, sequence_encoding="modular-int")
                self.assertEqual(enc.solve(), enc.z.sat)
                self.assertEqual(replay(self.model, enc.witness(enc.solver.model()))["status"], "match")

    def test_length_projection_matches_nonzero_bytes_without_inventing_content(self):
        m = run_scenario(self.model, read(ROOT / "scenarios/data/partial-ack-retransmission.json"))
        enc = encode_trace(self.model, m.trace, byte_encoding="length", sequence_encoding="modular-int")
        self.assertEqual(enc.solve(), enc.z.sat)
        projected = enc.witness(enc.solver.model())
        self.assertEqual(projected["steps"][2]["fields"]["data"], {"byte_length": 6})
        for actual, symbolic in zip(m.trace, projected["steps"]):
            for name, value in actual["after"]["variables"].items():
                want = {"byte_length": len(value)} if self.model["variables"][name]["type"] == "bytes" else value
                self.assertEqual(symbolic["after"]["variables"][name], want)
        # A projected trace is intentionally not a concrete runtime witness.
        self.assertEqual(replay(self.model, projected)["status"], "runtime_rejected")

    def test_modular_integer_boundaries_do_not_shrink_or_sign_extend_seq32(self):
        enc = Encoding(self.model, 1, (), sequence_encoding="modular-int")
        for a, b in [(MOD-1, 0), (0, MOD-1), (0, HALF), (HALF, 0), (1, HALF), (1, HALF+2)]:
            for op, want in [("seq_distance", (b-a) % MOD), ("seq_lt", 0 < (b-a) % MOD < HALF),
                             ("seq_le", (b-a) % MOD < HALF), ("seq_comparable", (b-a) % MOD != HALF)]:
                expr = {"op": op, "args": [{"seq": a}, {"seq": b}]}
                s = enc.z.Solver()
                self.assertEqual(s.check(), enc.z.sat)
                self.assertEqual(enc.concrete(s.model(), enc.expr(expr, enc.frames[0])), want)
        for delta in (-MOD-1, -1, 0, 1, MOD+1, 1 << 64):
            expr = {"op": "seq_add", "args": [{"seq": MOD-1}, delta]}
            s = enc.z.Solver()
            s.check()
            self.assertEqual(enc.concrete(s.model(), enc.expr(expr, enc.frames[0])), (MOD-1+delta) % MOD)
