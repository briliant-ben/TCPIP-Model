"""Separate integration tests; outside the in-flight 344-test frozen run."""
import copy
from pathlib import Path
import tempfile
import unittest

import run as driver


class RecoveryTests(unittest.TestCase):
    def test_reject_initial_override_loss_and_foreign_scenario(self):
        source = driver.stream.read(driver.PORT / 'scenarios/third-duplicate.json')
        for change in (lambda s: s['initial'].update(cc_initial_window=16),
                       lambda s: s['environment'].update(drop_outgoing=['e0001:out:0']),
                       lambda s: s['steps'][-1].update(at_ms=201)):
            scenario = copy.deepcopy(source)
            change(scenario)
            with self.assertRaises(ValueError): driver.stream.validate_plan(scenario)
        with self.assertRaisesRegex(ValueError, 'bound recovery input'):
            driver.bound(driver.ROOT / 'ports/lwip-stream/scenarios/two-segments-partial-ack.json')

    def test_duplicate_threshold_real_capture_and_evidence(self):
        for name, retransmit_times, comparison in [('two-duplicates', [], 'match'),
                ('third-duplicate', [], 'mismatch'), ('extra-duplicate', [33.0], 'mismatch'),
                ('primed-third-duplicate', [32.0], 'match')]:
            with self.subTest(name=name), tempfile.TemporaryDirectory(prefix='lwip-recovery-test-') as temp:
                out = Path(temp)
                scenario = driver.PORT / 'scenarios' / (name + '.json')
                result = driver.run(out, scenario)
                self.assertEqual(result['summary']['acknowledged_bytes'], 4)
                self.assertFalse(result['linux_execution'])
                self.assertIn('model/tcp-fast-recovery.json', result['input_hashes'])
                self.assertIn('ports/lwip-recovery/run.py', result['input_hashes'])
                observed = driver.stream.read(out / 'observed.json')
                packets = [p for p in observed if p['direction'] == 'out' and p['payload']]
                self.assertEqual([p['time_ms'] for p in packets], [21.0] + retransmit_times)
                self.assertTrue(all(p['seq'] == 1001 and p['payload'] == [0, 128, 255, 7] for p in packets))
                self.assertEqual(result['comparison'], comparison)
                self.assertEqual(driver.verify(out, scenario)['comparison'], result['comparison'])
                report = driver.stream.read(out / 'report.json')
                report['model_semantic_sha256'] = '0' * 64
                driver.stream.write(out / 'report.json', report)
                with self.assertRaisesRegex(ValueError, 'model binding changed'):
                    driver.verify(out, scenario)


if __name__ == '__main__':
    unittest.main(verbosity=2)
