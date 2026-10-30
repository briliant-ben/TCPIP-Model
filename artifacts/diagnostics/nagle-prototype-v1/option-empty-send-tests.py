"""Basic coalescing across explicit choices, ACKs and automatic LT."""
import copy
from pathlib import Path
import tempfile
import unittest

from protocol_lab.capture import normalize
from protocol_lab.flow import ROOT, read, digest
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets
from protocol_lab.symbolic import crosscheck_trace
from tools.replay_schedule import replay_inputs


def connected(model, window=16, initial=None):
    m = Machine(model, initial or {})
    m.dispatch('app.connect')
    m.dispatch('net.synack', dict(seq=9000, ack=m.values['snd_nxt'], window=window), 10)
    return m


def send(m, data, at=20, count=2):
    m.dispatch('app.send', {'data': data}, at)
    m.dispatch('app.transmit', time_ms=at + 1)
    m.dispatch('choice.segment', {'count': count}, at + 1)


def ack(m, n, at=30, window=16):
    m.dispatch('net.ack', dict(seq=9001, ack=n, window=window), at)


class NagleTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.model = load(ROOT / 'model/tcp-nagle.json')

    def test_partial_ack_keeps_short_segment_buffered_then_full_ack_unblocks(self):
        m = connected(self.model)
        send(m, [0, 128, 255, 7])
        before = m.snapshot()
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 2}, 21)
        self.assertEqual(m.snapshot(), before)
        ack(m, 1002)
        self.assertEqual(m.values['rtx_buf'], [128])
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 2}, 30)
        self.assertEqual(m.values['snd_buf'], [255, 7])
        ack(m, 1003, 40)
        m.dispatch('choice.segment', {'count': 2}, 40)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'], [255, 7])
        self.assertEqual(m.values['cb_acked_total'], 2)

    def test_automatic_lt_cannot_bypass_nagle_but_full_mss_still_sends(self):
        short = connected(self.model)
        send(short, [0, 128, 255, 7])
        timers = dict(short.timers)
        ack(short, 1001)
        self.assertFalse(short.values['lt_emitted'])
        self.assertEqual(short.values['fr_dupacks'], 1)
        self.assertEqual(short.values['snd_buf'], [255, 7])
        self.assertEqual(short.timers, timers)
        full = connected(self.model)
        send(full, [0, 128, 255, 7, 17, 33], count=2)
        ack(full, 1001)
        self.assertTrue(full.values['lt_emitted'])
        self.assertEqual(full.values['lt_take'], 4)
        self.assertEqual(full.trace[-1]['emitted'][0]['fields']['payload'], [255, 7, 17, 33])
        self.assertEqual(full.values['cc_cwnd'], 4)

    def test_nodelay_option_preserves_bytes_credit_and_requires_new_opportunity(self):
        m = connected(self.model)
        send(m, [0, 128, 255, 7])
        selected = ['snd_buf', 'rtx_buf', 'cb_emitted_total', 'cb_acked_total', 'svc_written_bytes']
        before = {n: copy.deepcopy(m.values[n]) for n in selected}
        timers = dict(m.timers)
        m.dispatch('app.nodelay', {'enabled': True}, 22)
        self.assertEqual({n: m.values[n] for n in selected}, before)
        self.assertEqual(m.timers, timers)
        self.assertFalse(m.trace[-1]['emitted'])
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 2}, 22)
        m.dispatch('app.transmit', time_ms=23)
        m.dispatch('choice.segment', {'count': 2}, 23)
        self.assertEqual(m.values['rtx_buf'], [0, 128, 255, 7])
        m.dispatch('net.rst', {'seq': 9001}, 24)
        m.dispatch('app.connect', time_ms=25)
        self.assertFalse(m.values['nagle_disabled'])

    def test_full_segment_remains_subject_to_receiver_and_congestion_budgets(self):
        m = connected(self.model, window=4)
        send(m, list(range(8)))
        with self.assertRaises(ModelError): m.dispatch('choice.segment', {'count': 4}, 21)
        ack(m, 1001, window=4)
        self.assertFalse(m.values['lt_emitted'])
        self.assertEqual(m.values['rtx_buf'], [0, 1])

    def test_short_retransmission_is_not_blocked_and_does_not_recredit(self):
        m = connected(self.model)
        send(m, [128, 255], count=2)
        m.tick(1021)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'], [128, 255])
        self.assertEqual((m.values['cb_count'], m.values['cb_emitted_total']), (1, 2))

    def test_lt_gate_fault_is_caught_by_declared_nagle_invariant(self):
        bad = copy.deepcopy(self.model)
        for rule in bad['transitions']:
            for action in rule['actions']:
                if 'set' in action and action['set']['var'] == 'lt_eligible' and action['set']['value'] is not False:
                    action['set']['value'] = action['set']['value']['args'][0]
        m = connected(bad)
        send(m, [0, 128, 255, 7])
        with self.assertRaisesRegex(ModelError, 'NAGLE-INV-NEW-DATA'): ack(m, 1001)

    def test_source_preserving_witness_matches_retained_duplicate_future_capture(self):
        source = read(ROOT / 'ports/lwip-service/scenarios/duplicate-future-no-credit.json')
        original = ROOT / 'artifacts/lwip-service/duplicate-future-no-credit'
        original_sha = digest(original / 'difference.json')
        witness = read(ROOT / 'artifacts/lwip-service/segmentation-witnesses/candidates/duplicate-future-no-credit.json')
        # Same original inputs; ACK1003 at40ms drains the original two-byte segment.
        decisions = witness['steps']
        position = next(i for i, row in enumerate(decisions) if row.get('source_step') == 6)
        decisions.insert(position + 1, dict(at_ms=40, event='choice.segment', fields={'count': 2}))
        m, audit, canonical = replay_inputs(self.model, source, witness)
        self.assertEqual(canonical['status'], 'match')
        self.assertEqual([r['source_step'] for r in audit if r['kind'] == 'source'], list(range(len(source['steps']))))
        expected = control_packets(m, source)
        actual, _ = normalize(original / 'capture.pcap', read(ROOT / 'packet-profile.json'), expected,
            origin='external_capture', checksum_policy='strict', projection='tcp-connection-v1')
        self.assertEqual(compare(expected, actual, tolerance_ms=0, projection='tcp-connection-v1')['status'], 'match')
        callbacks = [{'time_ms': r['time_ms'], 'bytes': r['after']['variables']['cb_step_bytes']}
                     for r in m.trace if r['after']['variables']['cb_step_bytes']]
        self.assertEqual(callbacks, read(original / 'report.json')['summary']['sent_events'])
        self.assertEqual(original_sha, digest(original / 'difference.json'))
        with tempfile.TemporaryDirectory() as tmp:
            self.assertEqual(crosscheck_trace(self.model, m.trace, Path(tmp))['status'], 'match')


if __name__ == '__main__':
    unittest.main()
