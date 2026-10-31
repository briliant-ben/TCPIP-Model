"""A second RFC through the same tools; independent contracts reject model defects."""
import concurrent.futures
import contextlib
import copy
import importlib.util
import io
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest
from protocol_lab.pipeline.runner import run,verify
from protocol_lab.pipeline.task import read,write,sha
from protocol_lab.codegen.execute import commands
from protocol_lab.ir import load

ROOT=Path(__file__).resolve().parents[1]
READY=bool(shutil.which('cc')and importlib.util.find_spec('z3'))


def quiet(task,workspace,out):
    with contextlib.redirect_stdout(io.StringIO()):return run(task,workspace,out,expected_task_sha256=sha(task))


def candidate(root):
    root.mkdir();t=read(ROOT/'flows/udp-header.json')
    for name in {t['model'],t['exploration'],*t['seeds'],*(s['path']for s in t['sources'])}:
        p=root/name;p.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/name,p)
    write(root/'task.json',t);return root/'task.json'


@unittest.skipUnless(READY,'Actual native compiler and Z3 required')
class FlowMigrationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp=tempfile.TemporaryDirectory(prefix='spec-flow-migration-');cls.root=Path(cls.temp.name)
        cls.out=cls.root/'udp';cls.r=quiet(ROOT/'flows/udp-header.json',ROOT,cls.out)

    @classmethod
    def tearDownClass(cls):cls.temp.cleanup()

    def test_second_rfc_runs_all_stages_with_all_declared_rules(self):
        r=self.r;self.assertEqual(r['assessment'],'verified_event_slice')
        self.assertEqual(len(r['stages']),10)
        self.assertTrue(all(s['status']=='pass'for s in r['stages'].values()))
        self.assertEqual(len(r['stages']['tests']['data']['covered_rules']),7)
        self.assertEqual(r['stages']['tests']['data']['uncovered_rules'],[])
        self.assertEqual(len(r['stages']['tests']['data']['cases']),12)
        self.assertEqual(r['stages']['tests']['data']['negative_count'],2)
        self.assertEqual(r['stages']['reference']['data']['trace_contract_steps_checked'],14)
        self.assertEqual(r['stages']['formal']['data']['safety_query'],'unsat')
        self.assertEqual(r['stages']['formal']['data']['overlap_query'],'unsat')
        self.assertFalse(r['stages']['formal']['data']['unbounded_proof'])
        self.assertFalse(r['pcap_evidence'])
        self.assertEqual(verify(self.out,ROOT)['assessment'],'verified_event_slice')

    def test_second_native_program_executes_without_python_or_stack(self):
        model=load(ROOT/'model/udp-header.json');case=read(ROOT/'scenarios/udp-header/send-default-and-config.json')
        binary=self.out/'stages/build/build/protocol-native'
        p=subprocess.run([str(binary)],input=commands(model,case),text=True,capture_output=True,env={'PATH':''},timeout=5)
        self.assertEqual(p.returncode,0,p.stderr)
        rows=[json.loads(line)for line in p.stdout.splitlines()]
        emitted=[msg for row in rows if row['status']=='transition'for msg in row['emitted']]
        self.assertEqual(emitted[0]['fields']['length'],8)
        self.assertTrue(emitted[0]['fields']['checksum_present'])
        self.assertFalse(emitted[1]['fields']['checksum_present'])
        self.assertEqual(emitted[1]['fields']['length'],65515)
        self.assertEqual(rows[-1]['snapshot']['variables']['tx_count'],3)

    def test_wrong_default_checksum_policy_fails_independent_contract(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=candidate(root/'candidate');m=read(task.parent/'model/udp-header.json')
            m['variables']['checksums_enabled']['initial']=False;write(task.parent/'model/udp-header.json',m)
            r=quiet(task,task.parent,root/'run')
            self.assertEqual(r['assessment'],'failed')
            self.assertEqual(r['stages']['reference']['classification'],'scenario_contract')
            self.assertEqual(r['stages']['formal']['status'],'pass')

    def test_wrong_udp_header_length_fails_even_with_matching_native_and_ir(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=candidate(root/'candidate');m=read(task.parent/'model/udp-header.json')
            rule=next(r for r in m['transitions']if r['id']=='U-SEND')
            rule['actions'][1]['emit']['fields']['length']['args'][1]=9
            write(task.parent/'model/udp-header.json',m);r=quiet(task,task.parent,root/'run')
            self.assertEqual(r['assessment'],'failed')
            self.assertEqual(r['stages']['reference']['classification'],'scenario_contract')
            self.assertEqual(r['stages']['execute']['status'],'pass')
            self.assertEqual(r['stages']['compare']['classification'],'dependency')

    def test_bad_checksum_must_not_emit_a_response(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=candidate(root/'candidate');m=read(task.parent/'model/udp-header.json')
            rule=next(r for r in m['transitions']if r['id']=='U-DISCARD-CHECKSUM')
            rule['actions'].append({'emit':{'message':'udp.error','fields':{'reason':'checksum_invalid'}}})
            write(task.parent/'model/udp-header.json',m);r=quiet(task,task.parent,root/'run')
            self.assertEqual(r['assessment'],'failed')
            self.assertEqual(r['stages']['reference']['classification'],'scenario_contract')

    def test_framework_neutral_client_handles_two_isolated_protocol_candidates(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);jobs=[]
            for name in ('tcp-active-open-ipv4','udp-header'):
                workspace=root/name;workspace.mkdir();t=read(ROOT/('flows/'+name+'.json'))
                for rel in {t['model'],t['exploration'],*t['seeds'],*(source['path']for source in t['sources'])}:
                    p=workspace/rel;p.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/rel,p)
                write(workspace/'task.json',t)
                jobs.append((workspace,root/(name+'-result'),sha(workspace/'task.json')))
            def invoke(job):
                workspace,out,pin=job
                return subprocess.run([sys.executable,str(ROOT/'examples/run_spec_candidate.py'),'--workspace',str(workspace),'--task','task.json','--out',str(out),'--task-sha256',pin],cwd=root,text=True,capture_output=True,timeout=120)
            with concurrent.futures.ThreadPoolExecutor(max_workers=2)as pool:results=list(pool.map(invoke,jobs))
            ids=[]
            for process,(workspace,out,pin)in zip(results,jobs):
                self.assertEqual(process.returncode,0,process.stdout+process.stderr)
                report=json.loads(process.stdout);self.assertTrue(report['accepted']);ids.append(report['run_id'])
                self.assertEqual(report['approved_task_sha256'],pin)
                flow=read(out/'job/flow.json')
                self.assertEqual(flow['assessment'],'verified_event_slice')
                frozen=out/'job'/flow['source_snapshot']['workspace']
                self.assertTrue((frozen/'task.json').exists())
                self.assertTrue((out/'verification.json').exists())
            self.assertEqual(len(set(ids)),2)

    def test_external_client_rejects_a_task_digest_mismatch(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'client'
            p=subprocess.run([sys.executable,str(ROOT/'examples/run_spec_candidate.py'),'--workspace',str(ROOT),'--task','flows/udp-header.json','--task-sha256','0'*64,'--out',str(out)],cwd=tmp,text=True,capture_output=True,timeout=30)
            self.assertEqual(p.returncode,1)
            r=json.loads(p.stdout);self.assertFalse(r['accepted']);self.assertEqual(r['run_returncode'],2)
            self.assertIsNone(r['verify_returncode']);self.assertFalse((out/'job').exists())
            self.assertEqual(len(r['client_source_sha256']),64)

    def test_all_sources_and_independent_oracles_are_pinned(self):
        t=read(ROOT/'flows/udp-header.json')
        for source in t['sources']:self.assertEqual(sha(ROOT/source['path']),source['sha256'])
        rows=self.r['stages']['traceability']['data']['rules']
        refs={b['source']for b in t['requirement_bindings'].values()}
        self.assertEqual(refs,{'rfc768','rfc1122','udp-profile'})
        self.assertEqual(len(rows),7)
        self.assertFalse(self.r['stages']['traceability']['data']['english_to_ir_correctness_proved'])


if __name__=='__main__':unittest.main()
