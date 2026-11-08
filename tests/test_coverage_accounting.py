"""Tests for protocol_lab.pipeline.coverage accounting helper."""

import unittest

from protocol_lab.pipeline.coverage import summarize


RULE_IDS = ['rule-1', 'rule-2', 'rule-3', 'rule-4', 'rule-5']


def make_record(key, origin='model_generated', override=False, status='pass', transitions=None):
    if transitions is None:
        transitions = ['rule-1']
    return {
        'key': key,
        'origin': origin,
        'initial_override': override,
        'status': status,
        'transitions': transitions,
    }


class TestCoverageAccounting(unittest.TestCase):

    def test_basic_coverage(self):
        records = [
            make_record('a', origin='model_generated', transitions=['rule-1', 'rule-2']),
            make_record('b', origin='declared_seed', transitions=['rule-3']),
            make_record('c', origin='live_observation', override=True, transitions=['rule-4']),
        ]
        summary = summarize(RULE_IDS, records)
        self.assertEqual(summary['covered_default'], ['rule-1', 'rule-2', 'rule-3'])
        self.assertEqual(summary['uncovered_default'], ['rule-4', 'rule-5'])
        self.assertEqual(summary['covered_override'], ['rule-4'])
        self.assertEqual(summary['uncovered_override'], ['rule-1', 'rule-2', 'rule-3', 'rule-5'])
        self.assertEqual(summary['covered_overall'], ['rule-1', 'rule-2', 'rule-3', 'rule-4'])
        self.assertEqual(summary['uncovered_overall'], ['rule-5'])
        self.assertEqual(summary['total_declared'], 5)
        self.assertEqual(summary['total_covered'], 4)
        self.assertEqual(summary['total_uncovered'], 1)

    def test_failing_records_excluded_from_coverage(self):
        # Failing record lists committed prefix, but those should NOT count as covered.
        records = [
            make_record('passing', transitions=['rule-1']),
            make_record('failing', status='fail', transitions=['rule-2']),
            make_record('unknown', status='unknown', transitions=['rule-3']),
        ]
        summary = summarize(RULE_IDS, records)
        self.assertEqual(summary['covered_default'], ['rule-1'])
        self.assertEqual(summary['covered_override'], [])
        self.assertEqual(summary['covered_overall'], ['rule-1'])
        self.assertNotIn('rule-2', summary['covered_default'])
        self.assertNotIn('rule-3', summary['covered_default'])

    def test_override_cases_separated(self):
        records = [
            make_record('default1', transitions=['rule-1']),
            make_record('override1', override=True, transitions=['rule-2']),
        ]
        summary = summarize(RULE_IDS, records)
        self.assertEqual(summary['covered_default'], ['rule-1'])
        self.assertEqual(summary['covered_override'], ['rule-2'])
        self.assertEqual(summary['covered_overall'], ['rule-1', 'rule-2'])

    def test_origins_distinct(self):
        records = [
            make_record('gen', origin='model_generated', transitions=['rule-1']),
            make_record('seed', origin='declared_seed', transitions=['rule-2']),
            make_record('rej', origin='model_generated_rejection', status='fail', transitions=['rule-3']),
            make_record('live', origin='live_observation', transitions=['rule-4']),
        ]
        summary = summarize(RULE_IDS, records)
        self.assertEqual(summary['covered_by_origin']['model_generated'], ['rule-1'])
        self.assertEqual(summary['covered_by_origin']['declared_seed'], ['rule-2'])
        self.assertEqual(summary['covered_by_origin']['model_generated_rejection'], [])
        self.assertEqual(summary['covered_by_origin']['live_observation'], ['rule-4'])
        self.assertEqual(summary['origin_summary']['model_generated']['passing_records'], 1)
        self.assertEqual(summary['origin_summary']['model_generated_rejection']['failing_records'], 1)

    def test_unknown_rule_ids_rejected(self):
        records = [
            make_record('a', transitions=['rule-999']),
        ]
        with self.assertRaisesRegex(ValueError, 'unknown rule IDs'):
            summarize(RULE_IDS, records)

    def test_duplicate_record_keys_rejected(self):
        records = [
            make_record('dup', transitions=['rule-1']),
            make_record('dup', transitions=['rule-2']),
        ]
        with self.assertRaisesRegex(ValueError, 'duplicate record key'):
            summarize(RULE_IDS, records)

    def test_invalid_origin_rejected(self):
        records = [
            make_record('a', origin='made_up_origin'),
        ]
        with self.assertRaisesRegex(ValueError, "origin 'made_up_origin' not one of"):
            summarize(RULE_IDS, records)

    def test_duplicate_rule_ids_input_rejected(self):
        with self.assertRaisesRegex(ValueError, 'rule_ids must be unique'):
            summarize(['rule-1', 'rule-1'], [])

    def test_missing_fields_rejected(self):
        bad = make_record('a')
        del bad['status']
        with self.assertRaisesRegex(ValueError, 'record keys must be exactly'):
            summarize(RULE_IDS, [bad])

    def test_non_bool_initial_override_rejected(self):
        bad = make_record('a')
        bad['initial_override'] = 'yes'
        with self.assertRaisesRegex(ValueError, 'initial_override must be bool'):
            summarize(RULE_IDS, [bad])

    def test_empty_records(self):
        summary = summarize(RULE_IDS, [])
        self.assertEqual(summary['covered_default'], [])
        self.assertEqual(summary['covered_override'], [])
        self.assertEqual(summary['covered_overall'], [])
        self.assertEqual(summary['uncovered_overall'], RULE_IDS)
        self.assertEqual(summary['total_covered'], 0)

    def test_all_rules_covered(self):
        records = [
            make_record('a', transitions=RULE_IDS),
        ]
        summary = summarize(RULE_IDS, records)
        self.assertEqual(summary['covered_default'], RULE_IDS)
        self.assertEqual(summary['uncovered_default'], [])
        self.assertEqual(summary['uncovered_overall'], [])

    # --- Additional tests for new validation ---

    def test_rule_ids_string_rejected(self):
        with self.assertRaisesRegex(ValueError, 'rule_ids must be an iterable of strings, not str/bytes'):
            summarize('ab', [])

    def test_rule_ids_bytes_rejected(self):
        with self.assertRaisesRegex(ValueError, 'rule_ids must be an iterable of strings, not str/bytes'):
            summarize(b'ab', [])

    def test_rule_ids_non_iterable_rejected(self):
        with self.assertRaisesRegex(ValueError, 'rule_ids must be iterable'):
            summarize(42, [])

    def test_rule_ids_non_string_elements_rejected(self):
        with self.assertRaisesRegex(ValueError, 'rule_ids must be non-empty strings'):
            summarize(['rule-1', 2], [])

    def test_rule_ids_empty_string_element_rejected(self):
        with self.assertRaisesRegex(ValueError, 'rule_ids must be non-empty strings'):
            summarize(['rule-1', ''], [])

    def test_records_string_rejected(self):
        with self.assertRaisesRegex(ValueError, 'records must be an iterable of record dicts, not str/bytes'):
            summarize(RULE_IDS, 'notalist')

    def test_records_non_iterable_rejected(self):
        with self.assertRaisesRegex(ValueError, 'records must be iterable'):
            summarize(RULE_IDS, 42)

    def test_record_not_dict_rejected(self):
        with self.assertRaisesRegex(ValueError, 'record .* must be a dict'):
            summarize(RULE_IDS, ['notadict'])

    def test_extra_record_key_rejected(self):
        bad = make_record('a')
        bad['extra'] = 'field'
        with self.assertRaisesRegex(ValueError, 'record keys must be exactly'):
            summarize(RULE_IDS, [bad])

    def test_origin_non_string_rejected(self):
        bad = make_record('a')
        bad['origin'] = 123
        with self.assertRaisesRegex(ValueError, 'origin must be a string'):
            summarize(RULE_IDS, [bad])

    def test_origin_empty_string_rejected(self):
        bad = make_record('a')
        bad['origin'] = ''
        with self.assertRaisesRegex(ValueError, "origin '' not one of"):
            summarize(RULE_IDS, [bad])

    def test_status_non_string_rejected(self):
        bad = make_record('a')
        bad['status'] = 123
        with self.assertRaisesRegex(ValueError, 'status must be a string'):
            summarize(RULE_IDS, [bad])

    def test_status_empty_string_rejected(self):
        bad = make_record('a')
        bad['status'] = ''
        with self.assertRaisesRegex(ValueError, "status '' not one of"):
            summarize(RULE_IDS, [bad])

    def test_transitions_non_list_rejected(self):
        bad = make_record('a')
        bad['transitions'] = 'rule-1'
        with self.assertRaisesRegex(ValueError, 'transitions must be a list'):
            summarize(RULE_IDS, [bad])

    def test_transitions_non_string_element_rejected(self):
        bad = make_record('a')
        bad['transitions'] = ['rule-1', 2]
        with self.assertRaisesRegex(ValueError, 'transitions must be non-empty strings'):
            summarize(RULE_IDS, [bad])

    def test_transitions_empty_string_element_rejected(self):
        bad = make_record('a')
        bad['transitions'] = ['rule-1', '']
        with self.assertRaisesRegex(ValueError, 'transitions must be non-empty strings'):
            summarize(RULE_IDS, [bad])

    def test_unknown_rule_id_in_failing_record_rejected(self):
        record = make_record('fail', status='fail', transitions=['rule-999'])
        with self.assertRaisesRegex(ValueError, 'unknown rule IDs'):
            summarize(RULE_IDS, [record])

    def test_input_not_mutated(self):
        rule_ids_orig = RULE_IDS.copy()
        rec1 = make_record('a', transitions=['rule-1'])
        rec2 = make_record('b', status='fail', transitions=['rule-2'])
        records_orig = [rec1, rec2]
        summarize(rule_ids_orig, records_orig)
        # Check that rule_ids list is unchanged
        self.assertEqual(rule_ids_orig, RULE_IDS)
        # Check that records list and each record dict are unchanged
        self.assertEqual(len(records_orig), 2)
        self.assertEqual(records_orig[0], rec1)
        self.assertEqual(records_orig[1], rec2)
        self.assertEqual(rec1['transitions'], ['rule-1'])
        self.assertEqual(rec2['status'], 'fail')

    def test_negative_record_with_valid_committed_prefix_accepted(self):
        # Failing record with a committed prefix that is valid (all rule IDs known)
        record = make_record('fail', status='fail', transitions=['rule-2', 'rule-3'])
        summary = summarize(RULE_IDS, [record])
        # It should be accepted and not contribute to coverage.
        self.assertEqual(summary['covered_default'], [])
        self.assertEqual(summary['covered_override'], [])
        self.assertEqual(summary['covered_overall'], [])
        self.assertEqual(summary['origin_summary']['model_generated']['failing_records'], 1)


if __name__ == '__main__':
    unittest.main()
