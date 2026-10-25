import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, write
from protocol_lab.ir import Machine, ModelError, load, validate
from protocol_lab.symbolic import Encoding, check, encode_trace, replay


def timer_model():
    return {
        "ir_version": "0.2", "semantics": "flat-efsm-atomic-ordered-v1", "protocol": "conditional-timer-test",
        "scope": {"terminal_states": []}, "states": ["READY"], "initial_state": "READY",
        "requirements": {"SCOPE": {"source": "docs/semantics.md", "interpretation": "Conditional timer semantics"}},
        "variables": {"count": {"type": "int", "initial": 0}, "data": {"type": "bytes", "initial": []}},
        "events": {"arm": {"origin": "application", "fields": {"when": "bool", "delay": "int"}},
                   "cancel": {"origin": "application", "fields": {"when": "bool"}},
                   "expired": {"origin": "timer", "fields": {}}},
        "messages": {}, "timers": {"clock": {"event": "expired"}},
        "transitions": [
            {"id": "ARM", "from": "READY", "to": "READY", "event": "arm", "guard": True,
             "actions": [{"set": {"var": "count", "value": {"op": "add", "args": [{"var": "count"}, 1]}}},
                         {"arm_if": {"when": {"event": "when"}, "timer": "clock", "delay_ms": {"event": "delay"}}}], "requirements": ["SCOPE"]},
            {"id": "CANCEL", "from": "READY", "to": "READY", "event": "cancel", "guard": True,
             "actions": [{"cancel_if": {"when": {"event": "when"}, "timer": "clock"}}], "requirements": ["SCOPE"]},
            {"id": "EXPIRED", "from": "READY", "to": "READY", "event": "expired", "guard": True,
             "actions": [{"set": {"var": "count", "value": {"op": "add", "args": [{"var": "count"}, 10]}}}], "requirements": ["SCOPE"]}],
        "invariants": [{"id": "COUNT", "assert": {"op": "ge", "args": [{"var": "count"}, 0]}, "requirements": ["SCOPE"]}]
    }


class ConditionalTimerTests(unittest.TestCase):
    def test_false_conditions_leave_existing_deadlines_and_ignore_invalid_delay(self):
        m = Machine(timer_model())
        m.dispatch("arm", {"when": False, "delay": 0})
        self.assertEqual(m.timers, {})
        m.dispatch("arm", {"when": True, "delay": 10}, 1)
        m.dispatch("arm", {"when": False, "delay": -1}, 2)
        m.dispatch("cancel", {"when": False}, 3)
        self.assertEqual(m.timers, {"clock": 11})
        m.tick(11)
        self.assertEqual(m.timers, {})
        self.assertEqual(m.values["count"], 13)

    def test_true_conditions_replace_cancel_and_rollback_the_whole_event(self):
        m = Machine(timer_model())
        m.dispatch("arm", {"when": True, "delay": 10})
        m.dispatch("arm", {"when": True, "delay": 20}, 1)
        self.assertEqual(m.timers, {"clock": 21})
        before, trace = m.snapshot(), copy.deepcopy(m.trace)
        with self.assertRaisesRegex(ModelError, "duration must be positive"):
            m.dispatch("arm", {"when": True, "delay": 0}, 2)
        self.assertEqual(m.snapshot(), before)
        self.assertEqual(m.trace, trace)
        self.assertEqual(m.now_ms, 1)
        m.dispatch("cancel", {"when": True}, 3)
        m.dispatch("cancel", {"when": True}, 4)
        m.tick(100)
        self.assertEqual(m.timers, {})
        self.assertEqual(m.values["count"], 2)

    def test_conditional_action_types_shapes_and_old_versions_are_rejected(self):
        for action in [{"arm_if": {"when": 1, "timer": "clock", "delay_ms": 1}},
                       {"arm_if": {"when": True, "timer": "missing", "delay_ms": 1}},
                       {"arm_if": {"when": True, "timer": "clock", "delay_ms": 1, "callback": "x"}},
                       {"cancel_if": {"when": "yes", "timer": "clock"}}]:
            model = timer_model()
            model["transitions"][0]["actions"] = [action]
            with self.assertRaises(ModelError):
                validate(model)
        old = read(ROOT / "model/tcp.json")
        old["transitions"][0]["actions"].append({"cancel_if": {"when": False, "timer": next(iter(old["timers"]))}})
        with self.assertRaisesRegex(ModelError, "require IR 0.2"):
            validate(old)


