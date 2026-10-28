"""Current RTO, cleanup and smaller-than-IW restart regression cases."""
import unittest

from protocol_lab.flow import ROOT
from protocol_lab.ir import Machine, load


class IdleRestartEpochTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.model = load(ROOT / 'model/tcp-idle-restart.json')

    def test_current_learned_rto_controls_strict_boundary(self):
        for extra in (0, 1):
            with self.subTest(extra=extra):
                m = Machine(self.model)
                m.dispatch('app.connect')
                m.dispatch('net.synack', dict(seq=9000, ack=1001, window=16), 500)
                m.dispatch('app.send', dict(data=[0, 128, 255, 7]), 510)
                m.dispatch('app.transmit', time_ms=511)
                m.dispatch('net.ack', dict(seq=9001, ack=1005, window=16), 1200)
                self.assertEqual(m.values['rto_ms'], 1463)
                t = 511 + m.values['rto_ms'] + extra
                m.dispatch('app.send', dict(data=[1, 2, 3, 4]), t)
                m.dispatch('app.transmit', time_ms=t)
                self.assertEqual(m.values['idle_restart'], bool(extra))
                self.assertEqual(m.values['cc_cwnd'], 4 if extra else 8)

    def test_restart_never_increases_window_below_configured_iw(self):
        m = Machine(self.model, dict(cc_initial_window=16))
        m.dispatch('app.connect'); m.dispatch('net.synack', dict(seq=9000, ack=1001, window=16), 10)
        m.dispatch('app.send', dict(data=[0, 1, 2, 3]), 20)
        m.dispatch('app.transmit', time_ms=21)
        m.tick(1021)
        m.dispatch('net.ack', dict(seq=9001, ack=1005, window=16), 1040)
        self.assertEqual(m.values['cc_cwnd'], 8)
        time = 1021 + m.values['rto_ms'] + 1
        m.dispatch('app.send', dict(data=[4, 5, 6, 7]), time)
        m.dispatch('app.transmit', time_ms=time)
        self.assertTrue(m.values['idle_restart'])
        self.assertEqual(m.values['cc_cwnd'], 8)

    def test_reset_and_reconnect_clear_prior_data_history(self):
        m = Machine(self.model)
        m.dispatch('app.connect'); m.dispatch('net.synack', dict(seq=9000, ack=1001, window=16), 10)
        m.dispatch('app.send', dict(data=[0, 1, 2, 3]), 20)
        m.dispatch('app.transmit', time_ms=21)
        m.dispatch('net.rst', dict(seq=9001), 30)
        self.assertEqual(m.state, 'CLOSED')
        self.assertFalse(m.values['idle_data_valid'])
        m.dispatch('app.connect', time_ms=1100)
        m.dispatch('net.synack', dict(seq=9000, ack=1001, window=16), 1110)
        m.dispatch('app.send', dict(data=[128, 255]), 1120)
        m.dispatch('app.transmit', time_ms=1121)
        self.assertFalse(m.values['idle_restart'])
        self.assertEqual(m.values['idle_last_data_ms'], 1121)


if __name__ == '__main__':
    unittest.main(verbosity=2)
