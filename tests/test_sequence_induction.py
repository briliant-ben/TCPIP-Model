"""Full sequence obligations are separate from BMC/wire/compiler correctness."""
import copy
import contextlib
import io
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch
import z3
from protocol_lab.ir import load,model_files
from protocol_lab.sequence_induction import prove,verify
from protocol_lab.pipeline.task import load_task,read,write,sha
from protocol_lab.pipeline import runner

ROOT=Path(__file__).resolve().parents[1]


class SequenceInductionTests(unittest.TestCase):
    def model(self):return load(ROOT/'model/arp-udp-transmit.json')

    def test_full_sequence_obligations_complete_without_reference_callbacks(self):
        with tempfile.TemporaryDirectory()as temporary:
            with patch('protocol_lab.ir.Machine.dispatch',side_effect=AssertionError('Reference used in constraints')):
                report=prove(self.model(),out=temporary)
            self.assertEqual(report['status'],'inductive_invariants_pass');self.assertEqual(len(report['preservation']),30);self.assertEqual(len(report['overlap']),4)
            self.assertTrue(all(r['obligation']['query']=='unsat'and r['nonvacuity']['query']=='sat'for r in report['preservation']))
            self.assertEqual(verify(self.model(),temporary)['query_files'],66);self.assertFalse(report['wire_content_proved']);self.assertFalse(report['unbounded_protocol_proof'])

    def test_uncleared_failed_queue_is_a_preservation_failure_not_reachable_trace_claim(self):
        bad=self.model();rule=next(t for t in bad['transitions']if t['id']=='QUERY-FAIL-QUEUED');rule['actions'].pop()
        report=prove(bad);row=next(t for t in report['preservation']if t['rule']=='QUERY-FAIL-QUEUED')
        self.assertEqual(report['status'],'inductive_obligation_failure');self.assertEqual(row['obligation']['query'],'sat');self.assertTrue(row['obligation']['counterexample_model_sexpr']);self.assertEqual(report['failed_prestate_reachability'],'not_claimed')

    def test_initial_violation_is_not_masked_by_any_future_transition_choice(self):
        bad=self.model();bad['variables']['pending_packet']['initial']=[0]*28
        report=prove(bad);self.assertEqual(report['initial_query']['query'],'sat');self.assertEqual(report['status'],'inductive_obligation_failure')

    def test_unknown_report_or_missing_rule_cannot_be_promoted(self):
        with tempfile.TemporaryDirectory()as temporary:
            def uncertain(enc):enc.solver_error='forced_test_unknown';return z3.unknown
            with patch('protocol_lab.symbolic.Encoding.solve',autospec=True,side_effect=uncertain):report=prove(self.model(),out=temporary)
            self.assertEqual(report['status'],'unknown')
            with self.assertRaises(ValueError):verify(self.model(),temporary)
            self.assertEqual(verify(self.model(),temporary,require_pass=False)['status'],'valid_unresolved_inductive_bindings')
            p=Path(temporary)/'result.json';report['status']='inductive_invariants_pass';p.write_text(json.dumps(report))
            with self.assertRaisesRegex(ValueError,'promoted'):verify(self.model(),temporary)
        with tempfile.TemporaryDirectory()as temporary:
            report=prove(self.model(),out=temporary);report['preservation'].pop();(Path(temporary)/'result.json').write_text(json.dumps(report))
            with self.assertRaisesRegex(ValueError,'omitted'):verify(self.model(),temporary)

    def test_unsupported_semantics_and_false_wire_scope_are_rejected(self):
        bad=self.model();bad['scope']['terminal_states']=['RESOLVED']
        with self.assertRaisesRegex(ValueError,'terminal'):prove(bad)
        bad=self.model();bad['ir_version']='0.3'
        with self.assertRaises(ValueError):prove(bad)
        with tempfile.TemporaryDirectory()as temporary:
            report=prove(self.model(),out=temporary);report['wire_content_proved']=True;(Path(temporary)/'result.json').write_text(json.dumps(report))
            with self.assertRaisesRegex(ValueError,'broadened'):verify(self.model(),temporary)

    def test_v4_is_explicit_and_legacy_depth_config_is_unchanged(self):
        task=read(ROOT/'flows/arp-udp-transmit.json')
        with tempfile.NamedTemporaryFile(mode='w+',suffix='.json',dir=ROOT)as file:
            def admit(value):file.seek(0);file.truncate();json.dump(value,file);file.flush();return load_task(file.name,ROOT)
            self.assertEqual(admit(task)['formal']['strategy'],'sequence-invariant-induction')
            bad=copy.deepcopy(task);bad['formal']['depth']=3
            with self.assertRaises(ValueError):admit(bad)
            bad=copy.deepcopy(task);bad['schema']='spec-flow-task-v2'
            with self.assertRaises(ValueError):admit(bad)
            legacy=read(ROOT/'flows/arp-endpoint.json');self.assertEqual(admit(legacy)['formal']['depth'],3)

    @unittest.skipUnless(shutil.which('cc'),'Actual C compiler required')
    def test_actual_v4_ten_stage_and_rehashed_unknown_obligation_gate(self):
        task=read(ROOT/'flows/arp-udp-transmit.json')
        with tempfile.TemporaryDirectory()as temporary:
            root=Path(temporary);workspace=root/'workspace';workspace.mkdir()
            names={task['model'],task['exploration'],*task['seeds'],*(s['path']for s in task['sources'])}
            names|={str(p.relative_to(ROOT))for p in model_files(ROOT/task['model'])}
            for name in names:
                p=workspace/name;p.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/name,p)
            filename=workspace/'task.json';write(filename,task)
            with contextlib.redirect_stdout(io.StringIO()):result=runner.run(filename,workspace,root/'run',sha(filename))
            self.assertEqual(result['assessment'],'verified_event_slice');out=root/'run';runner.verify(out,workspace,sha(filename))
            self.assertEqual(result['stages']['formal']['data']['status'],'inductive_invariants_pass')
            # Rehash every affected evidence container: verdict must still reject UNKNOWN.
            formal=result['stages']['formal'];formal['data']['preservation'][0]['obligation']['query']='unknown'
            write(out/'stages/formal/queries/result.json',formal['data']);write(out/'stages/formal/result.json',formal)
            result['outputs']={p.relative_to(out).as_posix():sha(p)for p in out.rglob('*')if p.is_file()and p!=out/'flow.json'};write(out/'flow.json',result)
            with self.assertRaisesRegex(ValueError,'promoted'):runner.verify(out,workspace,sha(filename))