class AnchoredCompositionTests(unittest.TestCase):
    def test_ordered_prepend_edit_append_and_requirement_traceability(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            base = read(ROOT / "model/tcp.json")
            rid = base["transitions"][0]["id"]
            action = base["transitions"][0]["actions"][0]
            def emit(phase):
                return {"emit": {"message": "marker", "fields": {"phase": phase}}}
            overlay = {"ir_version": "0.2", "extends": "base.json",
                "requirements": {"COMPOSITION": {"source": "docs/semantics.md", "interpretation": "Explicit action ordering"}},
                "messages": {"marker": {"fields": {"phase": "string"}}},
                "amend_transitions": [{"id": rid, "guard": True, "prepend_actions": [emit("pre")],
                    "edit_actions": [{"at": 0, "expected": action, "with": [emit("edit"), action]}],
                    "append_actions": [emit("post")], "add_requirements": ["COMPOSITION"]}]}
            write(root / "base.json", base)
            write(root / "overlay.json", overlay)
            model = load(root / "overlay.json")
            m = Machine(model)
            m.dispatch(base["transitions"][0]["event"])
            self.assertEqual([x["fields"]["phase"] for x in m.trace[0]["emitted"] if x["message"] == "marker"], ["pre", "edit", "post"])
            self.assertEqual(m.trace[0]["emitted"][2]["message"], "tcp")
            self.assertIn("COMPOSITION", m.trace[0]["requirements"])
            base["transitions"][0]["actions"].insert(0, base["transitions"][0]["actions"][-1])
            write(root / "base.json", base)
            with self.assertRaisesRegex(ModelError, "anchor changed"):
                load(root / "overlay.json")

    def test_bad_edit_and_ambiguous_guard_are_explicitly_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            base = read(ROOT / "model/tcp.json")
            write(root / "base.json", base)
            rid = base["transitions"][0]["id"]
            for fields in [{"guard": True, "and_guard": True},
                           {"edit_actions": [{"at": -1, "expected": {}, "with": []}]},
                           {"edit_actions": [{"at": 0, "expected": {}, "with": []}]},
                           {"add_requirements": [base["transitions"][0]["requirements"][0]]}]:
                write(root / "overlay.json", {"ir_version": "0.2", "extends": "base.json", "amend_transitions": [{"id": rid, **fields}]})
                with self.assertRaises(ModelError):
                    load(root / "overlay.json")


@unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
class SymbolicConditionalTimerTests(unittest.TestCase):
    def test_full_symbolic_trace_preserves_skipped_timers_and_expiry(self):
        model = timer_model()
        m = Machine(model)
        m.dispatch("arm", {"when": False, "delay": -1})
        m.dispatch("arm", {"when": True, "delay": 10}, 1)
        m.dispatch("cancel", {"when": False}, 2)
        m.tick(11)
        enc = encode_trace(model, m.trace)
        self.assertEqual(enc.solve(), enc.z.sat)
        self.assertEqual(replay(model, enc.witness(enc.solver.model()))["status"], "match")

    def test_enabled_invalid_delay_produces_replayable_fault_but_disabled_does_not(self):
        model = timer_model()
        result = check(model, depth=2, symbolic_initials=())
        self.assertEqual(result["status"], "counterexample")
        self.assertEqual(result["replay"]["status"], "runtime_rejected")
        self.assertIn("duration must be positive", result["replay"]["error"])
        model["transitions"][0]["guard"] = {"op": "or", "args": [
            {"op": "not", "args": [{"event": "when"}]},
            {"op": "ge", "args": [{"event": "delay"}, 1]}]}
        self.assertEqual(check(model, depth=4, symbolic_initials=())["status"], "bounded_pass")

    def test_length_projection_checks_conditional_timer_guards_for_content(self):
        for kind in ("arm_if", "cancel_if"):
            model = timer_model()
            action = {"when": {"op": "eq", "args": [{"var": "data"}, {"bytes": []}]}, "timer": "clock"}
            if kind == "arm_if":
                action["delay_ms"] = 1
            model["transitions"][0]["actions"] = [{kind: action}]
            with self.assertRaisesRegex(ModelError, "byte-content equality"):
                Encoding(model, 1, (), byte_encoding="length")
