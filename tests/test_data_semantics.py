"""IR data semantics: boundary vectors, symbolic inputs and fault detection."""
import copy
import importlib.util
import unittest
from unittest.mock import patch

from protocol_lab.flow import ROOT
from protocol_lab.ir import HALF, MOD, Machine, ModelError, evaluate, infer, load, validate
from protocol_lab.symbolic import Encoding, check, replay


def op(name, *args):
    return {"op": name, "args": list(args)}


def buffer_model():
    return {
        "ir_version": "0.2", "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "ir-data-test", "scope": {"terminal_states": []},
        "states": ["READY"], "initial_state": "READY",
        "requirements": {"SCOPE": {"source": "docs/semantics.md", "interpretation": "Bounded byte buffer test"}},
        "variables": {"buffer": {"type": "bytes", "initial": []}, "iss": {"type": "seq32", "initial": MOD - 1},
                      "next": {"type": "seq32", "initial": MOD - 1}},
        "events": {"append": {"origin": "application", "fields": {"data": "bytes"}}},
        "messages": {"chunk": {"fields": {"data": "bytes", "end": "seq32"}}}, "timers": {},
        "transitions": [{"id": "APPEND", "from": "READY", "to": "READY", "event": "append",
            "requirements": ["SCOPE"],
            "guard": op("le", op("add", op("bytes_len", {"var": "buffer"}), op("bytes_len", {"event": "data"})), 4),
            "actions": [
                {"set": {"var": "buffer", "value": op("bytes_concat", {"var": "buffer"}, {"event": "data"})}},
                {"set": {"var": "next", "value": op("seq_add", {"var": "next"}, op("bytes_len", {"event": "data"}))}},
                {"emit": {"message": "chunk", "fields": {"data": {"var": "buffer"}, "end": {"var": "next"}}}}]}],
        "invariants": [{"id": "BUFFER-SPACE", "requirements": ["SCOPE"],
            "assert": op("eq", {"var": "next"}, op("seq_add", {"var": "iss"}, op("bytes_len", {"var": "buffer"})))}]
    }


class DataSemanticsTests(unittest.TestCase):
    def setUp(self):
        self.m = Machine(buffer_model())

    def test_slice_and_bytes_are_octets_with_total_truncating_semantics(self):
        for offset, count, want in [(0, 2, [0, 128]), (1, 99, [128, 255]), (3, 2, []),
                                     (99, 1, []), (-1, 2, [0, 128]), (1, -1, []), (0, 0, [])]:
            expr = op("bytes_slice", {"bytes": [0, 128, 255]}, offset, count)
            self.assertEqual(infer(expr, self.m.model), "bytes")
            self.assertEqual(evaluate(expr, self.m), want)
        self.assertEqual(evaluate(op("bytes_concat", {"bytes": []}, {"bytes": [255]}), self.m), [255])

    def test_half_space_order_and_forward_distance(self):
        for a, b, less, le, comparable, distance in [
                (0, 0, False, True, True, 0), (MOD-1, 0, True, True, True, 1),
                (0, MOD-1, False, False, True, MOD-1), (0, HALF-1, True, True, True, HALF-1),
                (0, HALF, False, False, False, HALF), (HALF, 0, False, False, False, HALF),
                (0, HALF+1, False, False, True, HALF+1)]:
            for name, want in [("seq_lt", less), ("seq_le", le), ("seq_comparable", comparable), ("seq_distance", distance)]:
                self.assertEqual(evaluate(op(name, {"seq": a}, {"seq": b}), self.m), want, (name, a, b))
        self.assertEqual(evaluate(op("seq_add", {"seq": 0}, -1), self.m), MOD-1)

    def test_typed_conditionals_select_values_without_type_coercion(self):
        for yes, no, kind, expected in [(3, 8, "int", 3), (True, False, "bool", True),
                                       ("left", "right", "string", "left"),
                                       ({"seq": MOD-1}, {"seq": 0}, "seq32", MOD-1),
                                       ({"bytes": [0, 128, 255]}, {"bytes": []}, "bytes", [0, 128, 255])]:
            expr = op("ite", True, yes, no)
            self.assertEqual(infer(expr, self.m.model), kind)
            self.assertEqual(evaluate(expr, self.m), expected)
            self.assertEqual(evaluate(op("ite", False, yes, no), self.m), evaluate(no, self.m))
        for expr in [op("ite", 1, 2, 3), op("ite", True, {"seq": 0}, 0), op("ite", True, 1),
                     op("ite", False, {"bytes": []}, "")]:
            with self.assertRaises(ModelError):
                infer(expr, self.m.model)

    def test_invalid_types_unknown_operators_and_old_version_are_rejected(self):
        for expr in [{"bytes": [-1]}, {"bytes": [256]}, {"bytes": [True]}, {"bytes": "ff"},
                     op("bytes_slice", {"bytes": []}, {"seq": 0}, 1),
                     op("seq_lt", 0, 1), op("bytes_map_callback", {"bytes": []})]:
            with self.assertRaises(ModelError):
                infer(expr, self.m.model)
        old = load(ROOT / "model/tcp.json")
        with self.assertRaises(ModelError):
            infer(op("seq_lt", {"seq": 0}, {"seq": 1}), old)
        bad = buffer_model()
        bad["ir_version"] = "0.1"
        with self.assertRaises(ModelError):
            validate(bad)

    def test_buffers_and_trace_snapshots_have_value_semantics(self):
        initial = {"buffer": [], "next": MOD-1}
        m = Machine(buffer_model(), initial)
        initial["buffer"].append(77)
        data = [0, 255]
        m.dispatch("append", {"data": data})
        data.append(99)
        self.assertEqual(m.values["buffer"], [0, 255])
        self.assertEqual(m.trace[0]["event"]["fields"]["data"], [0, 255])
        snap = m.snapshot()
        snap["variables"]["buffer"].append(66)
        m.dispatch("append", {"data": [128]})
        self.assertEqual(m.trace[0]["emitted"][0]["fields"]["data"], [0, 255])
        self.assertEqual(m.trace[0]["after"]["variables"]["buffer"], [0, 255])

    def test_invariant_failure_rolls_back_buffer_and_emits(self):
        model = buffer_model()
        model["transitions"][0]["actions"][1]["set"]["value"] = op("seq_add", {"var": "next"}, 1)
        m = Machine(model)
        with self.assertRaisesRegex(ModelError, "BUFFER-SPACE"):
            m.dispatch("append", {"data": [1, 2]})
        self.assertEqual(m.snapshot(), self.m.snapshot())
        self.assertEqual(m.trace, [])


@unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend not installed")
class SymbolicDataTests(unittest.TestCase):
    def test_symbolic_conditional_matches_reference_in_full_and_length_modes(self):
        model = buffer_model()
        for mode in ("sequence", "length"):
            enc = Encoding(model, 1, (), byte_encoding=mode)
            for condition in (False, True):
                expr = op("ite", condition, {"bytes": [0, 128, 255]}, {"bytes": [7]})
                s = enc.z.Solver()
                self.assertEqual(s.check(), enc.z.sat)
                value = enc.concrete(s.model(), enc.expr(expr, enc.frames[0]))
                want = evaluate(expr, Machine(model))
                self.assertEqual(value, len(want) if mode == "length" else want)

    def test_symbolic_byte_capacity_and_wrap_witness_replay(self):
        model = buffer_model()
        capacity_model = copy.deepcopy(model)
        capacity_model["invariants"] = [{"id": "CAPACITY", "requirements": ["SCOPE"],
            "assert": op("le", op("bytes_len", {"var": "buffer"}), 4)}]
        result = check(capacity_model, depth=3, symbolic_initials=())
        self.assertEqual(result["status"], "bounded_pass", result)
        enc = Encoding(model, 1, ())
        z = enc.z
        enc.solver.add(z.Int("choice_0") == 0, z.Length(enc.events[0]["append"]["data"]) == 2)
        self.assertEqual(enc.solver.check(), z.sat)
        witness = enc.witness(enc.solver.model())
        self.assertEqual(witness["steps"][0]["after"]["variables"]["next"], 1)
        self.assertEqual(replay(model, witness)["status"], "match")

    def test_wrong_sequence_advance_produces_replayable_counterexample(self):
        model = buffer_model()
        model["transitions"][0]["actions"][1]["set"]["value"] = op("seq_add", {"var": "next"}, 1)
        result = check(model, depth=2, symbolic_initials=())
        self.assertEqual(result["status"], "counterexample")
        self.assertEqual(result["replay"]["status"], "runtime_rejected")
        self.assertIn("BUFFER-SPACE", result["replay"]["error"])

    def test_all_symbolic_sequence_pairs_follow_half_space_contract(self):
        enc = Encoding(buffer_model(), 1, ())
        z = enc.z
        a, b = z.BitVecs("order_a order_b", 32)
        frame = copy.deepcopy(enc.frames[0])
        frame["values"].update(iss=a, next=b)
        args = ({"var": "iss"}, {"var": "next"})
        dist = enc.expr(op("seq_distance", *args), frame)
        less = enc.expr(op("seq_lt", *args), frame)
        le = enc.expr(op("seq_le", *args), frame)
        comparable = enc.expr(op("seq_comparable", *args), frame)
        s = z.Solver()
        s.add(z.Or(less != z.And(dist > 0, dist < HALF), le != (dist < HALF), comparable != (dist != HALF)))
        self.assertEqual(s.check(), z.unsat)

    def test_slices_crosscheck_reference_for_symbolic_and_concrete_data(self):
        enc = Encoding(buffer_model(), 1, ())
        z = enc.z
        m = Machine(buffer_model())
        for offset, count in [(0, 2), (1, 99), (3, 1), (99, 2), (-3, 2), (1, -1)]:
            expr = op("bytes_slice", {"bytes": [0, 128, 255]}, offset, count)
            s = z.Solver()
            self.assertEqual(s.check(), z.sat)
            self.assertEqual(enc.concrete(s.model(), enc.expr(expr, enc.frames[0])), evaluate(expr, m))
        data = z.Const("slice_data", enc.byte_sort)
        # Negative offset/count handling is a defined part of IR, not Z3's default.
        f = {**enc.frames[0], "values": {**enc.frames[0]["values"], "buffer": data}}
        expr = op("bytes_slice", {"var": "buffer"}, -1, -1)
        s = z.Solver()
        s.add(enc.expr(expr, f) != z.Empty(enc.byte_sort))
        self.assertEqual(s.check(), z.unsat)

    def test_backend_explicitly_rejects_unknown_expression(self):
        enc = Encoding(buffer_model(), 1, ())
        with self.assertRaisesRegex(ModelError, "Unsupported symbolic operator"):
            enc.expr(op("bytes_map_callback", {"bytes": []}), enc.frames[0])

    def test_solver_resource_exception_is_reported_as_unknown(self):
        enc = Encoding(buffer_model(), 1, ())
        with patch.object(enc.solver, "check", side_effect=enc.z.Z3Exception("reached max unfolding")):
            self.assertEqual(enc.solve(), enc.z.unknown)
        self.assertIn("max unfolding", enc.reason_unknown())
        with patch.object(Encoding, "solve", return_value=enc.z.unknown), patch.object(Encoding, "reason_unknown", return_value="timeout"):
            self.assertEqual(check(buffer_model(), depth=1)["status"], "unknown")
