"""Interruption-safe SMT journal tests for symbolic.check (exact-v1)."""
import hashlib
import unittest
from pathlib import Path
from unittest.mock import patch

import z3

from protocol_lab.symbolic import check, Encoding
from tests.test_solver_preprocessing import tiny_model


def _sha(text):
    return hashlib.sha256(text.encode()).hexdigest()


class JournalInterruptionTest(unittest.TestCase):
    def test_first_solve_interrupt_leaves_safety_smt_no_result(self):
        model = tiny_model()
        with __import__('tempfile').TemporaryDirectory() as tmp:
            out = Path(tmp) / 'journal'
            original_solve = Encoding.solve
            calls = {'n': 0}

            def interrupt_first(self_solver, *a, **k):
                calls['n'] += 1
                if calls['n'] == 1:
                    raise KeyboardInterrupt
                return original_solve(self_solver, *a, **k)

            with patch.object(Encoding, 'solve', interrupt_first):
                with self.assertRaises(KeyboardInterrupt):
                    check(model, depth=2, symbolic_initials=[], out=out, solver_preprocess='exact-v1')
            self.assertTrue((out / 'model.smt2').exists(), 'safety SMT must exist after first-solve interrupt')
            self.assertFalse((out / 'result.json').exists(), 'no result.json on interruption')
            self.assertFalse((out / 'overlap.smt2').exists(), 'overlap SMT not yet written')

    def test_overlap_solve_interrupt_leaves_overlap_smt_no_result(self):
        model = tiny_model()
        with __import__('tempfile').TemporaryDirectory() as tmp:
            out = Path(tmp) / 'journal'
            original_solve = Encoding.solve
            calls = {'n': 0}

            def interrupt_second(self_solver, *a, **k):
                calls['n'] += 1
                if calls['n'] == 2:
                    raise KeyboardInterrupt
                return original_solve(self_solver, *a, **k)

            with patch.object(Encoding, 'solve', interrupt_second):
                with self.assertRaises(KeyboardInterrupt):
                    check(model, depth=2, symbolic_initials=[], out=out, solver_preprocess='exact-v1')
            self.assertTrue((out / 'model.smt2').exists())
            self.assertTrue((out / 'overlap.smt2').exists(), 'overlap SMT must exist after overlap-solve interrupt')
            self.assertFalse((out / 'result.json').exists(), 'no result.json on interruption')

    def test_sample_solve_interrupt_leaves_sample_smt_no_result(self):
        model = tiny_model()
        with __import__('tempfile').TemporaryDirectory() as tmp:
            out = Path(tmp) / 'journal'
            original_solve = Encoding.solve
            calls = {'n': 0}

            def interrupt_third(self_solver, *a, **k):
                calls['n'] += 1
                if calls['n'] == 3:
                    raise KeyboardInterrupt
                return original_solve(self_solver, *a, **k)

            with patch.object(Encoding, 'solve', interrupt_third):
                with self.assertRaises(KeyboardInterrupt):
                    check(model, depth=2, symbolic_initials=[], out=out, solver_preprocess='exact-v1')
            self.assertTrue((out / 'model.smt2').exists())
            self.assertTrue((out / 'overlap.smt2').exists(), 'overlap SMT must exist after overlap-solve interrupt')
            self.assertTrue((out / 'sample-any-path.smt2').is_file(), 'sample query must survive interrupted sample solve')
            self.assertFalse((out / 'result.json').exists(), 'no result.json on interruption')

    def test_nonempty_out_refused_before_mutation(self):
        model = tiny_model()
        with __import__('tempfile').TemporaryDirectory() as tmp:
            out = Path(tmp) / 'journal'
            out.mkdir(parents=True)
            marker = out / 'immutable_marker.txt'
            marker.write_text('do-not-touch')
            before = {p.name: p.read_bytes() for p in out.iterdir()}
            with self.assertRaises(Exception):
                check(model, depth=2, symbolic_initials=[], out=out, solver_preprocess='exact-v1')
            after = {p.name: p.read_bytes() for p in out.iterdir()}
            self.assertEqual(before, after, 'nonempty out must be untouched')
            self.assertTrue(marker.exists())

    def test_empty_precreated_out_allowed(self):
        model = tiny_model()
        with __import__('tempfile').TemporaryDirectory() as tmp:
            out = Path(tmp) / 'journal'
            out.mkdir(parents=True)
            report = check(model, depth=2, symbolic_initials=[], out=out, solver_preprocess='exact-v1')
            self.assertEqual(report['status'], 'bounded_pass')
            self.assertTrue((out / 'model.smt2').exists())
            self.assertTrue((out / 'overlap.smt2').exists())
            self.assertTrue((out / 'result.json').exists())

    def test_success_binds_smt_hash_to_report(self):
        model = tiny_model()
        with __import__('tempfile').TemporaryDirectory() as tmp:
            out = Path(tmp) / 'journal'
            report = check(model, depth=2, symbolic_initials=[], out=out, solver_preprocess='exact-v1')
            smt_text = (out / 'model.smt2').read_text()
            overlap_text = (out / 'overlap.smt2').read_text()
            self.assertEqual(report['smt2_sha256'], _sha(smt_text))
            self.assertEqual(report['overlap_smt2_sha256'], _sha(overlap_text))
            self.assertTrue((out / 'result.json').exists())

    def test_default_none_unchanged_no_journal(self):
        model = tiny_model()
        report = check(model, depth=2, symbolic_initials=[], solver_preprocess='none')
        self.assertNotIn('smt2_sha256', report)


if __name__ == '__main__':
    unittest.main()
