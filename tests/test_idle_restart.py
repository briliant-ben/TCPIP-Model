"""Idle restart output clocks, boundaries, composition and fault controls."""
import copy
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario, digest
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.symbolic import crosscheck_trace


def established(model, data=True):
    m = Machine(model)
    m.dispatch('app.connect')
    m.dispatch('net.synack', dict(seq=9000, ack=1001, window=16), 10)
    if data:
        m.dispatch('app.send', dict(data=[0, 128, 255, 7]), 20)
        m.dispatch('app.transmit', time_ms=21)
    return m


def ack(m, time, number=1005, window=16):
    m.dispatch('net.ack', dict(seq=m.values['rcv_nxt'], ack=number, window=window), time)


class IdleRestartTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.model = load(ROOT / 'model/tcp-idle-restart.json')

    def ready(self, model=None):
        m = established(model or self.model)
        ack(m, 40)
        self.assertEqual((m.values['cc_cwnd'], m.values['idle_last_data_ms']), (8, 21))
        return m

    def test_strict_rto_boundary_and_effective_new_send_budget(self):
        for gap, restart, cwnd in [(999, False, 8), (1000, False, 8), (1001, True, 4)]:
            with self.subTest(gap=gap):
                m = self.ready()
                m.dispatch('app.send', dict(data=list(range(12))), 21 + gap)
                m.dispatch('app.transmit', time_ms=21 + gap)
                self.assertEqual((m.values['idle_restart'], m.values['cc_cwnd']), (restart, cwnd))
                self.assertEqual(m.values['cc_send_budget'], cwnd)
                m.dispatch('app.transmit', time_ms=21 + gap)
                self.assertEqual(len(m.values['rtx_buf']), cwnd)
                if restart: self.assertEqual(m.trace[-1]['emitted'], [])

    def test_request_and_delayed_ack_do_not_mask_idle_send_history(self):
        m = self.ready()
        m.dispatch('net.data', dict(seq=9001, ack=1005, window=16, data=[17]), 1050)
        self.assertTrue(m.values['ack_pending'])
        m.tick(1090)
        self.assertEqual(m.values['idle_last_data_ms'], 21)
        m.dispatch('app.send', dict(data=[33, 65, 129, 255]), 1100)
        m.dispatch('app.transmit', time_ms=1101)
        self.assertTrue(m.values['idle_restart'])
        self.assertEqual(m.values['idle_last_data_ms'], 1101)

    def test_app_queue_blocked_zero_window_and_clock_do_not_refresh(self):
        m = self.ready()
        ack(m, 50, window=0)
        m.dispatch('app.send', dict(data=[1, 2, 3, 4]), 1050)
        m.dispatch('app.transmit', time_ms=1051)
        self.assertTrue(m.values['idle_restart'])
        self.assertFalse(m.values['idle_data_emitted'])
        self.assertEqual((m.values['idle_last_data_ms'], m.values['cc_cwnd']), (21, 4))
        m.tick(1052)
        self.assertEqual(m.values['idle_last_data_ms'], 21)
        ack(m, 1060, window=16)
        m.dispatch('app.transmit', time_ms=1061)
        self.assertTrue(m.values['idle_restart'])
        self.assertEqual(m.values['idle_last_data_ms'], 1061)

    def test_first_data_pure_ack_and_fin_only_history(self):
        m = established(self.model, False)
        ack(m, 1100, 1001)
        self.assertFalse(m.values['idle_data_valid'])
        m.dispatch('app.send', dict(data=[0, 128, 255, 7]), 1110)
        m.dispatch('app.transmit', time_ms=1111)
        self.assertFalse(m.values['idle_restart'])
        ack(m, 1120)
        m.dispatch('app.close', time_ms=1130)
        self.assertEqual(m.values['idle_last_data_ms'], 1111)
        self.assertFalse(m.values['idle_data_emitted'])

    def test_fast_retransmission_refreshes_actual_send_epoch(self):
        m = established(self.model)
        for t in (30, 31, 32): ack(m, t, 1001)
        self.assertTrue(m.values['fr_retransmitted'])
        self.assertEqual(m.values['idle_last_data_ms'], 32)
        ack(m, 40)
        m.dispatch('app.send', dict(data=[8, 9, 10, 11]), 1032)
        m.dispatch('app.transmit', time_ms=1032)
        self.assertFalse(m.values['idle_restart'])
        self.assertEqual(m.values['cc_cwnd'], 8)

    def test_actual_timeout_and_persist_probe_refresh_send_epoch(self):
        m = established(self.model)
        m.tick(1021)
        self.assertTrue(m.values['tx_retransmitted'])
        self.assertEqual(m.values['idle_last_data_ms'], 1021)
        z = established(self.model, False)
        ack(z, 15, 1001, window=0)
        z.dispatch('app.send', dict(data=[128, 255]), 20)
        self.assertFalse(z.values['idle_data_valid'])
        z.tick(1020)
        self.assertTrue(z.values['idle_data_emitted'])
        self.assertEqual(z.values['idle_last_data_ms'], 1020)

    def test_ca_credit_is_cleared_threshold_preserved_and_window_never_increased(self):
        m = self.ready()
        threshold = m.values['cc_ssthresh']
        # A valid independent initial threshold yields a real CA credit state.
        n = Machine(self.model, dict(cc_initial_threshold=8))
        n.dispatch('app.connect'); n.dispatch('net.synack', dict(seq=9000, ack=1001, window=16), 10)
        for t, seq in [(20, 1005), (30, 1009)]:
            n.dispatch('app.send', dict(data=[0, 1, 2, 3]), t)
            n.dispatch('app.transmit', time_ms=t + 1)
            ack(n, t + 2, seq)
        self.assertEqual(n.values['cc_ca_credit'], 4)
        n.dispatch('app.send', dict(data=[4, 5, 6, 7]), 1100)
        n.dispatch('app.transmit', time_ms=1101)
        self.assertEqual((n.values['cc_cwnd'], n.values['cc_ca_credit'], n.values['cc_ssthresh']), (4, 0, 8))
        m.dispatch('app.send', dict(data=[1]), 1100); m.dispatch('app.transmit', time_ms=1101)
        self.assertEqual(m.values['cc_ssthresh'], threshold)

    def test_coherent_missing_restart_fault_rejected(self):
        mutant = copy.deepcopy(self.model)
        for t in mutant['transitions']:
            if t['event'] == 'app.transmit':
                for a in t['actions']:
                    if 'set' in a and a['set']['var'] == 'cc_cwnd':
                        a['set']['value'] = {'var': 'cc_cwnd'}
                        break
        m = self.ready(mutant)
        m.dispatch('app.send', dict(data=list(range(12))), 1100)
        with self.assertRaisesRegex(ModelError, 'IDLE-INV-RESTART'):
            m.dispatch('app.transmit', time_ms=1101)

    def test_parent_fixed_inputs_remain_reference_compatible(self):
        for folder in ('congestion', 'fast-recovery'):
            for path in sorted((ROOT / 'scenarios' / folder).glob('*.json')):
                with self.subTest(path=path.stem): run_scenario(self.model, read(path))

    def test_source_lock_generator_and_full_byte_fixed_inputs(self):
        for item in read(ROOT / 'spec/sources/tcp-idle-restart.json'):
            self.assertEqual(digest(ROOT / 'spec/sources' / f"rfc{item['rfc']}.txt"), item['sha256'])
        before = (ROOT / 'model/tcp-idle-restart.json').read_bytes()
        subprocess.run([sys.executable, str(ROOT / 'tools/build_idle_restart_model.py')], check=True)
        self.assertEqual(before, (ROOT / 'model/tcp-idle-restart.json').read_bytes())
        for scene in sorted((ROOT / 'scenarios/idle-restart').glob('*.json')):
            with self.subTest(scene=scene.stem), tempfile.TemporaryDirectory() as temp:
                m = run_scenario(self.model, read(scene))
                self.assertEqual(crosscheck_trace(self.model, m.trace, Path(temp))['status'], 'match')


if __name__ == '__main__':
    unittest.main(verbosity=2)
