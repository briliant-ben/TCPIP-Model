import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
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
        self.assertEqual(manifest['C_sha256'],'e5a3f04adbb50c3c226256f2f43c62ac7c2c8dd62fc38aa44a51ced8a520b5cf')
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
        self.assertEqual(manifest['backend'],'direct-c99-shared-expressions-v5')

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

    def test_no_in_repository_or_reused_output(self):
        with self.assertRaises(ValueError):self.builder.build(ROOT/'code/not-allowed')
        with self.assertRaises(ValueError):self.builder.build(self.out)


if __name__=='__main__':unittest.main()
