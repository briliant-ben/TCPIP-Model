import copy
import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import z3

from protocol_lab.ir import Machine, ModelError, Conflict
from protocol_lab.symbolic import Encoding, crosscheck_trace, encode_trace


def make_alias_hazard_model():
    """Model with guard using mutable expression and two sequential sets."""
    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "test-alias",
        "scope": {"terminal_states": []},
        "states": ["S"],
        "initial_state": "S",
        "variables": {
            "x": {"type": "int", "initial": 0}
        },
        "events": {
            "tick": {"origin": "application", "fields": {"n": "int"}}
        },
        "messages": {
            "out": {"fields": {"val": "int"}}
        },
        "timers": {},
        "requirements": {
            "REQ": {
                "source": "tests/test_guard_memo.py",
                "kind": "test",
                "interpretation": "test model"
            }
        },
        "transitions": [
            {
                "id": "TICK",
                "from": "S",
                "to": "S",
                "event": "tick",
                "guard": {"op": "and", "args": [True,
                    {"op": "ge", "args": [{"op": "add", "args": [{"var": "x"}, 1]}, 1]}
                ]},
                "actions": [
                    {"set": {"var": "x", "value": {"op": "add", "args": [{"var": "x"}, 1]}}},
                    {"set": {"var": "x", "value": {"op": "add", "args": [{"var": "x"}, 1]}}},
                    {"emit": {"message": "out", "fields": {"val": {"var": "x"}}}}
                ],
                "requirements": ["REQ"]
            }
        ],
        "invariants": []
    }


def make_type_variation_model():
    """Model with two events sharing field name 'value' but different types."""
    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "test-types",
        "scope": {"terminal_states": []},
        "states": ["S"],
        "initial_state": "S",
        "variables": {
            "int_val": {"type": "int", "initial": 0},
            "bytes_val": {"type": "bytes", "initial": []}
        },
        "events": {
            "set_int": {"origin": "application", "fields": {"value": "int"}},
            "set_bytes": {"origin": "application", "fields": {"value": "bytes"}}
        },
        "messages": {},
        "timers": {},
        "requirements": {
            "REQ": {
                "source": "tests/test_guard_memo.py",
                "kind": "test",
                "interpretation": "test model"
            }
        },
        "transitions": [
            {
                "id": "SET_INT",
                "from": "S",
                "to": "S",
                "event": "set_int",
                "guard": {"op": "eq", "args": [{"event": "value"}, 42]},
                "actions": [
                    {"set": {"var": "int_val", "value": {"event": "value"}}}
                ],
                "requirements": ["REQ"]
            },
            {
                "id": "SET_BYTES",
                "from": "S",
                "to": "S",
                "event": "set_bytes",
                "guard": {"op": "eq", "args": [
                    {"op": "bytes_len", "args": [{"event": "value"}]}, 3
                ]},
                "actions": [
                    {"set": {"var": "bytes_val", "value": {"event": "value"}}}
                ],
                "requirements": ["REQ"]
            }
        ],
        "invariants": []
    }


def make_overlap_model():
    """Model with two overlapping rules for the same event."""
    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "test-overlap",
        "scope": {"terminal_states": []},
        "states": ["S"],
        "initial_state": "S",
        "variables": {
            "x": {"type": "int", "initial": 0}
        },
        "events": {
            "go": {"origin": "application", "fields": {"n": "int"}}
        },
        "messages": {},
        "timers": {},
        "requirements": {
            "REQ": {
                "source": "tests/test_guard_memo.py",
                "kind": "test",
                "interpretation": "test model"
            }
        },
        "transitions": [
            {
                "id": "T1",
                "from": "S",
                "to": "S",
                "event": "go",
                "guard": {"op": "ge", "args": [{"event": "n"}, 1]},
                "actions": [
                    {"set": {"var": "x", "value": 1}}
                ],
                "requirements": ["REQ"]
            },
            {
                "id": "T2",
                "from": "S",
                "to": "S",
                "event": "go",
                "guard": {"op": "le", "args": [{"event": "n"}, 9]},
                "actions": [
                    {"set": {"var": "x", "value": 2}}
                ],
                "requirements": ["REQ"]
            }
        ],
        "invariants": []
    }


class TestGuardMemo(unittest.TestCase):

    def test_alias_hazard_two_sequential_sets(self):
        model = make_alias_hazard_model()
        runtime = Machine(copy.deepcopy(model))
        runtime.dispatch("tick", {"n": 0}, 0)
        self.assertEqual(runtime.values["x"], 2)
        self.assertEqual(runtime.trace[-1]["emitted"], [
            {"message": "out", "fields": {"val": 2}}
        ])
        trace = runtime.trace
        result = crosscheck_trace(model, trace)
        self.assertEqual(result["status"], "match")

    def test_distinct_event_fields_with_same_name(self):
        model = make_type_variation_model()
        runtime = Machine(copy.deepcopy(model))
        runtime.dispatch("set_int", {"value": 42}, 0)
        runtime.dispatch("set_bytes", {"value": [1, 2, 3]}, 1)
        trace = runtime.trace
        result = crosscheck_trace(model, trace)
        self.assertEqual(result["status"], "match")

    def test_overlapping_rules_conflict_detection(self):
        model = make_overlap_model()
        enc = Encoding(model, 1, {})
        self.assertTrue(enc.conflicts)
        enc.solver.add(z3.Or(*enc.conflicts))
        enc.solver.add(enc.events[0]["go"]["n"] == 5)
        self.assertEqual(enc.solver.check(), z3.sat)
        with self.assertRaises(Conflict):
            Machine(model).dispatch("go", {"n": 5}, 0)

    def test_disjoint_guards_have_no_symbolic_conflict(self):
        model = make_overlap_model()
        model["transitions"][1]["guard"] = {
            "op": "le", "args": [{"event": "n"}, 0]
        }
        enc = Encoding(model, 1, ())
        enc.solver.add(z3.Or(*enc.conflicts))
        self.assertEqual(enc.solver.check(), z3.unsat)

    def test_interrupted_solve_preserves_smt(self):
        model = make_alias_hazard_model()
        runtime = Machine(copy.deepcopy(model))
        runtime.dispatch("tick", {"n": 0}, 0)
        trace = runtime.trace

        with tempfile.TemporaryDirectory() as tmpdir:
            out_dir = Path(tmpdir)
            with patch.object(Encoding, "solve", side_effect=z3.Z3Exception("interrupted")):
                with self.assertRaises(z3.Z3Exception):
                    crosscheck_trace(model, trace, out=out_dir)

            smt2_path = out_dir / "path.smt2"
            result_path = out_dir / "result.json"
            self.assertTrue(smt2_path.exists())
            self.assertFalse(result_path.exists())


if __name__ == "__main__":
    unittest.main()
