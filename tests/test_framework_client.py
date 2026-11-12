"""Real cross-repository execution; historical core is not changed or rehashed away."""
from pathlib import Path
import copy
import hashlib
import importlib.util
import json
import os
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('framework_client',ROOT/'tools/run_framework_candidate.py')
client=importlib.util.module_from_spec(spec);spec.loader.exec_module(client)
READY=(ROOT/'framework/protocol_lab/ir.py').is_file()


@unittest.skipUnless(READY,'Initialize the pinned framework submodule')
class FrameworkClientTests(unittest.TestCase):
    def test_historical_core_frozen_and_external_pin_exact(self):
        frozen=json.loads((ROOT/'docs/frozen-legacy-framework.json').read_text())
        for name,digest in frozen['files'].items():self.assertEqual(hashlib.sha256((ROOT/name).read_bytes()).hexdigest(),digest,name)
        self.assertEqual(client.verify_framework(),(ROOT/'framework').resolve())

    def test_changed_approved_commit_or_source_digest_is_rejected(self):
        lock=json.loads((ROOT/'framework.lock.json').read_text());wrong=copy.deepcopy(lock);wrong['commit']='0'*40
        with self.assertRaisesRegex(ValueError,'commit'):client.verify_framework(lock=wrong)
        wrong=copy.deepcopy(lock);wrong['source_files']['protocol_lab/ir.py']='0'*64
        with self.assertRaisesRegex(ValueError,'source changed'):client.verify_framework(lock=wrong)

    def test_actual_external_tcp_flow_and_retained_verification(self):
        with tempfile.TemporaryDirectory()as tmp:
            task=ROOT/'flows/tcp-active-open.json';pin=hashlib.sha256(task.read_bytes()).hexdigest();out=Path(tmp)/'flow'
            base=[sys.executable,str(ROOT/'tools/run_framework_candidate.py')]
            r=subprocess.run(base+['run',str(task),'--workspace',str(ROOT),'--out',str(out),'--task-sha256',pin],capture_output=True,text=True)
            self.assertEqual(r.returncode,0,r.stderr+r.stdout[-4000:]);result=json.loads(r.stdout.splitlines()[-1]);self.assertEqual(result['assessment'],'verified_event_slice')
            self.assertTrue(all(s['status']=='pass'for s in result['stages'].values()));self.assertFalse(result['protocol_correctness_proved'])
            v=subprocess.run(base+['verify',str(out),'--workspace',str(ROOT),'--task-sha256',pin],capture_output=True,text=True)
            self.assertEqual(v.returncode,0,v.stderr);self.assertEqual(json.loads(v.stdout)['status'],'retained_evidence_consistent')

    def test_current_full_ipv4_ir_generates_identical_C_and_executes_native_case(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);scene=json.loads((ROOT/'scenarios/ipv4-rule-coverage/cases.json').read_text())['cases'][0]['scenario'];(root/'scenario.json').write_text(json.dumps(scene))
            code='''import json,sys
from pathlib import Path
from protocol_lab.codegen import generate,sha
from protocol_lab.codegen.execute import build,run
root=Path(sys.argv[1]);model=Path(sys.argv[2]);generate(model,root/'generation');assert build(root/'generation',root/'build')['status']=='pass';r=run(root/'generation',root/'build',root/'scenario.json',root/'native');print(json.dumps(dict(status=r['status'],C_sha256=sha(root/'generation/protocol.c'))))
'''
            env=dict(os.environ,PYTHONPATH=str(ROOT/'framework'),PYTHONDONTWRITEBYTECODE='1')
            r=subprocess.run([sys.executable,'-c',code,str(root),str(ROOT/'model/ipv4-endpoint-virtual-link.json')],cwd=ROOT/'framework',env=env,capture_output=True,text=True)
            self.assertEqual(r.returncode,0,r.stderr);d=json.loads(r.stdout);self.assertEqual(d['status'],'pass');self.assertEqual(d['C_sha256'],'19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b')
