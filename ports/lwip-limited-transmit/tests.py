"""Independent capture semantics plus rehashed-oracle tamper rejection."""
from pathlib import Path
import tempfile
import unittest
import run as driver


class LimitedTransmitPortTests(unittest.TestCase):
    def test_real_capture_and_reference_remain_separate_with_strict_verification(self):
        for name, expected_times, actual_times in [('no-queued-new-data', [21], [21]),
                ('one-queued-segment', [21, 30], [21, 30]),
                ('two-opportunities', [21, 30, 31], [21, 30, 30, 30])]:
            with self.subTest(name=name), tempfile.TemporaryDirectory(prefix='lwip-lt-test-') as temp:
                out = Path(temp); scenario = driver.PORT / 'scenarios' / (name + '.json')
                r = driver.run(out, scenario)
                observed = driver.stream.read(out / 'observed.json')
                packets = [p for p in observed if p['direction'] == 'out' and p['payload']]
                self.assertEqual([p['time_ms'] for p in packets], actual_times)
                self.assertEqual(packets[0]['payload'], [0, 128, 255, 7])
                if name == 'one-queued-segment': self.assertEqual(packets[1]['payload'], [17, 33, 65, 129])
                if name == 'two-opportunities': self.assertEqual([p['payload'] for p in packets[1:]], [list(range(i, i+4)) for i in (4, 8, 12)])
                expected = driver.stream.read(out / 'expected.json')
                self.assertEqual([p['time_ms'] for p in expected if p['direction'] == 'out' and p['payload']], expected_times)
                self.assertEqual(r['summary']['acknowledged_bytes'], 0)
                comparison = 'mismatch' if name == 'two-opportunities' else 'match'
                self.assertEqual(r['comparison'], comparison)
                self.assertEqual(driver.verify(out, scenario)['comparison'], comparison)
                # Rehashing a forged expected stream must not turn actual
                # observations into a model-generated conformance oracle.
                data = expected[:-1]
                driver.stream.write(out / 'expected.json', data)
                r['file_hashes']['expected.json'] = driver.stream.digest(out / 'expected.json')
                driver.stream.write(out / 'report.json', r)
                with self.assertRaisesRegex(ValueError, 'Reference output changed'):
                    driver.verify(out, scenario)

    def test_foreign_scenario_and_loss_initial_overrides_rejected(self):
        with self.assertRaisesRegex(ValueError, 'bound limited-transmit input'):
            driver.bound(driver.ROOT / 'ports/lwip-recovery/scenarios/third-duplicate.json')
        s = driver.stream.read(driver.PORT / 'scenarios/two-opportunities.json')
        s['initial']['cc_initial_window'] = 16
        with self.assertRaises(ValueError): driver.stream.validate_plan(s)


if __name__ == '__main__': unittest.main(verbosity=2)
