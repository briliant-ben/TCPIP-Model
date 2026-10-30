"""Explicit scheduling choices retain byte, budget, sequence and clock semantics."""
import copy
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario, digest
from protocol_lab.ir import MOD, Machine, ModelError, Uncovered, load
from protocol_lab.symbolic import crosscheck_trace


def ready(model, window=16, initial=None, data=None):
    m = Machine(model, initial)
    m.dispatch('app.connect'); m.dispatch('net.synack', dict(seq=9000, ack=m.values['snd_nxt'], window=window), 10)
    m.dispatch('app.send', dict(data=[0, 128, 255, 7, 17, 33, 65, 129] if data is None else data), 20)
    return m


class SegmentChoiceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls): cls.model = load(ROOT / 'model/tcp-segment-choice.json')

    def test_two_short_segments_preserve_order_budget_and_first_timer(self):
        m = ready(self.model, window=4)
        for count in (2, 2): m.dispatch('choice.segment', dict(count=count), 21)
        self.assertEqual([r['emitted'][0]['fields']['payload'] for r in m.trace[-2:]], [[0, 128], [255, 7]])
        self.assertEqual((m.values['snd_nxt'], m.values['rtx_buf'], m.values['snd_buf']),
                         (1005, [0, 128, 255, 7], [17, 33, 65, 129]))
        self.assertEqual(m.timers, {'rtx': 1021})
        self.assertEqual([m.values[f'tx_time_{i:02}'] for i in range(4)], [21]*4)

    def test_invalid_or_exhausted_choices_are_uncovered_and_atomic(self):
        m = ready(self.model, window=2)
        for count in (-1, 0, 3, 5):
            before = m.snapshot()
            with self.assertRaises(Uncovered): m.dispatch('choice.segment', dict(count=count), 21)
            self.assertEqual(m.snapshot(), before)
        m.dispatch('choice.segment', dict(count=2), 21)
        with self.assertRaises(Uncovered): m.dispatch('choice.segment', dict(count=1), 21)

    def test_maximum_choice_matches_canonical_shared_state(self):
        parent = load(ROOT / 'model/tcp-limited-transmit.json')
        for window in (1, 2, 4, 8, 16):
            with self.subTest(window=window):
                a = ready(parent, window); b = ready(self.model, window)
                a.dispatch('app.transmit', time_ms=21)
                b.dispatch('choice.segment', dict(count=min(window, 4)), 21)
                self.assertEqual(a.values, {k: b.values[k] for k in a.values})
                self.assertEqual(a.timers, b.timers)
                self.assertEqual(a.trace[-1]['emitted'], b.trace[-1]['emitted'])

    def test_idle_guard_and_canonical_flush_remain_available(self):
        m = ready(self.model, data=[0, 128, 255, 7])
        m.dispatch('app.transmit', time_ms=21)
        m.dispatch('net.ack', dict(seq=9001, ack=1005, window=16), 40)
        m.dispatch('app.send', dict(data=[1, 2, 3, 4, 5]), 1100)
        m.dispatch('choice.segment', dict(count=3), 1101)
        self.assertTrue(m.values['idle_restart'])
        self.assertEqual((m.values['cc_cwnd'], m.values['choice_limit']), (4, 4))
        with self.assertRaises(Uncovered): m.dispatch('choice.segment', dict(count=2), 1101)
        m.dispatch('choice.segment', dict(count=1), 1101)
        m.dispatch('app.transmit', time_ms=1101)
        self.assertFalse(m.values['choice_used'])
        self.assertEqual(m.trace[-1]['emitted'], [])

    def test_wrap_and_half_close_reuse_parent_data_actions(self):
        m = ready(self.model, initial=dict(iss=MOD-3))
        m.dispatch('choice.segment', dict(count=3), 21)
        m.dispatch('choice.segment', dict(count=1), 22)
        self.assertEqual(m.values['snd_nxt'], 2)
        n = ready(self.model)
        n.dispatch('net.fin_segment', dict(seq=9001, ack=1001, window=16, data=[]), 21)
        n.dispatch('choice.segment', dict(count=2), 22)
        self.assertEqual(n.state, 'CLOSE-WAIT')
        self.assertEqual(n.trace[-1]['emitted'][0]['fields']['ack'], 9002)

    def test_coherent_take_count_fault_rejected(self):
        bad = copy.deepcopy(self.model)
        for t in bad['transitions']:
            if t['event'] == 'choice.segment':
                for a in t['actions']:
                    if 'set' in a and a['set']['var'] == 'take': a['set']['value'] = 4
        with self.assertRaisesRegex(ModelError, 'CHOICE-INV-ADMISSIBLE'):
            ready(bad).dispatch('choice.segment', dict(count=2), 21)

    def test_legacy_fixed_inputs_keep_their_canonical_behavior(self):
        for folder in ('congestion', 'fast-recovery', 'idle-restart', 'limited-transmit'):
            for p in sorted((ROOT / 'scenarios' / folder).glob('*.json')):
                with self.subTest(scene=p.stem): run_scenario(self.model, read(p))

    def test_full_byte_contracts_source_lock_and_generator(self):
        for source in read(ROOT / 'spec/sources/tcp-segment-choice.json'):
            self.assertEqual(digest(ROOT / 'spec/sources' / f"rfc{source['rfc']}.txt"), source['sha256'])
        raw = (ROOT / 'model/tcp-segment-choice.json').read_bytes()
        subprocess.run([sys.executable, str(ROOT / 'tools/build_segment_choice_model.py')], check=True)
        self.assertEqual(raw, (ROOT / 'model/tcp-segment-choice.json').read_bytes())
        paths = sorted((ROOT / 'scenarios/segment-choice').glob('*.json'))
        self.assertEqual(len(paths), 3)
        for path in paths:
            with self.subTest(scene=path.stem), tempfile.TemporaryDirectory() as temp:
                m = run_scenario(self.model, read(path))
                self.assertEqual(crosscheck_trace(self.model, m.trace, Path(temp))['status'], 'match')


if __name__ == '__main__': unittest.main(verbosity=2)
