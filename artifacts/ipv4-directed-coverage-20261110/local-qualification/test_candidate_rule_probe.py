import copy
import unittest
from unittest.mock import patch

from protocol_lab.ir import validate
from protocol_lab.symbolic import Encoding, model_hash
from candidate_rule_probe import render_probe


class TestCandidateRuleProbe(unittest.TestCase):
    def setUp(self):
        # Real valid toy model with word32-packed bytes and event field access.
        self.model = {
            "ir_version": "0.6",
            "semantics": "flat-efsm-atomic-ordered-v1",
            "protocol": "word32-packing-contract",
            "scope": {
                "terminal_states": [],
                "excluded": [
                    "Protocol field admission, TCP/IP state and wire layout",
                    "Network/PCAP observations",
                    "Unbounded compiler or protocol proof"
                ]
            },
            "states": ["READY"],
            "initial_state": "READY",
            "variables": {
                "packed": {"type": "bytes", "initial": [0, 0, 0, 0]}
            },
            "events": {
                "pack": {"origin": "application", "fields": {"value": "int"}}
            },
            "timers": {},
            "messages": {
                "word32.result": {"fields": {"packed": "bytes"}}
            },
            "requirements": {
                "WORD32-PACK": {
                    "source": "docs/word32-packing.md",
                    "kind": "modeling_choice",
                    "strength": "exact total value",
                    "interpretation": "Four big-endian octets of value modulo 2^32. This pure arithmetic is not uint32 field admission."
                }
            },
            "transitions": [
                {
                    "id": "PACK",
                    "from": "READY",
                    "to": "READY",
                    "event": "pack",
                    "guard": True,
                    "requirements": ["WORD32-PACK"],
                    "actions": [
                        {
                            "set": {
                                "var": "packed",
                                "value": {
                                    "op": "bytes_pack32be_mod",
                                    "args": [{"event": "value"}]
                                }
                            }
                        },
                        {
                            "emit": {
                                "message": "word32.result",
                                "fields": {"packed": {"var": "packed"}}
                            }
                        }
                    ]
                }
            ],
            "invariants": [
                {
                    "id": "PACKED-FOUR",
                    "requirements": ["WORD32-PACK"],
                    "assert": {
                        "op": "eq",
                        "args": [
                            {"op": "bytes_len", "args": [{"var": "packed"}]},
                            4
                        ]
                    }
                }
            ]
        }
        validate(self.model)  # ensure valid

    def test_render_probe_returns_queries(self):
        rule_ids = ["PACK"]
        report = render_probe(self.model, rule_ids)
        self.assertIn('queries', report)
        self.assertEqual(len(report['queries']), 2 * len(rule_ids))
        roles = [q['role'] for q in report['queries']]
        self.assertIn('preservation', roles)
        self.assertIn('nonvacuity', roles)
        for q in report['queries']:
            self.assertIn('smt2', q)
            self.assertIn('sha256', q)
            # SMT output has comments before set-info; parse via Solver.from_string instead of startswith
            try:
                z3_solver = q.get('_z3_solver')
                if z3_solver is None:
                    from z3 import Solver
                    z3_solver = Solver()
                    z3_solver.from_string(q['smt2'])
                    q['_z3_solver'] = z3_solver
                self.assertIsNotNone(z3_solver)
            except Exception as e:
                self.fail(f"SMT2 parse failed for {q['file']}: {e}")

    def test_render_probe_does_not_mutate_model(self):
        import copy
        model_copy = copy.deepcopy(self.model)
        render_probe(self.model, ["PACK"])
        self.assertEqual(self.model, model_copy)

    def test_reject_invariant_with_event_expression(self):
        bad_model = copy.deepcopy(self.model)
        bad_model['invariants'][0]['assert'] = {
            "op": "eq",
            "args": [{"event": "value"}, 0]
        }
        with self.assertRaises(ValueError):
            render_probe(bad_model, ["PACK"])

    def test_reject_invariant_with_clock(self):
        bad_model = copy.deepcopy(self.model)
        bad_model['timers'] = ["t"]
        bad_model['invariants'][0]['assert'] = {
            "op": "eq",
            "args": [{"clock_ms": "t"}, 0]
        }
        with self.assertRaises(ValueError):
            render_probe(bad_model, ["PACK"])

    def test_reject_empty_rule_ids(self):
        with self.assertRaises(ValueError):
            render_probe(self.model, [])

    def test_reject_duplicate_rule_ids(self):
        with self.assertRaises(ValueError):
            render_probe(self.model, ["PACK", "PACK"])

    def test_reject_unknown_rule_id(self):
        with self.assertRaises(ValueError):
            render_probe(self.model, ["NOP"])

    def test_render_probe_no_solver_check(self):
        # Patch Solver.check to fail if called
        with patch('protocol_lab.symbolic.Encoding.z.check', side_effect=AssertionError('Solver.check should not be called')):
            report = render_probe(self.model, ["PACK"])
        self.assertTrue(report['solver_executed'] is False)

    def test_preservation_query_good_rule_unsat_and_enabled_sat_using_solver(self):
        # Actual SMT check outside builder: parse preservation query and check unsat,
        # nonvacuity sat. Use z3 directly.
        from z3 import Solver, parse_smt2_string, sat, unsat
        report = render_probe(self.model, ["PACK"])
        for q in report['queries']:
            smt2 = q['smt2']
            s = Solver()
            s.add(parse_smt2_string(smt2))
            result = s.check()
            if q['role'] == 'preservation':
                self.assertEqual(result, unsat,
                                 f"Preservation query for PACK should be unsat, got {result} with model {s.model() if result == sat else ''}")
            elif q['role'] == 'nonvacuity':
                self.assertEqual(result, sat,
                                 "Nonvacuity query for PACK should be sat")

    def test_bad_rule_set_bytes_not_preserving_sat_negative(self):
        # negative use VALID {'bytes':[1,2,3]} assigned to actual action set VALUE => preservation SAT
        # do NOT claim bytes literal invalid
        bad_model = copy.deepcopy(self.model)
        # Change action to set packed to a bytes literal of length 3: valid IR, but violates invariant length 4.
        bad_model['transitions'][0]['actions'][0]['set']['value'] = {"bytes": [1,2,3]}
        # Assert that this model is valid according to IR
        validate(bad_model)
        report = render_probe(bad_model, ["PACK"])
        for q in report['queries']:
            from z3 import Solver, parse_smt2_string, sat, unsat
            s = Solver()
            s.add(parse_smt2_string(q['smt2']))
            result = s.check()
            if q['role'] == 'preservation':
                # Should be sat (counterexample exists) because prestate can satisfy length 4 invariant,
                # rule sets length 3, violating post invariant.
                self.assertEqual(result, sat,
                                 "Preservation query for bad PACK should be sat (induction fails)")
            elif q['role'] == 'nonvacuity':
                self.assertEqual(result, sat,
                                 "Nonvacuity still sat because guard true")

    def test_guard_false_nonvacuity_unsat(self):
        bad_model = copy.deepcopy(self.model)
        bad_model['transitions'][0]['guard'] = False
        report = render_probe(bad_model, ["PACK"])
        for q in report['queries']:
            from z3 import Solver, parse_smt2_string, sat, unsat
            s = Solver()
            s.add(parse_smt2_string(q['smt2']))
            result = s.check()
            if q['role'] == 'nonvacuity':
                self.assertEqual(result, unsat,
                                 "Nonvacuity with guard False should be unsat")

    def test_initial_variable_not_fixed_to_declared_initial(self):
        # Use solver to find a satisfying assignment where old packed is not [0,0,0,0]
        # by adding a constraint that packed != bytes literal [0,0,0,0].
        # Need to find the actual SMT variable name for packed in frame 0.
        # Encoding.frames[0]['vars'] or real API: enc.frames[0]['values']['packed'] gives Z3 expression,
        # but we need to parse the SMT string to get the name. Instead, we can build a new Encoding
        # with arbitrary_state=True (as the probe does) and inspect enc.frames[0]['values']['packed'].
        # We'll use enc.frames[0]['values']['packed'] directly in a new solver to assert inequality.
        # That's possible because we can import Encoding and access its internal frames.
        # However, the probe has already built the Encoding, but we can instantiate our own.
        from z3 import Solver, sat, unsat, Not, Eq, Bytes, Unit, Concat
        # Create an Encoding object similar to what the probe uses
        enc = Encoding(self.model, 1, tuple(self.model['variables']), arbitrary_state=True, fixed_choices=[0])
        z = enc.z
        old_packed = enc.frames[0]['values']['packed']
        # Build the Z3 expression for bytes literal [0,0,0,0]
        b0 = z.Unit(z.BitVecVal(0, 8))
        b1 = z.Unit(z.BitVecVal(0, 8))
        b2 = z.Unit(z.BitVecVal(0, 8))
        b3 = z.Unit(z.BitVecVal(0, 8))
        bytes_zero = z.Concat(b0, z.Concat(b1, z.Concat(b2, b3)))
        # Add assertions from enc.solver (base), plus negation of equality to initial
        s = z.Solver()
        s.add(enc.solver.assertions())
        s.add(z.Not(z.And(*[enc.expr(inv['assert'], enc.frames[0]) for inv in self.model['invariants']])))
        # Actually we want to show that there exists a prestate satisfying invariants and packed != [0,0,0,0].
        # So we add invariant and inequality.
        s.add(enc.expr(self.model['invariants'][0]['assert'], enc.frames[0]))
        s.add(old_packed != bytes_zero)
        result = s.check()
        self.assertEqual(result, sat,
                         "Expected SAT for arbitrary prestate with packed != [0,0,0,0] while invariant length=4 holds")

if __name__ == '__main__':
    unittest.main()
