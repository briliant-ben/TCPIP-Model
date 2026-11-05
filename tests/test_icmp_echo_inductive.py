"""Supplementary full-sequence contracts do not replace the old ICMP BMC."""
import contextlib
import copy
import io
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch

from protocol_lab.ir import load, model_files
from protocol_lab.pipeline import runner
from protocol_lab.pipeline.task import read, write, sha
from protocol_lab.sequence_induction import prove, verify

ROOT = Path(__file__).resolve().parents[1]


class IcmpEchoInductiveTests(unittest.TestCase):
    def test_supplement_preserves_all_original_protocol_inputs(self):
        original = read(ROOT / 'flows/icmp-echo.json')
        supplement = read(ROOT / 'flows/icmp-echo-inductive.json')
        self.assertEqual(original['formal'], {
            'depth': 2, 'symbolic_initials': [], 'solver_timeout_ms': 60000})
        expected = copy.deepcopy(original)
        expected.update(schema='spec-flow-task-v4', id='icmp-ipv4-echo-inductive',
                        formal={'strategy': 'sequence-invariant-induction'})
        self.assertEqual(supplement, expected)

    def test_full_sequence_initial_rule_and_overlap_contracts(self):
        model = load(ROOT / 'model/icmp-echo.json')
        with tempfile.TemporaryDirectory() as temporary:
            with patch('protocol_lab.ir.Machine.dispatch',
                       side_effect=AssertionError('Reference used in constraints')):
                report = prove(model, out=temporary)
            self.assertEqual(report['status'], 'inductive_invariants_pass')
            self.assertEqual(report['solver_timeout_ms'], 10000)
            self.assertEqual(report['initial_query']['query'], 'unsat')
            self.assertEqual(report['initial_nonvacuity']['query'], 'sat')
            self.assertEqual(len(report['preservation']), 5)
            self.assertEqual(len(report['overlap']), 1)
            self.assertTrue(all(row['obligation']['query'] == 'unsat' and
                                row['nonvacuity']['query'] == 'sat'
                                for row in report['preservation']))
            self.assertEqual(report['overlap'][0]['obligation']['query'], 'unsat')
            self.assertEqual(verify(model, temporary)['query_files'], 13)
            self.assertFalse(report['wire_content_proved'])
            self.assertFalse(report['compiler_correctness_proved'])
            self.assertFalse(report['unbounded_protocol_proof'])

    def test_stale_reply_fault_is_a_failed_inductive_obligation(self):
        model = load(ROOT / 'model/icmp-echo.json')
        short = next(rule for rule in model['transitions'] if rule['id'] == 'SHORT')
        short['actions'].pop(0)  # Keep a possible prior reply when marking a drop.
        report = prove(model)
        failed = next(row for row in report['preservation'] if row['rule'] == 'SHORT')
        self.assertEqual(failed['obligation']['query'], 'sat')
        self.assertEqual(report['status'], 'inductive_obligation_failure')
        self.assertEqual(report['failed_prestate_reachability'], 'not_claimed')

    @unittest.skipUnless(shutil.which('cc'), 'Actual C compiler required')
    def test_actual_supplementary_ten_stage_flow(self):
        task = read(ROOT / 'flows/icmp-echo-inductive.json')
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            workspace = root / 'workspace'
            workspace.mkdir()
            names = {task['model'], task['exploration'], *task['seeds'],
                     *(source['path'] for source in task['sources'])}
            names |= {str(path.relative_to(ROOT))
                      for path in model_files(ROOT / task['model'])}
            for name in names:
                target = workspace / name
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(ROOT / name, target)
            filename = workspace / 'task.json'
            write(filename, task)
            with contextlib.redirect_stdout(io.StringIO()):
                result = runner.run(filename, workspace, root / 'run', sha(filename))
                verified = runner.verify(root / 'run', workspace, sha(filename))
            self.assertEqual(result['assessment'], 'verified_event_slice')
            self.assertEqual(result['stages']['formal']['data']['status'],
                             'inductive_invariants_pass')
            self.assertEqual(len(result['stages']['formal']['data']['query_hashes']), 13)
