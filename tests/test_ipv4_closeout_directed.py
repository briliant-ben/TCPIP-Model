"""Frozen model-derived TCP supplements, not an independent RFC/wire oracle."""
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from protocol_lab.ir import load,Machine,ModelError
from protocol_lab.pipeline.worker import apply,classification,compare_case,KEYS
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,commands
ROOT=Path(__file__).resolve().parents[1]

class DirectedTCPClosure(unittest.TestCase):
    def test_frozen_controls_faults_and_logical_expiry_match_generated_c(self):
        f=ROOT/'scenarios/ipv4-closeout-directed/cases.json'
        self.assertEqual(hashlib.sha256(f.read_bytes()).hexdigest(),'d2fb120e3b6ceb2d59b784b23744d73e4c21be08c41febbffb2a9c612501d89a')
        data=json.loads(f.read_text());model=load(ROOT/'model/ipv4-endpoint-virtual-link.json')
        self.assertEqual(len(data['cases']),11)
        with tempfile.TemporaryDirectory()as d:
            root=Path(d);generation=root/'generation';binary=root/'build'
            generate(ROOT/'model/ipv4-endpoint-virtual-link.json',generation)
            self.assertEqual(build(generation,binary)['status'],'pass')
            for scene in data['cases']:
                with self.subTest(case=scene['id']):
                    machine=Machine(model);initial=machine.snapshot();ops=[];error=None
                    for step in scene['steps']:
                        try:apply(machine,step)
                        except ModelError as exc:
                            error=dict(classification=classification(exc),message=str(exc));break
                        ops.append(machine.snapshot())
                    self.assertEqual(error['classification']if error else None,data['expected_rejections'].get(scene['id']))
                    self.assertEqual(machine.values['T.control'],data['intended_target_controls'][scene['id']])
                    reference=dict(initial=initial,operations=ops,error=error,
                                   trace=[{k:r[k]for k in KEYS}for r in machine.trace],final=machine.snapshot())
                    # C receives only frozen stimuli, never reference outputs.
                    native=subprocess.run([str(binary/'protocol-native')],input=commands(model,scene),
                                          capture_output=True,text=True,timeout=30)
                    observed=[json.loads(line)for line in native.stdout.splitlines()]
                    difference=compare_case(reference,observed,native.returncode,error is not None)
                    self.assertEqual(difference['status'],'pass',difference)
                    if scene['id']=='timewait-timer-expiry-v4':
                        self.assertIn('T.C-TIME-WAIT-EXPIRED',[r['transition']for r in machine.trace])
                        self.assertNotIn('T.time_wait',machine.timers)

if __name__=='__main__':unittest.main()
