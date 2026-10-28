"""Finite duplicate-clocked sends, excluded loss basis and negative controls."""
import copy
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario, digest
from protocol_lab.ir import MOD, Machine, ModelError, load
from protocol_lab.symbolic import crosscheck_trace


def setup(model, data=None, window=16, initial=None):
    m = Machine(model, initial)
    m.dispatch('app.connect')
    m.dispatch('net.synack', dict(seq=9000, ack=m.values['snd_nxt'], window=window), 10)
    m.dispatch('app.send', dict(data=list(range(16)) if data is None else data), 20)
    m.dispatch('app.transmit', time_ms=21)
    return m


def ack(m, t, n=None, window=16, seq=None):
    m.dispatch('net.ack', dict(seq=m.values['rcv_nxt'] if seq is None else seq,
        ack=m.values['snd_una'] if n is None else n, window=window), t)


def output(m):
    return [a for a in m.trace[-1]['emitted'] if a['message'] == 'tcp_data']


class LimitedTransmitTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls): cls.model = load(ROOT / 'model/tcp-limited-transmit.json')

    def test_two_automatic_new_segments_preserve_cwnd_rto_and_exact_bytes(self):
        m = setup(self.model); timers = dict(m.timers)
        for t, start, total in [(30, 4, 4), (31, 8, 8)]:
            ack(m, t)
            self.assertEqual(output(m)[0]['fields']['payload'], list(range(start, start + 4)))
            self.assertEqual(output(m)[0]['fields']['seq'], 1001 + start)
            self.assertEqual((m.values['cc_cwnd'], m.values['lt_epoch_bytes']), (4, total))
            self.assertEqual(m.timers, timers)
            self.assertEqual(m.values['idle_last_data_ms'], t)
        self.assertEqual(len(m.values['rtx_buf']), 12)
        self.assertEqual([m.values[f'tx_time_{i:02}'] for i in range(12)], [21]*4 + [30]*4 + [31]*4)
        m.dispatch('app.transmit', time_ms=31)
        self.assertEqual(output(m), [])  # LT permission is not an app budget.

    def test_third_duplicate_excludes_actual_lt_bytes_before_fast_send(self):
        m = setup(self.model)
        for t in (30, 31, 32): ack(m, t)
        self.assertEqual((m.values['lt_before_bytes'], m.values['fr_before_flight'], m.values['lt_loss_flight']), (8, 12, 4))
        self.assertEqual((m.values['cc_cwnd'], m.values['cc_ssthresh']), (20, 8))
        self.assertEqual(output(m)[0]['fields']['payload'], [0, 1, 2, 3])
        self.assertEqual((m.values['lt_epoch_bytes'], m.values['lt_epoch_packets']), (0, 0))
        self.assertTrue(m.values['rtt_ambiguous'])
        ack(m, 33); self.assertEqual(output(m), [])
        self.assertEqual(m.values['cc_cwnd'], 24)

    def test_receiver_window_allows_only_one_byte_and_no_second_send(self):
        m = setup(self.model, window=5)
        ack(m, 30, window=5)
        self.assertEqual(output(m)[0]['fields']['payload'], [4])
        self.assertEqual(m.values['lt_take'], 1)
        ack(m, 31, window=5); self.assertEqual(output(m), [])
        ack(m, 32, window=5)
        self.assertEqual((m.values['lt_before_bytes'], m.values['lt_loss_flight']), (1, 4))

    def test_empty_first_duplicate_and_late_queue_only_send_on_second(self):
        m = setup(self.model, data=[0, 128, 255, 7])
        ack(m, 30); self.assertEqual(output(m), [])
        m.dispatch('app.send', dict(data=[17, 33, 65, 129, 1, 2, 3, 4]), 30)
        ack(m, 31)
        self.assertEqual(output(m)[0]['fields']['payload'], [17, 33, 65, 129])
        self.assertEqual(m.values['lt_epoch_bytes'], 4)
        ack(m, 32)
        self.assertEqual((m.values['lt_before_bytes'], m.values['lt_loss_flight']), (4, 4))

    def test_window_update_future_invalid_seq_and_payload_are_not_lt(self):
        m = setup(self.model)
        ack(m, 24, window=8); self.assertFalse(m.values['lt_emitted'])
        ack(m, 25, n=1020); self.assertFalse(m.values['lt_emitted'])
        ack(m, 26, seq=9030); self.assertFalse(m.values['lt_emitted'])
        m.dispatch('net.data', dict(seq=9001, ack=1001, window=16, data=[128]), 27)
        self.assertFalse(m.values['lt_emitted'])
        # Payload updated last wire window, but did not increment duplicates.
        self.assertEqual(m.values['fr_dupacks'], 0)
        ack(m, 30)
        self.assertTrue(m.values['lt_emitted'])
        self.assertEqual(output(m)[0]['fields']['ack'], 9002)
        self.assertFalse(m.values['ack_pending']); self.assertNotIn('delack', m.timers)

    def test_partial_ack_resets_epoch_then_new_duplicate_cycle(self):
        m = setup(self.model)
        ack(m, 30); ack(m, 31)
        ack(m, 35, n=1003)
        self.assertEqual((m.values['lt_epoch_bytes'], m.values['fr_dupacks']), (0, 0))
        ack(m, 36)
        self.assertTrue(m.values['lt_emitted'])
        self.assertEqual(m.values['lt_epoch_bytes'], 4)
        ack(m, 37); ack(m, 38)
        self.assertEqual(m.values['lt_loss_flight'], 10)
        self.assertEqual(output(m)[0]['fields']['seq'], 1003)

    def test_timeout_uses_shared_byte_age_and_clears_lt_epoch(self):
        m = setup(self.model); ack(m, 30); ack(m, 31)
        m.tick(1021)
        self.assertTrue(m.values['cc_loss'])
        self.assertEqual((m.values['lt_epoch_bytes'], m.values['fr_dupacks'], m.values['cc_cwnd']), (0, 0, 4))
        self.assertEqual(output(m)[0]['fields']['payload'], [0, 1, 2, 3])
        self.assertEqual(m.values['idle_last_data_ms'], 1021)

    def test_fin_sent_blocks_lt_but_pending_close_can_drain_new_data(self):
        m = setup(self.model, data=[0, 1, 2, 3]); m.dispatch('app.close', time_ms=25)
        self.assertTrue(m.values['fin_sent'])
        ack(m, 30); self.assertFalse(m.values['lt_emitted'])
        n = setup(self.model); n.dispatch('app.close', time_ms=25)
        self.assertFalse(n.values['fin_sent'])
        ack(n, 30); self.assertTrue(n.values['lt_emitted']); self.assertFalse(n.values['fin_sent'])

    def test_sequence_wrap_and_data_order(self):
        m = setup(self.model, initial=dict(iss=MOD - 3))
        ack(m, 30); ack(m, 31)
        self.assertEqual(m.values['snd_nxt'], 10)
        self.assertEqual(output(m)[0]['fields']['seq'], 6)
        ack(m, 32)
        self.assertEqual(output(m)[0]['fields']['seq'], MOD - 2)

    def test_excluded_basis_fault_detected_even_when_threshold_clamps_same(self):
        bad = copy.deepcopy(self.model)
        for t in bad['transitions']:
            for a in t['actions']:
                if 'set' in a and a['set']['var'] == 'lt_loss_flight':
                    a['set']['value'] = {'op': 'bytes_len', 'args': [{'var': 'rtx_buf'}]}
        m = setup(bad); ack(m, 30); ack(m, 31)
        with self.assertRaisesRegex(ModelError, 'LT-INV-THRESHOLD-BASIS'): ack(m, 32)

    def test_inflating_cwnd_for_lt_is_rejected(self):
        bad = copy.deepcopy(self.model)
        for t in bad['transitions']:
            if t['event'] == 'net.ack':
                t['actions'].append({'set': {'var': 'cc_cwnd', 'value': {'op': 'add', 'args': [
                    {'var': 'cc_cwnd'}, {'var': 'lt_take'}]}}})
        with self.assertRaisesRegex(ModelError, 'LT-INV-SEND'): ack(setup(bad), 30)

    def test_epoch_invariant_rejects_more_sends_than_duplicate_opportunities(self):
        # This is an invalid invariant-state assignment, not a reachable trace.
        # The archived induction witness showed why these relations are needed.
        with self.assertRaisesRegex(ModelError, 'LT-INV-EPOCH'):
            Machine(self.model, dict(fr_dupacks=1, lt_epoch_packets=2))

    def test_source_lock_idempotent_generator_and_fixed_byte_contracts(self):
        for item in read(ROOT / 'spec/sources/tcp-limited-transmit.json'):
            self.assertEqual(digest(ROOT / 'spec/sources' / f"rfc{item['rfc']}.txt"), item['sha256'])
        before = (ROOT / 'model/tcp-limited-transmit.json').read_bytes()
        subprocess.run([sys.executable, str(ROOT / 'tools/build_limited_transmit_model.py')], check=True)
        self.assertEqual(before, (ROOT / 'model/tcp-limited-transmit.json').read_bytes())
        paths = sorted((ROOT / 'scenarios/limited-transmit').glob('*.json'))
        self.assertEqual(len(paths), 4)
        for path in paths:
            with self.subTest(path=path.stem), tempfile.TemporaryDirectory() as tmp:
                m = run_scenario(self.model, read(path))
                self.assertEqual(crosscheck_trace(self.model, m.trace, Path(tmp))['status'], 'match')


if __name__ == '__main__': unittest.main(verbosity=2)
