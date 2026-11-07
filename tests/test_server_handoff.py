"""Offline boundaries for server roles; never calls a paid provider."""
import importlib.util
import json
from pathlib import Path
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'agents'))
spec=importlib.util.spec_from_file_location('server_handoff',ROOT/'agents/run_server_handoff.py')
driver=importlib.util.module_from_spec(spec);spec.loader.exec_module(driver)

class ServerHandoffTests(unittest.TestCase):
    def setup_job(self,root):
        workspace=root/'workspace'
        for name in ('model','scenarios','tests','examples','.github/workflows'):(workspace/name).mkdir(parents=True,exist_ok=True)
        (workspace/'model/tcp-wire-endpoint.json').write_text(json.dumps(dict(transitions=[],requirements={},variables={})))
        (workspace/'examples/run_native_suite.py').write_text('# fixed trusted evaluator')
        (workspace/'.github/workflows/ipv4-udp-icmp-endpoint.yml').write_text('name: frozen')
        evidence=root/'evidence.json';evidence.write_text('{}');ledger=root/'ledger';ledger.mkdir()
        return SimpleNamespace(out=str(root/'run'),workspace=str(workspace),evidence=str(evidence),python=sys.executable,ledger=str(ledger),credential_file='/never/read/secret',max_calls=64)
    def evaluator(self,command,**kwargs):
        self.assertEqual(command[1:5],['-m','unittest','discover','-s'])
        kwargs['stdout'].write('offline mocked evaluator\n');return SimpleNamespace(returncode=0)
    def response(self,args,patches=()):
        def provider(messages,ledger,credential_file,**kwargs):
            self.assertNotIn(credential_file,json.dumps(messages));self.assertEqual(kwargs['max_calls'],64)
            name='ci.json'if 'Diagnose the real PR20'in messages[-1]['content']else'tcp.json'
            value=dict(model_patches=list(patches),proposed_changes=['untrusted shell must stay data'])
            (Path(ledger)/name).write_text(json.dumps(dict(response=value)))
            return dict(response_file=name,status='completed',cached=False,usage={'total_tokens':0})
        return provider
    def test_two_server_roles_preserve_workflow_and_do_not_execute_proposals(self):
        with tempfile.TemporaryDirectory()as tmp:
            args=self.setup_job(Path(tmp))
            with patch.object(driver,'request',side_effect=self.response(args))as api,patch.object(driver.subprocess,'run',side_effect=self.evaluator)as execute:
                driver.run(args)
            report=json.loads((Path(args.out)/'status.json').read_text())
            self.assertEqual(api.call_count,2);self.assertEqual(execute.call_count,1)
            self.assertEqual(report['status'],'controller_review_required');self.assertFalse(report['ci_changes_applied'])
            self.assertEqual((Path(args.workspace)/'.github/workflows/ipv4-udp-icmp-endpoint.yml').read_text(),'name: frozen')
    def test_provider_failure_is_recorded_without_paid_retry(self):
        with tempfile.TemporaryDirectory()as tmp:
            args=self.setup_job(Path(tmp))
            with patch.object(driver,'request',side_effect=ValueError('uncertain'))as api,patch.object(driver.subprocess,'run',side_effect=self.evaluator):
                with self.assertRaises(ValueError):driver.run(args)
            self.assertLessEqual(api.call_count,2)
            self.assertEqual(json.loads((Path(args.out)/'status.json').read_text())['status'],'failed_or_uncertain')
    def test_path_escape_patch_is_rejected_without_changing_candidate(self):
        with tempfile.TemporaryDirectory()as tmp:
            args=self.setup_job(Path(tmp));path=Path(args.workspace)/'model/tcp-wire-endpoint.json';before=path.read_bytes()
            patches=[dict(pointer='/../../private',before={},after={})]
            with patch.object(driver,'request',side_effect=self.response(args,patches)),patch.object(driver.subprocess,'run',side_effect=self.evaluator):
                with self.assertRaises(ValueError):driver.run(args)
            self.assertEqual(path.read_bytes(),before)
