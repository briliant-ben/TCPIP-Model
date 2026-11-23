import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
import unittest
import zipfile

ROOT=Path(__file__).resolve().parents[1]


def module(name,path):
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m


class CaseStudyTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp=tempfile.TemporaryDirectory();cls.out=Path(cls.temp.name)/'build'
        cls.builder=module('case_build',ROOT/'code/build.py')
        cls.result=cls.builder.build(cls.out,True)
    @classmethod
    def tearDownClass(cls):cls.temp.cleanup()

    def test_actual_C_compiles_and_matches_complete_frozen_fixture(self):
        self.assertEqual(self.result['status'],'pass');self.assertTrue(self.result['frozen_fixture_match'])
        self.assertFalse(self.result['new_network_execution']);self.assertFalse(self.result['fresh_formal_verification'])
        expected=json.loads((ROOT/'tests/expected.json').read_text())
        self.assertEqual([json.loads(x)for x in (self.out/'native.stdout').read_bytes().splitlines()],expected)

    def test_unknown_command_rejects_without_mutating_ready_snapshot(self):
        p=subprocess.run([self.result['executable']],input='B\nD 0 no.such.event\n',capture_output=True,text=True)
        self.assertNotEqual(p.returncode,0)
        rows=[json.loads(x)for x in p.stdout.splitlines()]
        self.assertEqual(rows[-1]['status'],'error')
        self.assertEqual(rows[0]['snapshot'],rows[-1]['snapshot'])

    def test_only_six_case_directories_and_pinned_model_C_identity(self):
        visible={p.name for p in ROOT.iterdir()if p.is_dir()and not p.name.startswith(('.', '__'))}
        self.assertEqual(visible,{'spec','model','formal','code','tests','demo'})
        manifest=json.loads((ROOT/'code/generated/manifest.json').read_text())
        for path,key in [('model/ipv4-endpoint-virtual-link.json','model_sha256'),('code/generated/protocol.c','C_sha256')]:
            self.assertEqual(hashlib.sha256((ROOT/path).read_bytes()).hexdigest(),manifest[key])
        self.assertEqual(manifest['C_sha256'],'42386d6a7b2c7c7081a3b189b707c5141f4967b381c2fcaebb54484ac91b64ae')
        self.assertEqual(manifest['model_sha256'],'7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5')
        refs=json.loads((ROOT/'spec/references.json').read_text())['requirements']
        model=json.loads((ROOT/'model/ipv4-endpoint-virtual-link.json').read_text())
        self.assertEqual({r['requirement']for r in refs},set(model['requirements']))
        for row in refs:
            if 'local_source'in row:self.assertEqual(hashlib.sha256((ROOT/row['local_source']).read_bytes()).hexdigest(),row['sha256'])

    def test_optimized_C_matches_all_frozen_pre_optimization_paths(self):
        raw=(ROOT/'tests/optimization-regression.json').read_bytes()
        report=json.loads((ROOT/'code/optimization.json').read_text())
        self.assertEqual(hashlib.sha256(raw).hexdigest(),report['regression_fixture_sha256'])
        fixture=json.loads(raw)
        manifest=json.loads((ROOT/'code/generated/manifest.json').read_text())
        self.assertEqual(report['C_sha256'],manifest['C_sha256'])
        self.assertEqual(report['source_bytes'],(ROOT/manifest['source']).stat().st_size)
        self.assertEqual(report['framework_commit'],manifest['framework_commit'])
        self.assertEqual(fixture['baseline_C_sha256'],manifest['prior_C_sha256'])
        self.assertEqual(fixture['model_sha256'],manifest['model_sha256'])
        self.assertEqual(len(fixture['cases']),24)
        self.assertEqual(sum(c['transitions']for c in fixture['cases']),157)
        for case in fixture['cases']:
            with self.subTest(case=case['id']):
                data=case['input'].encode()
                self.assertEqual(hashlib.sha256(data).hexdigest(),case['input_sha256'])
                p=subprocess.run([self.result['executable']],input=data,capture_output=True,timeout=30)
                self.assertEqual(p.returncode,case['returncode'])
                self.assertEqual(hashlib.sha256(p.stdout).hexdigest(),case['stdout_sha256'])
                self.assertEqual(hashlib.sha256(p.stderr).hexdigest(),case['stderr_sha256'])
        pin=json.loads((ROOT/'code/framework.json').read_text())
        self.assertEqual(pin['commit'],manifest['framework_commit'])
        self.assertNotIn('requirements-formal.txt',pin['source_files'])
        self.assertNotIn('protocol_lab/symbolic.py',pin['source_files'])
        self.assertNotIn('requirements-formal.txt',report['generation_inputs_sha256'])
        self.assertNotIn('framework/protocol_lab/symbolic.py',report['generation_inputs_sha256'])
        self.assertEqual(manifest['backend'],'direct-c99-typed-text-v6')

    def test_recorded_demo_rebuilds_exactly_and_rejects_bad_digest(self):
        demo=module('case_demo',ROOT/'demo/build_review.py');meta=json.loads((ROOT/'demo/provenance.json').read_text())
        manifest=json.loads((ROOT/'code/generated/manifest.json').read_text())
        self.assertEqual(meta['C_sha256'],manifest['prior_C_sha256'])
        capture=(ROOT/'demo/capture.pcap').read_bytes()
        self.assertEqual(hashlib.sha256(capture).hexdigest(),meta['capture_sha256'])
        with zipfile.ZipFile(ROOT/'demo/recording.zip')as recording:
            self.assertEqual(capture,recording.read('live/capture.pcap'))
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'review.html'
            r=demo.render(ROOT/'model/ipv4-endpoint-virtual-link.json',ROOT/'demo/recording.zip',meta['archive_sha256'],out)
            self.assertEqual((r['transitions'],r['packets']),(19,25));self.assertEqual(out.read_bytes(),(ROOT/'demo/review.html').read_bytes())
            with self.assertRaisesRegex(ValueError,'digest'):demo.render(ROOT/'model/ipv4-endpoint-virtual-link.json',ROOT/'demo/recording.zip','0'*64,Path(tmp)/'bad.html')
            self.assertFalse((Path(tmp)/'bad.html').exists())

    def test_lean_manifest_binds_the_published_model_and_proofs(self):
        formal = ROOT/'formal'
        manifest_path = formal/'lean/manifest.json'
        manifest_bytes = manifest_path.read_bytes()
        manifest = json.loads(manifest_bytes)
        self.assertEqual(manifest['schema'], 'fsa-lean-timed-proof-manifest-v2')
        groups = manifest['compile_groups']
        self.assertGreater(len(groups), 0)
        self.assertTrue(all(1 <= len(group) <= 2 for group in groups))
        grouped = [name for group in groups for name in group]
        self.assertEqual(len(grouped), len(set(grouped)))
        self.assertEqual(len(grouped), len(manifest['modules']))
        self.assertEqual(set(grouped), {entry['module'] for entry in manifest['modules']})
        self.assertEqual(groups[-1], ['TimedProof'])
        pin = json.loads((formal/'framework.json').read_text())
        self.assertEqual(pin['commit'], json.loads((ROOT/'code/framework.json').read_text())['commit'])
        self.assertEqual(hashlib.sha256(manifest_bytes).hexdigest(), pin['proof_manifest_sha256'])
        model_name = 'ipv4-endpoint-virtual-link.json'
        model_digest = hashlib.sha256((ROOT/'model'/model_name).read_bytes()).hexdigest()
        self.assertEqual(manifest['model'], {model_name: model_digest})
        receipt = json.loads((formal/'lean-result.json').read_text())
        self.assertEqual(receipt['schema'], 'tcpip-lean-check-receipt-v2')
        self.assertEqual(receipt['formal_status'], 'checked_timed_dispatch_contract')
        self.assertEqual(receipt['raw_firings'], 335)
        self.assertEqual(receipt['conflict_groups'], 18)
        self.assertNotIn('linux_evidence', receipt)
        self.assertNotIn('linux_evidence_sha256', receipt)
        self.assertNotIn('closeout_flow', receipt)
        self.assertEqual(receipt['framework_commit'], pin['commit'])
        self.assertEqual(receipt['proof_manifest_sha256'], pin['proof_manifest_sha256'])
        self.assertEqual(receipt['model'], manifest['model'])
        evidence = json.loads((formal/'proof-evidence.json').read_text())
        self.assertEqual(evidence['framework_commit'], pin['commit'])
        self.assertEqual(evidence['proof_manifest_sha256'], pin['proof_manifest_sha256'])
        archive = formal/receipt['proof_evidence']
        self.assertEqual(hashlib.sha256(archive.read_bytes()).hexdigest(), receipt['proof_archive_sha256'])
        self.assertEqual(evidence['archive_sha256'], receipt['proof_archive_sha256'])
        with tarfile.open(archive, 'r:gz') as bundle:
            self.assertEqual(set(bundle.getnames()), set(evidence['files']))
            for name, digest in evidence['files'].items():
                self.assertEqual(hashlib.sha256(bundle.extractfile(name).read()).hexdigest(), digest)
            res_bytes = bundle.extractfile('result.json').read()
            self.assertEqual(hashlib.sha256(res_bytes).hexdigest(),
                             receipt['checker_report_sha256'])
            res = json.loads(res_bytes)
            self.assertEqual(res['schema'], 'fsa-lean-timed-check-result-v2')
            self.assertEqual(res['status'], 'checked_timed_dispatch_contract')
            self.assertEqual(len(res['commands']), 119)
            self.assertTrue(all(c['returncode'] == 0 for c in res['commands']))
            self.assertEqual(res['axioms'], receipt['axioms'])
        for obsolete in ('results.json', 'linux-proof-evidence.json', 'linux-proof-evidence.tar.gz'):
            self.assertFalse((formal/obsolete).exists(), obsolete)
        modules = {entry['module'] + '.lean': entry['sha256'] for entry in manifest['modules']}
        self.assertEqual(set(modules), {path.name for path in manifest_path.parent.glob('*.lean')})
        for name, digest in modules.items():
            self.assertEqual(hashlib.sha256((manifest_path.parent/name).read_bytes()).hexdigest(), digest)

    def test_no_in_repository_or_reused_output(self):
        with self.assertRaises(ValueError):self.builder.build(ROOT/'code/not-allowed')
        with self.assertRaises(ValueError):self.builder.build(self.out)


if __name__=='__main__':unittest.main()
