"""Explicit opportunity causality and exact ordered source-step consumption."""
import copy
import importlib.util
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario, digest
from protocol_lab.ir import Machine, ModelError, Uncovered, load
from protocol_lab.symbolic import crosscheck_trace

spec = importlib.util.spec_from_file_location('test_schedule_replay', ROOT / 'tools/replay_schedule.py')
replayer = importlib.util.module_from_spec(spec); spec.loader.exec_module(replayer)


def initial(model):
    m = Machine(model); m.dispatch('app.connect')
    m.dispatch('net.synack', dict(seq=9000, ack=1001, window=4), 10)
    m.dispatch('app.send', dict(data=[0, 128, 255, 7, 17, 33, 65, 129]), 20)
    return m


def witness():
    decisions = []
    for i in range(7):
        decisions.append(dict(source_step=i))
        if i in (3, 4):
            decisions += [dict(at_ms=21 if i == 3 else 30, event='choice.segment', fields=dict(count=2)) for _ in range(2)]
    return dict(witness_version='0.1', steps=decisions)


class OutputScheduleTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.model = load(ROOT / 'model/tcp-output-schedule.json')
        cls.source = read(ROOT / 'ports/lwip-stream/scenarios/four-byte-peer-window.json')

    def test_flush_creates_opportunity_without_bytes_or_empty_timer(self):
        m = initial(self.model)
        with self.assertRaises(Uncovered): m.dispatch('choice.segment', dict(count=2), 21)
        m.dispatch('app.transmit', time_ms=21)
        self.assertEqual((m.values['snd_nxt'], m.values['rtx_buf'], m.timers, m.trace[-1]['emitted']), (1001, [], {}, []))
        m.dispatch('choice.segment', dict(count=2), 21)
        self.assertEqual((m.values['snd_nxt'], m.values['sched_bytes'], m.values['sched_packets']), (1003, 2, 1))
        self.assertEqual(m.timers, {'rtx': 1021})

    def test_late_choice_and_intervening_application_event_close_opportunity(self):
        m = initial(self.model); m.dispatch('app.transmit', time_ms=21)
        with self.assertRaises(Uncovered): m.dispatch('choice.segment', dict(count=2), 22)
        m.dispatch('app.send', dict(data=[1]), 21)
        with self.assertRaises(Uncovered): m.dispatch('choice.segment', dict(count=1), 21)

    def test_valid_ack_grants_but_future_ack_does_not(self):
        m = initial(self.model); m.dispatch('app.transmit', time_ms=21)
        for _ in range(2): m.dispatch('choice.segment', dict(count=2), 21)
        m.dispatch('net.ack', dict(seq=9001, ack=2000, window=4), 25)
        self.assertFalse(m.values['sched_open'])
        with self.assertRaises(Uncovered): m.dispatch('choice.segment', dict(count=2), 25)
        m.dispatch('net.ack', dict(seq=9001, ack=1005, window=4), 30)
        self.assertEqual(m.values['sched_cause'], 2)
        m.dispatch('choice.segment', dict(count=2), 30)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['seq'], 1005)

    def test_exact_full_source_replay_and_unchanged_final_contract(self):
        before = copy.deepcopy(self.source)
        m, audit = replayer.replay_schedule(self.model, self.source, witness())
        self.assertEqual([row['source_step'] for row in audit if row['kind'] == 'source'], list(range(7)))
        self.assertEqual(sum(row['kind'] == 'choice' for row in audit), 4)
        self.assertEqual((m.values['snd_una'], m.values['snd_nxt'], m.timers), (1009, 1009, {}))
        self.assertEqual(self.source, before)

    def test_missing_duplicate_reordered_or_forged_source_steps_rejected(self):
        cases = []
        a = witness(); a['steps'].pop(); cases.append(a)
        a = witness(); a['steps'].insert(1, dict(source_step=0)); cases.append(a)
        a = witness(); a['steps'][0] = dict(source_step=1); cases.append(a)
        a = witness(); a['steps'].insert(0, dict(at_ms=0, event='net.ack', fields=dict(seq=9001, ack=1005, window=4))); cases.append(a)
        a = witness(); a['steps'][3]['fields'] = {}; cases.append(a)
        for candidate in cases:
            with self.subTest(candidate=candidate), self.assertRaises(ValueError):
                replayer.replay_schedule(self.model, self.source, candidate)

    def test_omitted_output_choices_do_not_satisfy_final_source_contract(self):
        candidate = dict(witness_version='0.1', steps=[dict(source_step=i) for i in range(7)])
        with self.assertRaisesRegex(ModelError, 'Witness final'):
            replayer.replay_schedule(self.model, self.source, candidate)

    def test_observation_replay_retains_canonical_final_mismatch(self):
        candidate = witness()
        choices = [i for i, x in enumerate(candidate['steps']) if x.get('event') == 'choice.segment']
        candidate['steps'].pop(choices[-1])
        m, audit, canonical = replayer.replay_inputs(self.model, self.source, candidate)
        self.assertEqual(canonical['status'], 'mismatch')
        self.assertEqual((m.values['svc_written_bytes'], m.values['svc_acked_bytes'], m.values['svc_abandoned_bytes']), (8, 4, 0))
        self.assertEqual((m.values['snd_una'], m.values['snd_nxt']), (1005, 1007))
        self.assertEqual(sum(x['kind'] == 'source' for x in audit), 7)
        with self.assertRaisesRegex(ModelError, 'Witness final canonical'):
            replayer.replay_schedule(self.model, self.source, candidate)

    def test_reset_abandons_pending_service_credit_without_faking_ack(self):
        m = initial(self.model); m.dispatch('app.transmit', time_ms=21)
        m.dispatch('choice.segment', dict(count=2), 21)
        m.dispatch('net.rst', dict(seq=9001), 22)
        self.assertEqual((m.values['svc_written_bytes'], m.values['svc_acked_bytes'], m.values['svc_abandoned_bytes']), (8, 0, 8))

    def test_maximum_choices_preserve_parent_protocol_on_legacy_inputs(self):
        parent = load(ROOT / 'model/tcp-segment-choice.json')
        rules = {t['id']: t for t in parent['transitions']}
        for folder in ('congestion', 'fast-recovery', 'idle-restart', 'limited-transmit'):
            for path in sorted((ROOT / 'scenarios' / folder).glob('*.json')):
                with self.subTest(scene=path.stem):
                    scene = read(path)
                    a = Machine(parent, scene['initial']); b = Machine(self.model, scene['initial'])
                    for step in scene['steps']:
                        start = len(a.trace)
                        for m in (a, b):
                            if step.get('tick'): m.tick(step['at_ms'])
                            else: m.dispatch(step['event'], step.get('fields', {}), step['at_ms'])
                        if step.get('event') == 'app.transmit':
                            rule = rules[a.trace[-1]['transition']]
                            if any('set' in x and x['set']['var'] == 'take' for x in rule['actions']):
                                b.dispatch('choice.segment', dict(count=a.values['take']), step['at_ms'])
                        self.assertEqual(a.state, b.state)
                        self.assertEqual(a.timers, b.timers)
                        for name in a.values:
                            if not name.startswith('choice_'):
                                self.assertEqual(a.values[name], b.values[name], name)
                    def outputs(m):
                        return [(r['time_ms'], packet) for r in m.trace for packet in r['emitted']]
                    self.assertEqual(outputs(a), outputs(b))

    def test_ack_credit_cannot_be_reclassified_as_abandonment(self):
        bad = copy.deepcopy(self.model)
        for t in bad['transitions']:
            for a in t['actions']:
                if 'set' in a and a['set']['var'] == 'svc_ack_step': a['set']['value'] = 0
        m = initial(bad); m.dispatch('app.transmit', time_ms=21)
        for _ in range(2): m.dispatch('choice.segment', dict(count=2), 21)
        with self.assertRaisesRegex(ModelError, 'SCHED-INV-ACK-CREDIT'):
            m.dispatch('net.ack', dict(seq=9001, ack=1005, window=4), 30)

    def test_removing_epoch_guard_is_detected_by_state_invariant(self):
        bad = copy.deepcopy(self.model)
        for t in bad['transitions']:
            if t['event'] == 'choice.segment': t['guard'] = t['guard']['args'][0]
        m = initial(bad); m.dispatch('app.transmit', time_ms=21)
        with self.assertRaisesRegex(ModelError, 'SCHED-INV-CHOICE-EPOCH'):
            m.dispatch('choice.segment', dict(count=2), 22)

    def test_source_lock_generator_and_full_byte_contracts(self):
        for s in read(ROOT / 'spec/sources/tcp-output-schedule.json'):
            self.assertEqual(digest(ROOT / 'spec/sources' / f"rfc{s['rfc']}.txt"), s['sha256'])
        raw = (ROOT / 'model/tcp-output-schedule.json').read_bytes()
        subprocess.run([sys.executable, str(ROOT / 'tools/build_output_schedule_model.py')], check=True)
        self.assertEqual(raw, (ROOT / 'model/tcp-output-schedule.json').read_bytes())
        paths = sorted((ROOT / 'scenarios/output-schedule').glob('*.json'))
        self.assertEqual(len(paths), 2)
        for p in paths:
            with self.subTest(scene=p.stem), tempfile.TemporaryDirectory() as temp:
                m = run_scenario(self.model, read(p))
                self.assertEqual(crosscheck_trace(self.model, m.trace, Path(temp))['status'], 'match')


if __name__ == '__main__': unittest.main(verbosity=2)
