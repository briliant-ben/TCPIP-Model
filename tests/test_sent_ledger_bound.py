"""Queue capacity and deferred whole-segment callback credit differ."""
from pathlib import Path
import tempfile
import unittest
from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.ir import load
from protocol_lab.symbolic import crosscheck_trace


class SentLedgerBoundTests(unittest.TestCase):
    def test_partial_head_plus_full_unacked_queue_can_release19(self):
        model = load(ROOT / 'model/tcp-sent-ledger.json')
        scene = read(ROOT / 'scenarios/sent-ledger/credit19-circular-boundary.json')
        machine = run_scenario(model, scene)
        self.assertEqual(machine.values['cb_step_bytes'], 19)
        self.assertEqual(machine.values['svc_acked_bytes'], 19)
        self.assertEqual(machine.values['cb_partial_prefix'], 0)
        with tempfile.TemporaryDirectory() as tmp:
            self.assertEqual(crosscheck_trace(model, machine.trace, Path(tmp))['status'], 'match')


if __name__ == '__main__': unittest.main(verbosity=2)
