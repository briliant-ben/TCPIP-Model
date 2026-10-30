"""Finite sender coalescing, history, push prefixes and timer composition."""
import copy
from pathlib import Path
import tempfile
import unittest
from protocol_lab.flow import ROOT
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.symbolic import crosscheck_trace


def ready(model, window=16, initial=None):
    m = Machine(model, initial or {})
    m.dispatch('app.connect')
    m.dispatch('net.synack', dict(seq=9000, ack=m.values['snd_nxt'], window=window), 10)
    return m


def queue(m, data, at=20):
    m.dispatch('app.send', {'data': data}, at)
    m.dispatch('app.transmit', time_ms=at + 1)


def ack(m, n=1001, window=16, at=30):
    m.dispatch('net.ack', dict(seq=m.values['rcv_nxt'], ack=n, window=window), at)


class SWSTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls): cls.model = load(ROOT / 'model/tcp-sws.json')

    def test_tiny_segment_waits_to_exact_override_and_preserves_full_bytes(self):
        m = ready(self.model)
        queue(m, [255])
        self.assertEqual(m.timers, {'sws': 221})
        before = m.snapshot()
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 1}, 21)
        self.assertEqual(m.snapshot(), before)
        m.tick(220); self.assertFalse(m.values['sws_override_ready'])
        m.tick(221); self.assertTrue(m.values['sws_override_ready'])
        m.dispatch('choice.segment', {'count': 1}, 221)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'], [255])
        self.assertEqual(m.timers, {'rtx': 1221})
        ack(m, 1002, at=230)
        self.assertEqual(m.values['cb_acked_total'], 1)
        with tempfile.TemporaryDirectory() as tmp:
            self.assertEqual(crosscheck_trace(self.model, m.trace, Path(tmp))['status'], 'match')

    def test_half_window_threshold_is_ceiling_and_full_mss_always_qualifies(self):
        m = ready(self.model, window=5); queue(m, [0, 128, 255])
        m.dispatch('choice.segment', {'count': 3}, 21)
        self.assertEqual(m.values['sws_decision_maximum'], 5)
        self.assertEqual(m.values['sws_sent_count'], 3)
        m = ready(self.model, window=7); queue(m, [0, 128, 255, 7])
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 3}, 21)
        m.dispatch('choice.segment', {'count': 4}, 21)
        self.assertEqual(m.values['sws_sent_count'], 4)

    def test_window_shrink_and_future_ack_do_not_erase_or_inflate_maximum(self):
        m = ready(self.model, window=4)
        ack(m, window=1, at=15)
        self.assertEqual((m.values['snd_wnd'], m.values['sws_max_window']), (1, 4))
        ack(m, n=1009, window=16, at=16)
        self.assertEqual((m.values['snd_wnd'], m.values['sws_max_window']), (1, 4))
        queue(m, [128])
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 1}, 21)
        m.tick(221); m.dispatch('choice.segment', {'count': 1}, 221)
        self.assertEqual(m.values['sws_decision_maximum'], 4)

    def test_push_marks_only_current_prefix_not_later_writes(self):
        m = ready(self.model)
        m.dispatch('app.send', {'data': [0, 128]}, 20)
        m.dispatch('app.push', time_ms=21)
        self.assertEqual(m.values['sws_push_bytes'], 2)
        m.dispatch('app.send', {'data': [255]}, 22)
        m.dispatch('app.transmit', time_ms=23)
        self.assertEqual(m.values['sws_push_bytes'], 2)
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 3}, 23)
        m.dispatch('app.push', time_ms=24)
        m.dispatch('choice.segment', {'count': 3}, 24)
        self.assertEqual(m.values['sws_push_bytes'], 0)

    def test_nodelay_does_not_disable_sws_and_timeout_does_not_disable_nagle(self):
        m = ready(self.model)
        m.dispatch('app.nodelay', {'enabled': True}, 15)
        queue(m, [17])
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 1}, 21)
        m.tick(221); m.dispatch('choice.segment', {'count': 1}, 221)
        # The first byte remains in flight; re-enabling Nagle blocks a new short send even at override.
        m.dispatch('app.nodelay', {'enabled': False}, 222)
        queue(m, [33], at=223)
        m.tick(424)
        self.assertTrue(m.values['sws_override_ready'])
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 1}, 424)

    def test_more_writes_and_requests_do_not_postpone_first_epoch(self):
        m = ready(self.model)
        m.dispatch('app.nodelay', {'enabled': True}, 15)
        queue(m, [0])
        m.dispatch('app.transmit', time_ms=50)
        m.dispatch('app.send', {'data': [128]}, 80)
        m.dispatch('app.transmit', time_ms=90)
        self.assertEqual(m.timers['sws'], 221)
        m.tick(221); m.dispatch('choice.segment', {'count': 1}, 221)
        self.assertEqual(m.timers, {'rtx': 1221, 'sws': 421})
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 1}, 221)
        m.tick(421); m.dispatch('choice.segment', {'count': 1}, 421)
        self.assertEqual(m.timers, {'rtx': 1221})

    def test_zero_window_blocks_expired_override_until_accepted_update(self):
        m = ready(self.model)
        ack(m, window=0, at=15)
        queue(m, [7])
        m.tick(221)
        self.assertTrue(m.values['sws_override_ready'])
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 1}, 221)
        ack(m, window=1, at=230)
        m.dispatch('choice.segment', {'count': 1}, 230)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'], [7])

    def test_reset_and_new_connection_clear_epoch_and_maximum(self):
        m = ready(self.model); queue(m, [255])
        m.dispatch('net.rst', {'seq': 9001}, 50)
        self.assertFalse(m.values['sws_active']); self.assertEqual(m.values['sws_max_window'], 0)
        self.assertNotIn('sws', m.timers)
        m.dispatch('app.connect', time_ms=60)
        m.dispatch('net.synack', dict(seq=9000, ack=1001, window=4), 70)
        self.assertEqual(m.values['sws_max_window'], 4)
        queue(m, [128], at=80)
        self.assertEqual(m.timers['sws'], 281)

    def test_half_close_marks_pending_prefix_and_fin_wraps_without_timer_leak(self):
        m = ready(self.model, initial={'iss': 2**32 - 3})
        queue(m, [0, 128])
        m.dispatch('net.fin', dict(seq=9001, ack=2**32 - 2), 30)
        self.assertEqual(m.state, 'CLOSE-WAIT')
        self.assertEqual(m.timers['sws'], 221)
        m.dispatch('app.close', time_ms=40)
        m.dispatch('app.transmit', time_ms=41)
        m.dispatch('choice.segment', {'count': 2}, 41)
        self.assertEqual(m.state, 'CLOSE-WAIT')
        self.assertNotIn('sws', m.timers)
        m.dispatch('net.ack', dict(seq=9002, ack=0, window=16), 50)
        self.assertEqual(m.state, 'LAST-ACK')
        m.dispatch('net.ack', dict(seq=9002, ack=1, window=16), 60)
        self.assertEqual(m.state, 'CLOSED')
        self.assertEqual(m.values['cb_acked_total'], 2)

    def test_bypassed_choice_gate_is_detected_by_declared_reason_invariant(self):
        bad = copy.deepcopy(self.model)
        for rule in bad['transitions']:
            if rule['event'] == 'choice.segment': rule['guard'] = rule['guard']['args'][0]
        m = ready(bad); queue(m, [255])
        before = m.snapshot()
        with self.assertRaisesRegex(ModelError, 'SWS-INV'): m.dispatch('choice.segment', {'count': 1}, 21)
        self.assertEqual(m.snapshot(), before)

    def test_early_and_late_actual_timer_arm_are_rejected_not_relabelled(self):
        for adjustment in [-1, 1]:
            with self.subTest(adjustment=adjustment):
                bad = copy.deepcopy(self.model)
                for rule in bad['transitions']:
                    for action in rule['actions']:
                        if 'arm_if' in action and action['arm_if']['timer'] == 'sws':
                            action['arm_if']['delay_ms'] = {'op': 'add', 'args': [{'var': 'sws_override_ms'}, adjustment]}
                m = ready(bad); queue(m, [255])
                self.assertNotEqual(m.timers['sws'], 221)
                with self.assertRaises(ModelError): m.tick(221 + adjustment)

    def test_full_wire_window_domain_is_not_confused_with_queue_capacity(self):
        for window in [17, 65535]:
            m = ready(self.model, window=window)
            self.assertEqual(m.values['sws_max_window'], window)
            queue(m, [0, 128, 255, 7])
            m.dispatch('choice.segment', {'count': 4}, 21)
            self.assertEqual(m.values['sws_sent_count'], 4)

    def test_timer_configuration_boundaries_are_explicit(self):
        for value in [99, 1001]:
            with self.assertRaisesRegex(ModelError, 'SWS-INV'): Machine(self.model, {'sws_override_ms': value})
        for value in [100, 1000]:
            m = ready(self.model, initial={'sws_override_ms': value}); queue(m, [255])
            self.assertEqual(m.timers['sws'], 21 + value)


if __name__ == '__main__': unittest.main()
