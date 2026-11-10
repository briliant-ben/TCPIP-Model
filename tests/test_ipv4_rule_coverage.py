"""Frozen model-derived default paths; these are not independent wire oracles."""
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from protocol_lab.ir import load
from protocol_lab.codegen import generate,sha
from protocol_lab.codegen.execute import build,commands,compare

ROOT=Path(__file__).resolve().parents[1]

class DirectedRuleCoverage(unittest.TestCase):
    def test_default_paths_hit_declared_targets_with_fresh_generated_c(self):
        source=ROOT/'scenarios/ipv4-rule-coverage/cases.json'
        self.assertEqual(sha(source),'4fc689a425ca3e79d6fbc592a37fe36cf0201c0e2b7b929efc9caa0969597f20')
        data=json.loads(source.read_text());model_file=ROOT/'model/ipv4-endpoint-virtual-link.json'
        self.assertEqual(sha(model_file),data['model_file_sha256'])
        self.assertFalse(data['independent_RFC_oracle']);self.assertEqual(len(data['cases']),22)
        model=load(model_file);known={r['id']for r in model['transitions']}
        with tempfile.TemporaryDirectory()as temp:
            out=Path(temp);generate(model_file,out/'generation')
            self.assertEqual(sha(out/'generation/protocol.c'),'19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b')
            self.assertEqual(build(out/'generation',out/'build')['status'],'pass')
            for case in data['cases']:
                scene=case['scenario']
                with self.subTest(scene=scene['id']):
                    self.assertEqual(scene['initial'],{})
                    self.assertTrue(set(case['target_rules'])<=known)
                    # Only the input path enters C; expected snapshots stay in this observer.
                    native=subprocess.run([str(out/'build/protocol-native')],input=commands(model,scene),capture_output=True,text=True,timeout=30)
                    self.assertEqual(native.returncode,0,native.stderr);self.assertEqual(native.stderr,'')
                    observed=[json.loads(line)for line in native.stdout.splitlines()]
                    difference=compare(model,scene,observed)
                    self.assertEqual(difference['status'],'match',difference)
                    reached={row['transition']for row in difference['reference_trace']}
                    self.assertTrue(set(case['target_rules'])<=reached)

if __name__=='__main__':unittest.main()
