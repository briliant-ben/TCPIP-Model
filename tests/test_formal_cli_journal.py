"""Actual CLI build/formal integration with fresh, interruption-safe journals."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class FormalCLIJournalTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory()
        cls.artifacts = Path(cls.temp.name) / 'artifacts'
        build = cls.command('build', '--out', str(cls.artifacts))
        if build.returncode:
            raise AssertionError(build.stdout + build.stderr)

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    @staticmethod
    def command(*args):
        return subprocess.run([sys.executable, '-m', 'protocol_lab', *args],
                              cwd=ROOT, capture_output=True, text=True, timeout=60)

    def test_fresh_formal_cli_completes_and_nonempty_rerun_preserves_all_evidence(self):
        first = self.command('formal', '--artifacts', str(self.artifacts), '--depth', '2')
        self.assertEqual(first.returncode, 0, first.stdout + first.stderr)
        report = json.loads((self.artifacts / 'formal/result.json').read_text())
        self.assertEqual(report['status'], 'bounded_pass')
        self.assertEqual(report['solver_preprocess'], 'none')
        self.assertEqual(report['build_sha256'], hashlib.sha256(
            (self.artifacts / 'report.json').read_bytes()).hexdigest())
        for field, filename in [('smt2_sha256', 'model.smt2'),
                                ('overlap_smt2_sha256', 'overlap.smt2')]:
            self.assertEqual(report[field], hashlib.sha256(
                (self.artifacts / 'formal' / filename).read_bytes()).hexdigest())
        before = {p.relative_to(self.artifacts).as_posix(): p.read_bytes()
                  for p in self.artifacts.rglob('*') if p.is_file()}
        second = self.command('formal', '--artifacts', str(self.artifacts), '--depth', '2')
        self.assertNotEqual(second.returncode, 0)
        self.assertIn('fresh --artifacts directory', second.stdout + second.stderr)
        after = {p.relative_to(self.artifacts).as_posix(): p.read_bytes()
                 for p in self.artifacts.rglob('*') if p.is_file()}
        self.assertEqual(before, after)

    def test_nonempty_formal_is_refused_before_snapshot_validation_or_mutation(self):
        with tempfile.TemporaryDirectory() as tmp:
            artifacts = Path(tmp)
            formal = artifacts / 'formal'
            formal.mkdir()
            marker = formal / 'result.json'
            marker.write_bytes(b'original evidence without a build snapshot\n')
            before = marker.read_bytes()
            result = self.command('formal', '--artifacts', str(artifacts))
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('fresh --artifacts directory', result.stdout + result.stderr)
            self.assertEqual(marker.read_bytes(), before)
            self.assertEqual(sorted(p.relative_to(artifacts).as_posix()
                                    for p in artifacts.rglob('*') if p.is_file()),
                             ['formal/result.json'])
