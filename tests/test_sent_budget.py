"""Actual historical SAT pre-states must fail the new unsent-credit relation."""
from types import SimpleNamespace
import unittest
from protocol_lab.flow import ROOT, read
from protocol_lab.ir import load, evaluate


class SentBudgetTests(unittest.TestCase):
    def test_historical_send_and_persist_counterstates_fail_new_budget(self):
        model = load(ROOT / 'model/tcp-sent-ledger.json')
        predicate = next(i['assert'] for i in model['invariants'] if i['id'] == 'CB-INV-UNSENT-BUDGET')
        rows = read(ROOT / 'tests/fixtures/sent-ledger-ghost-credit.json')
        self.assertEqual(len(rows), 11)
        for row in rows:
            with self.subTest(rule=row['rule']):
                state = SimpleNamespace(values={'cb_emitted_total': row['emitted'],
                    'snd_buf': [0] * row['queued'], 'svc_written_bytes': row['written']})
                self.assertFalse(evaluate(predicate, state))


if __name__ == '__main__': unittest.main(verbosity=2)
