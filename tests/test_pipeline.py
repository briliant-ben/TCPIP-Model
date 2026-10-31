"""Real fixed-stage orchestration, source isolation and verdict/integrity gates."""
import concurrent.futures
import contextlib
import copy
import importlib.util
import io
import json
import os
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch
from protocol_lab.pipeline import runner
from protocol_lab.pipeline.runner import run,verify,child
from protocol_lab.pipeline.task import read,write,sha,load_task
ROOT=Path(__file__).resolve().parents[1]
READY=bool(shutil.which('cc')and importlib.util.find_spec('z3'))


def quiet_run(task,workspace,out):
    # Worker logs are always retained in out. Only progress JSONL is hidden here.
    with contextlib.redirect_stdout(io.StringIO()):return run(task,workspace,out,expected_task_sha256=sha(task))


def fixture(root):
    root.mkdir();t=read(ROOT/'flows/tcp-active-open.json')
    names={t['model'],t['exploration'],*t['seeds'],*(s['path']for s in t['sources'])}
    for name in names:
        p=root/name;p.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/name,p)
    write(root/'task.json',t);return root/'task.json'


@unittest.skipUnless(READY,'Native C compiler and Z3 required for actual pipeline execution')
class PipelineTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp=tempfile.TemporaryDirectory();cls.root=Path(cls.temp.name)
        cls.out=cls.root/'baseline';cls.report=quiet_run(ROOT/'flows/tcp-active-open.json',ROOT,cls.out)
    @classmethod
    def tearDownClass(cls):cls.temp.cleanup()

    def test_actual_pipeline_has_all_stages_generated_cases_and_independent_native_results(self):
        r=self.report;self.assertEqual(r['assessment'],'verified_event_slice')
        self.assertEqual(r['stages']['formal']['data']['safety_query'],'unsat')
        self.assertEqual(r['stages']['formal']['data']['overlap_query'],'unsat')
        self.assertEqual(r['stages']['tests']['data']['covered_rules'],['T-ACCEPT-SYNACK','T-ACTIVE-OPEN','T-SYN-RETRY'])
        self.assertEqual(r['stages']['tests']['data']['negative_count'],2)
        self.assertEqual(len(r['stages']['compare']['data']['cases']),13)
        self.assertFalse(r['stages']['execute']['data']['reference_values_supplied'])
        self.assertFalse(r['stages']['traceability']['data']['english_to_ir_correctness_proved'])
        self.assertEqual(verify(self.out,ROOT)['status'],'retained_evidence_consistent')

    def test_wire_task_runs_generated_ipv4_implementation_and_checks_coverage(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'wire';r=quiet_run(ROOT/'flows/tcp-active-open-ipv4.json',ROOT,out)
            self.assertEqual(r['assessment'],'verified_event_slice')
            rows=r['stages']['execute']['data']['wire_cases']
            self.assertEqual(len(rows),5)
            self.assertTrue(all(w['status']=='pass'for w in rows))
            for w in rows:
                e=read(out/w['path'])
                self.assertGreaterEqual(e['native_egress_packets'],2)
                self.assertFalse(e['linux_tcp_network_evidence'])
            self.assertEqual(verify(out,ROOT)['assessment'],'verified_event_slice')
            r['stages']['execute']['data']['wire_cases']=rows[:-1];write(out/'flow.json',r)
            with self.assertRaisesRegex(ValueError,'wire scenario coverage'):verify(out,ROOT)

    def test_wire_task_must_pin_binding_source(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);t=read(ROOT/'flows/tcp-active-open-ipv4.json')
            for name in {t['model'],t['exploration'],*t['seeds'],*(s['path']for s in t['sources'])}:
                p=root/name;p.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/name,p)
            t['sources']=[s for s in t['sources']if s['id']!='wire-binding'];write(root/'task.json',t)
            with self.assertRaisesRegex(ValueError,'pin every'):load_task(root/'task.json',root)

    def test_workers_use_frozen_inputs_and_tool_source(self):
        r=self.report;frozen=r['source_snapshot']
        self.assertEqual(r['stages']['reference']['data']['trace_contract_steps_checked'],2)
        self.assertTrue(r['task_pin_matched'])
        for name,rel in frozen['files'].items():self.assertEqual(sha(self.out/rel),r['input_hashes'][name])
        for receipt in r['workers'].values():self.assertEqual(receipt['tool_root'],str((self.out/frozen['tool']).parent.resolve()))

    def test_live_candidate_edit_cannot_mix_versions_between_stages(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace');path=task.parent/'model/tcp.json'
            original=runner.child
            def edit_then_run(name,job,seconds,tool_root=None):
                if name=='formal':
                    model=read(path);model['protocol']='edited-live-candidate';write(path,model)
                return original(name,job,seconds,tool_root)
            with patch.object(runner,'child',side_effect=edit_then_run):r=quiet_run(task,task.parent,root/'out')
            self.assertEqual(r['assessment'],'invalidated_inputs')
            hashes=[r['stages'][n]['data']['model_semantic_sha256']for n in ('ir','formal','generate')]
            self.assertEqual(len(set(hashes)),1)
            frozen_model=read(root/'out'/r['source_snapshot']['workspace']/'model/tcp.json')
            self.assertNotEqual(frozen_model['protocol'],read(path)['protocol'])

    def test_changed_native_observation_is_not_accepted(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'copy';shutil.copytree(self.out,out)
            p=out/'stages/execute/case-0000/stdout';p.write_text(p.read_text()+'\n')
            with self.assertRaisesRegex(ValueError,'changed evidence'):verify(out,ROOT)

    def test_rehashed_unknown_formal_result_cannot_be_promoted(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'copy';shutil.copytree(self.out,out);r=read(out/'flow.json')
            s=r['stages']['formal'];s['data']['status']='unknown';s['data']['safety_query']='unknown'
            write(out/'stages/formal/result.json',s)
            r['outputs']['stages/formal/result.json']=sha(out/'stages/formal/result.json');write(out/'flow.json',r)
            with self.assertRaisesRegex(ValueError,'falsely promoted'):verify(out,ROOT)

    def test_scope_promotion_is_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'copy';shutil.copytree(self.out,out);r=read(out/'flow.json');r['pcap_evidence']=True;write(out/'flow.json',r)
            with self.assertRaisesRegex(ValueError,'scope broadened'):verify(out,ROOT)

    def test_missing_compiler_blocks_only_dependent_execution_channel(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace')
            with patch.dict(os.environ,{'PATH':''}):r=quiet_run(task,task.parent,root/'out')
            self.assertEqual(r['assessment'],'blocked')
            self.assertEqual(r['stages']['formal']['status'],'pass')
            self.assertEqual(r['stages']['reference']['status'],'pass')
            self.assertEqual(r['stages']['build']['classification'],'environment')
            self.assertEqual(r['stages']['execute']['classification'],'dependency')

    def test_corrupted_spec_fails_provenance_without_falsifying_native_comparison(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace')
            p=task.parent/'spec/sources/rfc9293.txt';p.write_bytes(p.read_bytes()+b'\ncorrupted\n')
            r=quiet_run(task,task.parent,root/'out')
            self.assertEqual(r['assessment'],'failed')
            self.assertEqual(r['stages']['sources']['classification'],'source_integrity')
            self.assertEqual(r['stages']['compare']['status'],'pass')
            self.assertEqual(r['stages']['traceability']['classification'],'dependency')

    def test_native_integer_domain_limit_is_not_reported_as_an_rfc_difference(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace');t=read(task)
            m=read(task.parent/t['model']);m['variables']['rto_ms']['initial']=9223372036854775807;write(task.parent/t['model'],m)
            seed={'scenario_version':'0.1','id':'backend-domain-limit',
                  'steps':[{'at_ms':0,'event':'app.connect','fields':{}},{'at_ms':9223372036854775807,'tick':True}],
                  'expect':{'state':'SYN-SENT','timers':{'syn_rto':27670116110564327421}}}
            write(task.parent/'overflow-seed.json',seed);t['seeds']=['overflow-seed.json'];t['formal']['depth']=1
            t['sources'].append(dict(id='overflow-test-seed',path='overflow-seed.json',sha256=sha(task.parent/'overflow-seed.json'),version='test',uri_aliases=['overflow-seed.json']));write(task,t)
            r=quiet_run(task,task.parent,root/'out')
            self.assertEqual(r['assessment'],'failed')
            self.assertEqual(r['stages']['reference']['status'],'pass')
            self.assertEqual(r['stages']['compare']['classification'],'backend_domain_exceeded')

    def test_wrong_ir_message_is_caught_by_independent_trace_contract(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace');path=task.parent/'model/tcp.json';m=read(path)
            emit=next(a['emit']for a in m['transitions'][0]['actions']if 'emit'in a)
            emit['fields']['seq']={'op':'seq_add','args':[{'var':'iss'},1]};write(path,m)
            r=quiet_run(task,task.parent,root/'out')
            self.assertEqual(r['assessment'],'failed')
            self.assertEqual(r['stages']['sources']['status'],'pass')
            self.assertEqual(r['stages']['formal']['status'],'pass')
            self.assertEqual(r['stages']['reference']['classification'],'scenario_contract')
            self.assertEqual(r['stages']['compare']['classification'],'dependency')

    def test_changing_ir_and_its_oracle_together_cannot_hide_pinned_contract_violation(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace');path=task.parent/'model/tcp.json';m=read(path)
            next(a['emit']for a in m['transitions'][0]['actions']if 'emit'in a)['fields']['seq']={'op':'seq_add','args':[{'var':'iss'},1]};write(path,m)
            contract=task.parent/'scenarios/flow-contracts/active-open.json';c=read(contract)
            c['steps'][0]['expect_trace'][0]['emitted'][0]['fields']['seq']=1001;write(contract,c)
            r=quiet_run(task,task.parent,root/'out')
            self.assertEqual(r['stages']['reference']['status'],'pass')
            self.assertEqual(r['stages']['compare']['status'],'pass')
            self.assertEqual(r['stages']['sources']['classification'],'source_integrity')
            self.assertEqual(r['assessment'],'failed')

    def test_model_conflict_is_not_a_successful_negative_test(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace');path=task.parent/'model/tcp.json';m=read(path)
            duplicate=copy.deepcopy(m['transitions'][0]);duplicate['id']='CONFLICT';m['transitions'].append(duplicate);write(path,m)
            r=quiet_run(task,task.parent,root/'out')
            self.assertEqual(r['assessment'],'failed')
            self.assertEqual(r['stages']['formal']['data']['status'],'conflict')
            self.assertEqual(r['stages']['tests']['classification'],'rule_conflict')
            self.assertEqual(r['stages']['compare']['classification'],'dependency')

    def test_independent_concurrent_jobs_keep_outputs_and_run_ids_separate(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp)
            # Quiet stdout redirection is global, so concurrent workers use run
            # directly; their structured progress carries distinct run IDs.
            with concurrent.futures.ThreadPoolExecutor(max_workers=2)as pool:
                futures=[pool.submit(run,ROOT/'flows/tcp-active-open.json',ROOT,root/str(i))for i in range(2)]
                results=[f.result()for f in futures]
            self.assertNotEqual(results[0]['run_id'],results[1]['run_id'])
            for i,r in enumerate(results):
                self.assertEqual(r['assessment'],'verified_event_slice')
                self.assertEqual(verify(root/str(i),ROOT)['assessment'],'verified_event_slice')

    def test_actual_worker_timeout_is_classified_and_process_group_is_cleaned(self):
        with tempfile.TemporaryDirectory()as tmp:
            job=Path(tmp);write(job/'request.json',dict(task=read(ROOT/'flows/tcp-active-open.json'),workspace=str(ROOT)))
            r,receipt=child('formal',job,0.001)
            self.assertTrue(receipt['timed_out']);self.assertTrue(receipt['process_group_cleanup_attempted'])
            self.assertIsNotNone(receipt['returncode']);self.assertEqual(r['classification'],'resource_limit')


class PipelineTaskTests(unittest.TestCase):
    def test_task_cannot_reference_files_outside_its_workspace(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace');t=read(task);t['model']='../outside.json';write(root/'outside.json',{});write(task,t)
            with self.assertRaisesRegex(ValueError,'escapes workspace'):load_task(task,task.parent)

    def test_task_v2_requires_acceptance_input_pins(self):
        with tempfile.TemporaryDirectory()as tmp:
            task=fixture(Path(tmp)/'workspace');t=read(task)
            t['sources']=[s for s in t['sources']if s['path']!=t['seeds'][-1]];write(task,t)
            with self.assertRaisesRegex(ValueError,'must pin every seed'):load_task(task,task.parent)

    def test_caller_task_pin_rejects_weakened_configuration_before_execution(self):
        with tempfile.TemporaryDirectory()as tmp:
            task=fixture(Path(tmp)/'workspace');before=sha(task);t=read(task);t['formal']['depth']=1;write(task,t)
            out=Path(tmp)/'rejected'
            with self.assertRaisesRegex(ValueError,'caller-pinned digest'):run(task,task.parent,out,expected_task_sha256=before)
            self.assertFalse(out.exists())

    def test_task_cannot_inject_shell_or_python_commands(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);task=fixture(root/'workspace');t=read(task);t['command']='echo unsafe';write(task,t)
            with self.assertRaisesRegex(ValueError,'Unknown task fields'):load_task(task,task.parent)

if __name__=='__main__':unittest.main()
