"""Circular first-send segment provenance and whole-segment ACK credit."""
import copy
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario, digest
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.symbolic import crosscheck_trace


def ready(model, initial=None):
    m = Machine(model, initial or {})
    m.dispatch('app.connect')
    m.dispatch('net.synack', dict(seq=9000, ack=(m.values['iss'] + 1) % 2**32, window=16), 10)
    return m


def credit(m):
    return [{'time_ms': r['time_ms'], 'bytes': r['after']['variables']['cb_step_bytes']}
            for r in m.trace if r['after']['variables']['cb_step_bytes']]


class SentLedgerTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.model = load(ROOT / 'model/tcp-sent-ledger.json')
        cls.parent = load(ROOT / 'model/tcp-output-schedule.json')
        cls.executions = {p.stem: run_scenario(cls.model, read(p))
                          for p in sorted((ROOT / 'scenarios/sent-ledger').glob('*.json'))}

    def test_instrumentation_preserves_all_parent_actions_guards_and_targets(self):
        self.assertEqual(len(self.model['transitions']), len(self.parent['transitions']))
        for parent, child in zip(self.parent['transitions'], self.model['transitions']):
            with self.subTest(rule=parent['id']):
                for key in ['id', 'event', 'from', 'to', 'guard', 'target_cases']:
                    self.assertEqual(parent.get(key), child.get(key))
                stripped = [a for a in child['actions'] if not ('set' in a and a['set']['var'].startswith('cb_'))]
                self.assertEqual(stripped, parent['actions'])
        self.assertTrue(set(self.model['variables']) - set(self.parent['variables']))
        self.assertTrue(all(n.startswith('cb_') for n in set(self.model['variables']) - set(self.parent['variables'])))

    def test_fixed_source_witnesses_and_handwritten_callback_contracts(self):
        for row in read(ROOT / 'ports/lwip-service/contracts.json'):
            name = row['id']; source = read(ROOT / f'ports/lwip-service/scenarios/{name}.json')
            witness = read(ROOT / f'ports/lwip-service/witnesses/{name}.json')
            flattened = [source['steps'][d['source_step']] if 'source_step' in d else d for d in witness['steps']]
            self.assertEqual(flattened, read(ROOT / f'scenarios/sent-ledger/{name}.json')['steps'])
            self.assertEqual(credit(self.executions[name]), row['sent_events'])

    def test_partial_ack_credit_and_original_segment_retirement_are_distinct(self):
        m = self.executions['wide-window-partial-no-callback']
        self.assertEqual((m.values['svc_acked_bytes'], m.values['cb_acked_total'],
                          m.values['cb_partial_prefix'], m.values['cb_count']), (2, 0, 2, 1))
        self.assertEqual(credit(m), [])
        self.assertEqual(credit(self.executions['wide-window-partial-then-full']), [{'time_ms': 40, 'bytes': 4}])

    def test_retransmission_does_not_add_record_or_double_callback(self):
        m = self.executions['partial-rto-credit']
        retransmissions = [r for r in m.trace if r['time_ms'] in (2000, 4000)]
        self.assertEqual(len(retransmissions), 2)
        for r in retransmissions:
            values = r['after']['variables']
            self.assertEqual((values['cb_new_count'], values['cb_emitted_total'], values['cb_count']), (0, 4, 1))
        self.assertEqual((m.values['cb_emitted_total'], m.values['cb_acked_total']), (4, 4))
        self.assertEqual(credit(m), [{'time_ms': 5100, 'bytes': 4}])

    def test_ring_reuse_wrap_and_full_byte_independent_query(self):
        m = ready(self.model, {'iss': 2**32 - 3, 'cc_initial_window': 16, 'cc_cwnd': 16})
        start = (m.values['iss'] + 1) % 2**32
        m.dispatch('app.send', {'data': list(range(16))}, 20)
        m.dispatch('app.transmit', time_ms=21)
        for _ in range(16): m.dispatch('choice.segment', {'count': 1}, 21)
        self.assertEqual((m.values['cb_count'], m.values['cb_head'], m.values['cb_tail']), (16, 0, 0))
        m.dispatch('net.ack', dict(seq=9001, ack=(start + 5) % 2**32, window=16), 30)
        self.assertEqual((m.values['cb_step_bytes'], m.values['cb_count'], m.values['cb_head']), (5, 11, 5))
        m.dispatch('app.send', {'data': [128, 255, 17, 33, 65]}, 31)
        m.dispatch('app.transmit', time_ms=32)
        for _ in range(5): m.dispatch('choice.segment', {'count': 1}, 32)
        self.assertEqual((m.values['cb_count'], m.values['cb_head'], m.values['cb_tail']), (16, 5, 5))
        m.dispatch('net.ack', dict(seq=9001, ack=(start + 21) % 2**32, window=16), 40)
        self.assertEqual((m.values['cb_count'], m.values['cb_acked_total'], m.values['cb_emitted_total']), (0, 21, 21))
        self.assertEqual(credit(m), [{'time_ms': 30, 'bytes': 5}, {'time_ms': 40, 'bytes': 16}])
        with tempfile.TemporaryDirectory() as tmp:
            self.assertEqual(crosscheck_trace(self.model, m.trace, Path(tmp))['status'], 'match')

    def test_partial_reset_abandons_original_record_not_ack_callback(self):
        source = read(ROOT / 'scenarios/sent-ledger/wide-window-partial-no-callback.json')
        m = Machine(self.model)
        for step in source['steps'][:-1]: m.dispatch(step['event'], step['fields'], step['at_ms'])
        m.dispatch('net.rst', {'seq': 9001}, 31)
        self.assertEqual((m.values['cb_count'], m.values['cb_acked_total'], m.values['cb_abandoned_total']), (0, 0, 4))
        self.assertEqual((m.values['svc_acked_bytes'], m.values['svc_abandoned_bytes']), (2, 2))
        m.dispatch('app.connect', time_ms=40)
        m.dispatch('net.synack', dict(seq=9000, ack=1001, window=16), 50)
        m.dispatch('app.send', {'data': [128, 0, 7, 255]}, 60)
        m.dispatch('app.transmit', time_ms=61); m.dispatch('choice.segment', {'count': 4}, 61)
        m.dispatch('net.ack', dict(seq=9001, ack=1005, window=16), 70)
        self.assertEqual((m.values['cb_emitted_total'], m.values['cb_acked_total'], m.values['cb_abandoned_total']), (8, 4, 4))

    def test_per_byte_callback_fault_is_detected(self):
        bad = copy.deepcopy(self.model)
        for t in bad['transitions']:
            for a in t['actions']:
                if 'set' in a and a['set']['var'] == 'cb_step_bytes': a['set']['value'] = {'var': 'cc_acked'}
        m = ready(bad)
        m.dispatch('app.send', {'data': [0, 128, 255, 7]}, 20)
        m.dispatch('app.transmit', time_ms=21); m.dispatch('choice.segment', {'count': 4}, 21)
        with self.assertRaisesRegex(ModelError, 'CB-INV-MASS'):
            m.dispatch('net.ack', dict(seq=9001, ack=1003, window=16), 30)

    def test_wrong_exclusive_segment_end_is_detected(self):
        bad = copy.deepcopy(self.model)
        for t in bad['transitions']:
            for a in t['actions']:
                if 'set' in a and a['set']['var'] == 'cb_append_end' and a['set']['value'] != {'seq': 0}:
                    a['set']['value'] = {'var': 'cb_before_nxt'}
        m = ready(bad)
        m.dispatch('app.send', {'data': [0, 128, 255, 7]}, 20); m.dispatch('app.transmit', time_ms=21)
        with self.assertRaisesRegex(ModelError, 'CB-INV-SLOT'):
            m.dispatch('choice.segment', {'count': 4}, 21)

    def test_generator_and_primary_sources_are_hash_bound(self):
        raw = (ROOT / 'model/tcp-sent-ledger.json').read_bytes()
        subprocess.run([sys.executable, str(ROOT / 'tools/build_sent_ledger_model.py')], check=True)
        self.assertEqual(raw, (ROOT / 'model/tcp-sent-ledger.json').read_bytes())
        source = read(ROOT / 'spec/sources/tcp-sent-ledger.json')
        for name, sha in source['sha256'].items(): self.assertEqual(digest(ROOT / name), sha)


if __name__ == '__main__': unittest.main(verbosity=2)
