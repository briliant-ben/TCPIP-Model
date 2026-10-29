"""Exact public sent-event contracts and independent real-capture verification."""
import copy
from pathlib import Path
import json
import os
import subprocess
import sys
import tempfile
import unittest
import run as driver


def verify_cli(out, scene):
    command = [sys.executable, str(driver.PORT / 'run.py'), '--verify', '--scenario', str(scene), '--out', str(out)]
    process = subprocess.run(command, capture_output=True, text=True, timeout=180)
    filename = 'verification.log' if process.returncode == 0 else 'negative-verification.log'
    (out / filename).write_text(process.stdout + process.stderr)
    if process.returncode == 0:
        driver.stream.write(out / 'verification-result.json', dict(result=json.loads(process.stdout), command=command))
    return process


class ServiceSchemaTests(unittest.TestCase):
    def test_primary_source_version_policy_and_hash_changes_rejected(self):
        original = driver.stream.read(driver.PORT / 'service-sources.json')
        driver.validate_service_lock(original)
        for edit in [lambda x: x.update(version='August 2023'),
                     lambda x: x['implementation'].update(commit='0' * 40),
                     lambda x: x['sha256'].update({'third_party/lwip/src/core/tcp_out.c': '0' * 64})]:
            bad = copy.deepcopy(original); edit(bad)
            with self.assertRaises(ValueError): driver.validate_service_lock(bad)

    def test_unsupported_input_and_choice_injection_rejected(self):
        source = driver.stream.read(driver.PORT / 'scenarios/partial-then-full.json')
        for edit in [lambda x: x['initial'].update(iss=0),
                     lambda x: x['environment'].update(drop_outgoing=['e0004:out:0']),
                     lambda x: x['steps'][3].update(event='choice.segment', fields={'count': 4}),
                     lambda x: x['steps'][-1].update(at_ms=12001)]:
            bad = copy.deepcopy(source); edit(bad)
            with self.assertRaises(ValueError): driver.stream.validate_plan(bad)


class IndependentServiceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        persistent = os.environ.get('TCPIP_SERVICE_EVIDENCE_DIR')
        cls.persistent = Path(persistent).resolve() if persistent else None
        if cls.persistent:
            driver.require(cls.persistent.is_relative_to(driver.ROOT / 'artifacts'), 'Persistent evidence must stay in project artifacts')
            cls.persistent.mkdir(parents=True, exist_ok=True)
            cls.temp = None; base = cls.persistent
        else:
            cls.temp = tempfile.TemporaryDirectory(prefix='lwip-service-tests-'); base = Path(cls.temp.name)
        cls.binding = driver.inputs()
        cls.commands = {}; cls.returncodes = {}
        cls.outputs = {}
        for path in sorted((driver.PORT / 'scenarios').glob('*.json')):
            out = base / path.stem
            command = [sys.executable, str(driver.PORT / 'run.py'), '--scenario', str(path), '--out', str(out)]
            process = subprocess.run(command, capture_output=True, text=True, timeout=180)
            out.mkdir(parents=True, exist_ok=True)
            (out / 'generation.log').write_text(process.stdout + process.stderr)
            if process.returncode not in (0, 1):
                raise AssertionError(process.stderr)
            result = driver.stream.read(out / 'report.json')
            if result['status'] not in ('execution_and_projection_pass', 'executed_with_differences'):
                raise AssertionError(result)
            cls.outputs[path.stem] = (out, path, result)
            cls.commands[path.stem] = command; cls.returncodes[path.stem] = process.returncode

    @classmethod
    def tearDownClass(cls):
        if cls.temp: cls.temp.cleanup()

    @classmethod
    def seal_persistent(cls):
        if not cls.persistent: return
        driver.require(driver.inputs() == cls.binding, 'Service inputs changed during tests')
        index = []; verified = []
        for name, (out, scene, _) in cls.outputs.items():
            report = driver.stream.read(out / 'report.json')
            driver.require(report['input_hashes'] == cls.binding, 'Persistent execution binding changed')
            service = driver.stream.read(out / 'receiver-difference.json')
            check = driver.stream.read(out / 'verification-result.json')
            driver.require(check['result']['status'] == 'valid_independent_lwip_stream_evidence'
                and check['result']['query_equivalence']['status'] == 'unsat', 'Missing independent CLI verification')
            program = 'import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
            command = [sys.executable, '-c', program, str(out / 'symbolic/path.smt2')]
            exported = subprocess.run(command, capture_output=True, text=True, timeout=20)
            (out / 'export-verification.log').write_text(exported.stdout + exported.stderr)
            driver.require(exported.returncode == 0 and exported.stdout.strip() == 'sat', 'Independent export not SAT')
            sha = driver.stream.digest(out / 'report.json')
            index.append(dict(id=name, overall=report['comparison'], wire=driver.stream.read(out / 'difference.json')['status'],
                service=service['sent']['status'], expected_callbacks=service['sent']['expected'], actual_callbacks=service['sent']['observed'],
                report_sha256=sha, command=cls.commands[name], returncode=cls.returncodes[name]))
            verified.append(dict(id=name, verification=check['result'], independent_export='sat', command=check['command'],
                log_sha256=driver.stream.digest(out / 'verification.log'), report_sha256=sha,
                export_command=command, export_log_sha256=driver.stream.digest(out / 'export-verification.log')))
        driver.require(driver.inputs() == cls.binding, 'Inputs changed while sealing evidence')
        driver.stream.write(cls.persistent / 'execution-index.json', dict(status='independent_service_executions_complete',
            scenarios=index, producer='standalone_service_tests_persistent', producer_sha256=driver.stream.digest(driver.PORT / 'tests.py'),
            linux_execution=False, universal_refinement=False))
        driver.stream.write(cls.persistent / 'verification.json', dict(status='valid_independent_public_sent_observations',
            scenarios=verified, index_sha256=driver.stream.digest(cls.persistent / 'execution-index.json'),
            producer_sha256=driver.stream.digest(driver.PORT / 'tests.py'), linux_execution=False, universal_refinement=False))

    def test_all_reference_callback_contracts_are_handwritten(self):
        for row in driver.stream.read(driver.PORT / 'contracts.json'):
            out, _, _ = self.outputs[row['id']]
            difference = driver.stream.read(out / 'receiver-difference.json')
            self.assertEqual(difference['sent']['expected'], row['sent_events'])

    def test_window4_and_window8_have_distinct_actual_segment_boundaries(self):
        narrow, _, nr = self.outputs['partial-then-full']
        wide, _, wr = self.outputs['wide-window-partial-then-full']
        self.assertEqual(nr['summary']['sent_events'], [{'time_ms': 30, 'bytes': 2}, {'time_ms': 40, 'bytes': 2}])
        self.assertEqual(wr['summary']['sent_events'], [{'time_ms': 40, 'bytes': 4}])
        self.assertEqual(nr['comparison'], 'mismatch')
        self.assertEqual(wr['comparison'], 'match')
        self.assertEqual(driver.stream.read(narrow / 'receiver-difference.json')['sent']['status'], 'mismatch')
        self.assertEqual(driver.stream.read(wide / 'receiver-difference.json')['sent']['status'], 'match')

    def test_real_partial_ack_does_not_release_original_segment_credit(self):
        _, _, narrow = self.outputs['partial-only-no-callback']
        _, _, wide = self.outputs['wide-window-partial-no-callback']
        self.assertEqual(narrow['summary']['sent_events'], [{'time_ms': 30, 'bytes': 2}])
        self.assertEqual(wide['summary']['sent_events'], [])
        self.assertEqual(wide['summary']['acknowledged_bytes'], 0)

    def test_partial_rto_preserves_wire_difference_and_service_agreement(self):
        out, _, result = self.outputs['partial-rto-credit']
        self.assertEqual(result['comparison'], 'mismatch')
        self.assertEqual(driver.stream.read(out / 'difference.json')['status'], 'mismatch')
        self.assertEqual(driver.stream.read(out / 'receiver-difference.json')['sent']['status'], 'match')
        self.assertEqual(result['summary']['sent_events'], [{'time_ms': 5100, 'bytes': 4}])

    def test_cumulative_mixed_ack_and_two_by_two_service_events(self):
        for name, callbacks in [('cumulative-mixed-segments', [(40, 4), (70, 4), (80, 4), (120, 4)]),
                                ('two-by-two-pending', [(30, 4)])]:
            _, _, result = self.outputs[name]
            self.assertEqual(result['summary']['sent_events'], [{'time_ms': t, 'bytes': n} for t, n in callbacks])

    def test_summary_time_type_credit_and_sum_corruption_rejected(self):
        _, scene, result = self.outputs['wide-window-partial-then-full']
        source = driver.stream.read(scene)
        for edit in [lambda x: x.pop('sent_events'),
                     lambda x: x['sent_events'][0].update(time_ms=True),
                     lambda x: x['sent_events'][0].update(time_ms=201),
                     lambda x: x['sent_events'][0].update(bytes=0),
                     lambda x: x['sent_events'][0].update(bytes=3)]:
            bad = copy.deepcopy(result['summary']); edit(bad)
            with self.assertRaises(ValueError): driver.validate_summary(bad, source)

    def test_independent_verifier_reconstructs_all_inputs_queries_and_observations(self):
        for name, (out, scene, _) in self.outputs.items():
            with self.subTest(name=name):
                process = verify_cli(out, scene)
                self.assertEqual(process.returncode, 0, process.stderr)
                answer = json.loads(process.stdout)
                self.assertEqual(answer['status'], 'valid_independent_lwip_stream_evidence')

    def test_rehashed_service_oracle_still_rejected(self):
        out, scene, _ = self.outputs['wide-window-partial-then-full']
        report_path = out / 'report.json'; difference_path = out / 'receiver-difference.json'
        original_report = report_path.read_bytes(); original_difference = difference_path.read_bytes()
        try:
            diff = driver.stream.read(difference_path)
            diff['sent']['expected'][0]['time_ms'] += 1
            driver.stream.write(difference_path, diff)
            report = driver.stream.read(report_path)
            report['file_hashes']['receiver-difference.json'] = driver.stream.digest(difference_path)
            driver.stream.write(report_path, report)
            process = verify_cli(out, scene)
            self.assertNotEqual(process.returncode, 0)
            self.assertIn('Receiver Difference changed', process.stderr)
        finally:
            report_path.write_bytes(original_report); difference_path.write_bytes(original_difference)


if __name__ == '__main__':
    suite = unittest.main(verbosity=2, exit=False)
    if suite.result.wasSuccessful(): IndependentServiceTests.seal_persistent()
    raise SystemExit(0 if suite.result.wasSuccessful() else 1)
