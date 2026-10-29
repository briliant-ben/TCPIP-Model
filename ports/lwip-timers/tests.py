"""Bounded real-timer observations, cancellation and clock/evidence faults."""
import copy
import json
from pathlib import Path
import subprocess
import tempfile
import unittest

import run as driver


def packets(out, name):
    return [p for p in driver.stream.read(out / (name + '.json'))
            if p['direction'] == 'out' and p.get('payload')]


class TimerPlanTests(unittest.TestCase):
    def test_normative_source_and_clock_lock_corruption_rejected(self):
        original = driver.stream.read(driver.PORT / 'sources.json')
        driver.validate_source_lock(original)
        for change in (lambda s: s.update(sha256='0'*64),
                       lambda s: s.update(version='June 2012'),
                       lambda s: s['driver_clock'].update(step_ms=2),
                       lambda s: s.update(upstream_modified=True)):
            source = copy.deepcopy(original); change(source)
            with self.assertRaisesRegex(ValueError, 'source/clock lock changed'):
                driver.validate_source_lock(source)

    def test_malformed_clock_schema_and_fixture_rejected(self):
        source = driver.stream.read(driver.PORT / 'scenarios/unacknowledged-first-rto.json')
        mutations = [lambda s: s['steps'][-1].update(at_ms=True),
                     lambda s: s['steps'][-1].update(at_ms=12001),
                     lambda s: s['steps'][-1].update(at_ms=19),
                     lambda s: s['steps'][-1].update(tick=1),
                     lambda s: s['steps'][-1].update(unknown=True),
                     lambda s: s['expect'].pop('timers'),
                     lambda s: s['environment'].pop('drop_outgoing'),
                     lambda s: s['steps'][2].update(fields=None),
                     lambda s: s['initial'].update(rto_ms=3000),
                     lambda s: s['environment'].update(drop_outgoing=['e0001:out:0'])]
        for change in mutations:
            with self.subTest(change=change):
                s = copy.deepcopy(source); change(s)
                with self.assertRaises(ValueError): driver.validate_plan(s)
        self.assertTrue(driver.validate_plan(source).endswith('2800 TICK\n'))


class IndependentTimerTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory(prefix='lwip-timer-tests-')
        cls.outputs = {}
        for path in sorted((driver.PORT / 'scenarios').glob('*.json')):
            out = Path(cls.temp.name) / path.stem
            result = driver.run(out, path)
            cls.outputs[path.stem] = (out, path, result)

    @classmethod
    def tearDownClass(cls): cls.temp.cleanup()

    def test_first_and_repeated_data_retransmissions_preserve_real_difference(self):
        for name, model_times, actual_times in [
                ('unacknowledged-first-rto', [21, 1021], [21, 2750]),
                ('unacknowledged-backoff', [21, 1021, 3021, 7021], [21, 2750, 8750])]:
            out, _, result = self.outputs[name]
            self.assertEqual([p['time_ms'] for p in packets(out, 'expected')], model_times)
            self.assertEqual([p['time_ms'] for p in packets(out, 'observed')], actual_times)
            self.assertTrue(all(p['seq'] == 1001 and p['payload'] == [0, 128, 255, 7] for p in packets(out, 'observed')))
            self.assertEqual(result['summary']['acknowledged_bytes'], 0)
            self.assertEqual(result['comparison'], 'mismatch')

    def test_full_ack_stops_further_output_through_actual_12000ms(self):
        out, _, r = self.outputs['full-ack-cancels-timer']
        self.assertEqual([p['time_ms'] for p in packets(out, 'observed')], [21, 2750])
        self.assertEqual(r['summary']['acknowledged_bytes'], 4)
        self.assertEqual(r['summary']['end_ms'], 12000)
        self.assertEqual(r['summary']['clock_checks'], 12000 + r['summary']['commands'])
        self.assertFalse(any(p['time_ms'] >= 3600 for p in packets(out, 'observed')))

    def test_partial_ack_suffix_and_whole_segment_wire_difference(self):
        out, _, r = self.outputs['partial-ack-oldest-suffix']
        expected = packets(out, 'expected'); observed = packets(out, 'observed')
        self.assertEqual([(p['time_ms'], p['seq'], p['payload']) for p in expected[1:]],
                         [(2000, 1003, [255, 7]), (4000, 1003, [255, 7])])
        self.assertEqual([(p['time_ms'], p['seq'], p['payload']) for p in observed[1:]],
                         [(3750, 1001, [0, 128, 255, 7])])
        self.assertEqual(r['summary']['acknowledged_bytes'], 4)

    def test_idle_observation_preserves_distinct_initial_window_policies(self):
        out, _, _ = self.outputs['idle-new-data-budget']
        self.assertEqual([p['payload'] for p in packets(out, 'expected')[1:]], [[17, 33, 65, 129]])
        self.assertEqual([p['payload'] for p in packets(out, 'observed')[1:]],
                         [[17, 33, 65, 129], [1, 2, 3, 4]])

    def test_tick_partition_does_not_shift_actual_capture_clock(self):
        out, _, r = self.outputs['unacknowledged-backoff']
        stimulus = (out / 'stimulus.txt').read_text()
        split = stimulus.replace('12000 TICK\n', ''.join(f'{t} TICK\n' for t in range(250, 12001, 250)))
        fine = Path(self.temp.name) / 'fine-stimulus.txt'; fine.write_text(split)
        capture = Path(self.temp.name) / 'fine.pcap'
        process = subprocess.run([str(out / 'lwip-harness'), str(capture), str(fine)],
                                 capture_output=True, text=True, timeout=10)
        self.assertEqual(process.returncode, 0, process.stderr)
        summary = json.loads(process.stdout)
        self.assertEqual(summary['end_ms'], 12000)
        self.assertEqual(summary['clock_checks'], 12000 + len(split.splitlines()))
        # The pinned driver has deterministic default libc rand initialization;
        # this compares raw bytes, not just an oracle-normalized time projection.
        self.assertEqual(capture.read_bytes(), (out / 'capture.pcap').read_bytes())

    def test_independent_evidence_verification_for_all_five_inputs(self):
        for name, (out, scene, result) in self.outputs.items():
            with self.subTest(name=name):
                r = driver.verify(out, scene)
                self.assertEqual(r['comparison'], result['comparison'])
                self.assertFalse(r['linux_execution'])

    def corrupt(self, filename, change, error):
        out, scene, _ = self.outputs['unacknowledged-first-rto']
        path = out / filename; report = out / 'report.json'
        data, old_report = path.read_bytes(), report.read_bytes()
        try:
            change(path)
            r = json.loads(old_report)
            r['file_hashes'][filename] = driver.stream.digest(path)
            if filename == 'execution.log': r['summary'] = json.loads(path.read_text())
            driver.stream.write(report, r)
            with self.assertRaisesRegex(ValueError, error): driver.verify(out, scene)
        finally:
            path.write_bytes(data); report.write_bytes(old_report)

    def test_rehashed_clock_summary_and_shifted_oracle_are_rejected(self):
        def bad_clock(path):
            r = json.loads(path.read_text()); r['end_ms'] -= 1
            path.write_text(json.dumps(r) + '\n')
        def bad_oracle(path):
            r = json.loads(path.read_text())
            for p in r:
                if p['direction'] == 'out' and p.get('payload') and p['time_ms'] > 21:
                    p['time_ms'] = 2750
            path.write_text(json.dumps(r) + '\n')
        self.corrupt('execution.log', bad_clock, 'Execution summary changed')
        self.corrupt('expected.json', bad_oracle, 'Reference output changed')

    def test_c_parser_rejects_bad_tick_clocks_and_extra_fields(self):
        out, _, _ = self.outputs['unacknowledged-first-rto']
        for n, text in enumerate(['0 TICK\n', '0 CONNECT\n10 TICK\n',
                '0 CONNECT\n10 SYNACK 9000 1001 16\n12001 TICK\n',
                '0 CONNECT\n10 SYNACK 9000 1001 16\n9 TICK\n',
                '0 CONNECT\n10 SYNACK 9000 1001 16\n11 TICK extra\n']):
            plan = Path(self.temp.name) / f'bad-{n}.txt'; plan.write_text(text)
            proc = subprocess.run([str(out / 'lwip-harness'), str(plan.with_suffix('.pcap')), str(plan)],
                                  capture_output=True, text=True, timeout=10)
            self.assertNotEqual(proc.returncode, 0)


if __name__ == '__main__': unittest.main(verbosity=2)
