"""Real public-API SWS-policy observations; mismatches remain evidence."""
import copy
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
import run as driver


def verify_cli(out, scene, negative=False):
    command = [sys.executable, str(driver.PORT / 'run.py'), '--verify', '--scenario', str(scene), '--out', str(out)]
    process = subprocess.run(command, capture_output=True, text=True, timeout=240)
    (out / ('negative-verification.log' if negative else 'verification.log')).write_text(process.stdout + process.stderr)
    if process.returncode == 0 and not negative:
        driver.stream.write(out / 'verification-result.json', dict(result=json.loads(process.stdout), command=command))
    return process


class IndependentSWSTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        persistent = os.environ.get('TCPIP_SWS_EVIDENCE_DIR')
        cls.persistent = Path(persistent).resolve() if persistent else None
        cls.temp = None if persistent else tempfile.TemporaryDirectory(prefix='lwip-sws-tests-')
        cls.base = cls.persistent or Path(cls.temp.name)
        if persistent: driver.require(cls.base.is_relative_to(driver.ROOT / 'artifacts'), 'Evidence outside artifacts')
        cls.base.mkdir(parents=True, exist_ok=True)
        cls.binding = driver.inputs(); cls.outputs = {}
        for scene in sorted((driver.PORT / 'scenarios').glob('*.json')):
            out = cls.base / scene.stem
            command = [sys.executable, str(driver.PORT / 'run.py'), '--scenario', str(scene), '--out', str(out)]
            process = subprocess.run(command, capture_output=True, text=True, timeout=240)
            out.mkdir(parents=True, exist_ok=True)
            (out / 'generation.log').write_text(process.stdout + process.stderr)
            if process.returncode not in [0, 1]: raise AssertionError(process.stderr)
            report = driver.stream.read(out / 'report.json')
            if report['status'] not in ['execution_and_projection_pass', 'executed_with_differences']:
                raise AssertionError(report)
            cls.outputs[scene.stem] = (out, scene, report, command, process.returncode)

    @classmethod
    def tearDownClass(cls):
        if cls.temp: cls.temp.cleanup()

    def test_a_model_contracts_and_actual_policy_hypotheses_remain_distinct(self):
        for contract in driver.stream.read(driver.PORT / 'contracts.json'):
            out, _, report, _, _ = self.outputs[contract['id']]
            wire = driver.stream.read(out / 'difference.json')
            callbacks = driver.stream.read(out / 'receiver-difference.json')['sent']
            expected = driver.stream.read(out / 'expected.json')
            actual = driver.stream.read(out / 'observed.json')
            model_data = [p for p in expected if p['direction'] == 'out' and p.get('payload')]
            real_data = [p for p in actual if p['direction'] == 'out' and p.get('payload')]
            self.assertEqual([p['time_ms'] for p in model_data], [contract['model_send_ms']])
            self.assertEqual([p['time_ms'] for p in real_data], [contract['actual_send_hypothesis_ms']])
            self.assertEqual(wire['status'], contract['expected_wire'])
            self.assertEqual(callbacks['expected'], contract['sent_events'])
            self.assertEqual(callbacks['observed'], contract['sent_events'])
            self.assertEqual(report['summary']['clock_step_ms'], 1)
            self.assertFalse(report['linux_execution'])

    def test_b_independent_cli_reconstructs_all_three_real_observations(self):
        for name, (out, scene, _, _, _) in self.outputs.items():
            with self.subTest(name=name):
                process = verify_cli(out, scene)
                self.assertEqual(process.returncode, 0, process.stderr)
                self.assertEqual(json.loads(process.stdout)['status'], 'valid_independent_lwip_stream_evidence')

    def test_c_rehashed_callback_oracle_cannot_force_a_match(self):
        out, scene, _, _, _ = self.outputs['full-mss']
        report = out / 'report.json'; diff = out / 'receiver-difference.json'
        original_report = report.read_bytes(); original_diff = diff.read_bytes()
        try:
            value = driver.stream.read(diff); value['sent']['expected'][0]['time_ms'] += 1
            driver.stream.write(diff, value)
            value = driver.stream.read(report); value['file_hashes']['receiver-difference.json'] = driver.stream.digest(diff)
            driver.stream.write(report, value)
            process = verify_cli(out, scene, negative=True)
            self.assertNotEqual(process.returncode, 0)
            self.assertIn('Receiver Difference changed', process.stderr)
        finally:
            report.write_bytes(original_report); diff.write_bytes(original_diff)

    def test_d_source_version_hash_and_unsupported_push_are_rejected(self):
        original = driver.stream.read(driver.PORT / 'sws-sources.json')
        driver.validate_sws_lock(original)
        for edit in [lambda x: x['specification'].update(version='August2023'),
                     lambda x: x['sha256'].update({'spec/sources/rfc9293.txt': '0' * 64})]:
            bad = copy.deepcopy(original); edit(bad)
            with self.assertRaises(ValueError): driver.validate_sws_lock(bad)
        scene = driver.stream.read(driver.PORT / 'scenarios/full-mss.json')
        scene['steps'][3] = dict(at_ms=21, event='app.push', fields={})
        with self.assertRaises(ValueError): driver.stream.validate_plan(scene)

    @classmethod
    def seal(cls):
        if not cls.persistent: return
        driver.require(driver.inputs() == cls.binding, 'Source changed during SWS executions')
        index = []; checked = []
        for name, (out, scene, _, command, code) in cls.outputs.items():
            report = driver.stream.read(out / 'report.json')
            driver.require(report['input_hashes'] == cls.binding, 'Execution binding differs')
            verified = driver.stream.read(out / 'verification-result.json')
            driver.require(verified['result']['query_equivalence']['status'] == 'unsat', 'Independent query not equivalent')
            program = 'import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
            export = subprocess.run([sys.executable, '-c', program, str(out / 'symbolic/path.smt2')],
                capture_output=True, text=True, timeout=20)
            (out / 'export-verification.log').write_text(export.stdout + export.stderr)
            driver.require(export.returncode == 0 and export.stdout.strip() == 'sat', 'Export not SAT')
            index.append(dict(id=name, wire=driver.stream.read(out / 'difference.json')['status'],
                service=driver.stream.read(out / 'receiver-difference.json')['sent']['status'],
                report_sha256=driver.stream.digest(out / 'report.json'), command=command, returncode=code))
            checked.append(dict(id=name, report_sha256=driver.stream.digest(out / 'report.json'),
                verification=verified, log_sha256=driver.stream.digest(out / 'verification.log'),
                export_log_sha256=driver.stream.digest(out / 'export-verification.log')))
        driver.require(driver.inputs() == cls.binding, 'Source changed while sealing SWS')
        driver.stream.write(cls.base / 'execution-index.json', dict(status='independent_sws_observations_complete',
            scenarios=index, linux_execution=False, universal_refinement=False))
        driver.stream.write(cls.base / 'verification.json', dict(status='valid_independent_sws_observations',
            scenarios=checked, producer_sha256=driver.stream.digest(driver.PORT / 'tests.py'),
            index_sha256=driver.stream.digest(cls.base / 'execution-index.json'),
            linux_execution=False, universal_refinement=False))


if __name__ == '__main__':
    suite = unittest.main(verbosity=2, exit=False)
    if suite.result.wasSuccessful(): IndependentSWSTests.seal()
    raise SystemExit(0 if suite.result.wasSuccessful() else 1)
