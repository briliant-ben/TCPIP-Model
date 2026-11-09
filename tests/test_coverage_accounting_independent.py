"""Controller-authored counterexamples independent of the candidate's tests."""
import copy
import unittest
from protocol_lab.pipeline.coverage import summarize


class IndependentCoverageTests(unittest.TestCase):
    def row(self, **kw):
        return dict(key='a', origin='declared_seed', initial_override=False,
                    status='pass', transitions=['r1'], **kw)

    def test_mixed_extra_keys_reject_as_value_error(self):
        row = self.row()
        row[7] = 'malformed'
        with self.assertRaises(ValueError):
            summarize(['r1'], [row])

    def test_passing_rejection_counts_only_supplied_committed_prefix(self):
        row = self.row()
        row.update(origin='model_generated_rejection', transitions=['r1', 'r1'])
        r = summarize(['r1', 'rejected-rule'], [row])
        self.assertEqual(r['covered_overall'], ['r1'])
        self.assertEqual(r['uncovered_overall'], ['rejected-rule'])
        self.assertNotIn('assessment', r)

    def test_ignored_record_still_validates_unknown_rule(self):
        for status in ['fail', 'unknown']:
            with self.subTest(status=status), self.assertRaises(ValueError):
                row = self.row()
                row.update(status=status, transitions=['invented'])
                summarize(['r1'], [row])

    def test_origins_and_initials_are_independent_dimensions(self):
        rows = [self.row()]
        other = self.row()
        other.update(key='b', origin='live_observation', initial_override=True,
                     transitions=['r2'])
        rows.append(other)
        before = copy.deepcopy(rows)
        r = summarize(['r2', 'r1', 'r3'], rows)
        self.assertEqual(rows, before)
        self.assertEqual(r['covered_default'], ['r1'])
        self.assertEqual(r['covered_override'], ['r2'])
        self.assertEqual(r['total_declared'], 3)
        self.assertEqual(r['uncovered_overall'], ['r3'])

    def test_empty_uncovered_domain_is_not_a_proof(self):
        r = summarize([], [])
        self.assertEqual(r['total_declared'], 0)
        self.assertEqual(r['total_covered'], 0)
        self.assertNotIn('proof', r)
        self.assertNotIn('assessment', r)
