"""Integration fault controls for supplementary induction, including relocation."""
import copy
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch

from formal.partition_queries import PartitionInconclusive
from protocol_lab.claims import build
from protocol_lab.inductive import prove
from protocol_lab.ir import ModelError, POST_SEMANTICS
from protocol_lab.refinement import PASS, checker_sources, digest, read, refine, verify, write


def model():
    return {'ir_version':'0.2','semantics':POST_SEMANTICS,'protocol':'refinement-test',
        'scope':{'terminal_states':[]},'states':['A','B'],'initial_state':'A',
        'requirements':{'S':{'source':'docs/semantics.md','interpretation':'Typed induction test'}},
        'variables':{'x':{'type':'int','initial':0}},
        'events':{'go':{'origin':'application','fields':{'n':'int'}}},'messages':{},'timers':{},
        'transitions':[{'id':'GO','from':'A','to':'A','event':'go',
            'guard':{'op':'ge','args':[{'event':'n'},0]},
            'actions':[{'set':{'var':'x','value':{'event':'n'}}}],
            'target_cases':[{'when':{'op':'ge','args':[{'var':'x'},1]},'to':'B'}], 'requirements':['S']}],
        'invariants':[{'id':'nonnegative','assert':{'op':'ge','args':[{'var':'x'},0]},'requirements':['S']},
            {'id':'B-positive','assert':{'op':'implies','args':[{'state':'B'},{'op':'ge','args':[{'var':'x'},1]}]},'requirements':['S']}]}


class RefinementTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory();self.addCleanup(self.tmp.cleanup)
        self.root=Path(self.tmp.name);self.primary=self.root/'inductive';self.out=self.root/'refinement'
        self.model=model();self.original=prove(self.model,symbolic_initials=(),out=self.primary)
        self.assertEqual(self.original['status'],'inductive_invariants_pass')

    def unknown_fixture(self):
        # Resource-status injection only: real exported formulas remain unchanged.
        r=copy.deepcopy(self.original);r['status']='unknown'
        for row in r['preservation']:
            row['query']='unknown'
            for t in row['targets']:t.update(query='unknown',reason='unit resource-status fixture')
        for key in ('sample_query','sample_witness','replay'):r.pop(key,None)
        r['query_hashes'].pop('sample.smt2');(self.primary/'sample.smt2').unlink()
        write(self.primary/'result.json',r)
        return r

    def artifacts(self,r):
        p=read(self.primary/'result.json')
        return {**{'inductive/'+n:digest(self.primary/n)for n in (*p['query_hashes'],'result.json')},
                **{'inductive-refinement/'+n:digest(self.out/n)for n in (*r['artifact_hashes'],'result.json')}}

    def test_actual_refinements_keep_original_unknown_and_need_nonempty_replay(self):
        primary=self.unknown_fixture();before=(self.primary/'result.json').read_bytes()
        r=refine(self.model,self.primary,self.out,group_size=1)
        self.assertEqual(r['status'],PASS);self.assertEqual(r['primary_status'],'unknown')
        self.assertEqual(len(r['partitions']),2);self.assertEqual(r['sample_query'],'sat')
        self.assertEqual(r['replay']['status'],'match')
        self.assertEqual((self.primary/'result.json').read_bytes(),before)
        self.assertEqual(verify(self.model,self.primary,self.out)['status'],'valid_refined_induction_evidence')
        claims=build(self.model,{'id':'test','inductive_refinement':True,'inductive_refinement_group_size':1},checker_sources(),[],{'status':'not_run'},primary,self.artifacts(r),refinement=r)
        self.assertEqual(claims['claims'][1]['status'],'unknown')
        self.assertEqual(claims['claims'][3]['status'],'verified_refined_inductive_state_properties')
        self.assertFalse(claims['claims'][3]['kernel_checked_proof'])
        self.assertEqual(claims['claims'][3]['statement']['original_unknown_targets'],r['original_unknown_targets'])

    def test_passing_primary_is_not_relabelled_as_a_new_refinement(self):
        r=refine(self.model,self.primary,self.out)
        self.assertEqual(r['status'],'not_needed_primary_pass');self.assertEqual(r['partitions'],[])
        self.assertEqual(verify(self.model,self.primary,self.out)['status'],'valid_refined_induction_evidence')

    def test_missing_target_and_foreign_label_cannot_be_promoted(self):
        primary=self.unknown_fixture();r=refine(self.model,self.primary,self.out)
        for kind in ('missing','label'):
            bad=copy.deepcopy(r)
            if kind=='missing':bad['partitions'].pop()
            else:bad['partitions'][0]['label']='FOREIGN -> B'
            write(self.out/'result.json',bad)
            with self.subTest(kind=kind),self.assertRaises(ModelError):verify(self.model,self.primary,self.out)
            with self.subTest(kind=kind),self.assertRaises(ModelError):
                build(self.model,{'id':'test','inductive_refinement':True},checker_sources(),[],{'status':'not_run'},primary,self.artifacts(bad),refinement=bad)

    def test_unresolved_initial_query_is_not_silently_omitted(self):
        primary=self.unknown_fixture();primary['initial_query']='unknown';write(self.primary/'result.json',primary)
        r=refine(self.model,self.primary,self.out)
        self.assertEqual(r['status'],'refinement_unavailable');self.assertEqual(r['partitions'],[])
        self.assertEqual(verify(self.model,self.primary,self.out)['status'],'valid_pending_refinement_bindings')

    def test_independent_timeout_remains_unknown_even_when_partition_generation_passes(self):
        primary=self.unknown_fixture()
        with patch('protocol_lab.refinement.partitioner.verify',side_effect=PartitionInconclusive('unit verification timeout')):
            r=refine(self.model,self.primary,self.out)
        self.assertEqual(r['status'],'refinement_unknown')
        self.assertTrue(all(p['verification']['status']=='unknown'for p in r['partitions']))
        claims=build(self.model,{'id':'test','inductive_refinement':True},checker_sources(),[],{'status':'not_run'},primary,self.artifacts(r),refinement=r)
        self.assertEqual(claims['claims'][3]['status'],'unknown')
        bad=copy.deepcopy(r);bad['status']=PASS;write(self.out/'result.json',bad)
        with self.assertRaisesRegex(ModelError,'inconclusive'):verify(self.model,self.primary,self.out)

    def test_rehashed_omitted_constraint_is_rejected_by_integrated_checker(self):
        self.unknown_fixture();r=refine(self.model,self.primary,self.out,group_size=1)
        part=r['partitions'][0];folder=self.out/part['directory'];record=read(folder/'result.json')
        name=record['groups'][0]['file'];p=folder/name
        from formal.partition_queries import z3
        assertions=list(z3.parse_smt2_string(p.read_text()))
        solver=z3.Solver();solver.add(*assertions[1:]);p.write_text(solver.to_smt2())
        record['query_hashes'][name]=digest(p);write(folder/'result.json',record)
        for file in (p,folder/'result.json'):r['artifact_hashes'][str(file.relative_to(self.out))]=digest(file)
        write(self.out/'result.json',r)
        with self.assertRaisesRegex(ValueError,'original constraint'):verify(self.model,self.primary,self.out)

    def test_relocated_evidence_uses_bound_current_primary_not_old_absolute_path(self):
        self.unknown_fixture();refine(self.model,self.primary,self.out)
        moved=self.root/'moved';shutil.copytree(self.primary,moved/'primary');shutil.copytree(self.out,moved/'refined')
        shutil.rmtree(self.primary);shutil.rmtree(self.out)
        self.assertEqual(verify(self.model,moved/'primary',moved/'refined')['status'],'valid_refined_induction_evidence')

    def test_primary_file_or_model_change_is_rejected(self):
        self.unknown_fixture();refine(self.model,self.primary,self.out)
        m=copy.deepcopy(self.model);m['variables']['x']['initial']=1
        with self.assertRaisesRegex(ModelError,'model mismatch'):verify(m,self.primary,self.out)
        p=self.primary/'preservation.smt2';p.write_text(p.read_text()+'; changed\n')
        with self.assertRaisesRegex(ModelError,'Primary query changed'):verify(self.model,self.primary,self.out)

    def test_claim_cannot_omit_primary_or_refinement_evidence_files(self):
        primary=self.unknown_fixture();r=refine(self.model,self.primary,self.out)
        files=self.artifacts(r);files.pop('inductive-refinement/sample.smt2')
        with self.assertRaisesRegex(ModelError,'Missing refinement'):
            build(self.model,{'id':'test','inductive_refinement':True},checker_sources(),[],{'status':'not_run'},primary,files,refinement=r)
        bad=copy.deepcopy(r);bad['primary_result_sha256']='0'*64
        with self.assertRaisesRegex(ModelError,'primary result hash'):
            build(self.model,{'id':'test','inductive_refinement':True},checker_sources(),[],{'status':'not_run'},primary,self.artifacts(r),refinement=bad)

    def test_rehashed_missing_primary_query_block_is_rejected(self):
        primary=self.unknown_fixture();p=self.primary/'preservation.smt2'
        text=p.read_text();second=text.index('; GO -> B')
        p.write_text(text[:second]);primary['query_hashes']['preservation.smt2']=digest(p)
        write(self.primary/'result.json',primary)
        with self.assertRaisesRegex(ModelError,'label coverage'):refine(self.model,self.primary,self.out)

    def test_unsupported_primary_encoding_is_explicitly_rejected(self):
        primary=self.unknown_fixture();primary['byte_encoding']='sequence'
        write(self.primary/'result.json',primary)
        with self.assertRaisesRegex(ModelError,'Unsupported primary refinement semantics'):
            refine(self.model,self.primary,self.out)

    def test_satisfiable_state_obligation_is_not_turned_into_a_refinement(self):
        bad=copy.deepcopy(self.model);bad['transitions'][0]['guard']=True
        primary=prove(bad,symbolic_initials=(),out=self.primary)
        self.assertEqual(primary['status'],'inductive_obligations_failed')
        r=refine(bad,self.primary,self.out)
        self.assertEqual(r['status'],'refinement_unavailable')
        self.assertEqual(r['partitions'],[])

    def test_checker_code_bindings_and_nonempty_sample_are_required(self):
        primary=self.unknown_fixture();r=refine(self.model,self.primary,self.out)
        with self.assertRaisesRegex(ModelError,'checker code bindings'):
            build(self.model,{'id':'test','inductive_refinement':True},{},[],{'status':'not_run'},primary,self.artifacts(r),refinement=r)
        r.pop('sample_witness');r['sample_query']='unknown';write(self.out/'result.json',r)
        with self.assertRaisesRegex(ModelError,'nonempty full-byte'):verify(self.model,self.primary,self.out)

    def test_empty_or_different_initial_domain_witness_cannot_close_refinement(self):
        self.unknown_fixture();r=refine(self.model,self.primary,self.out)
        for kind in ('empty','initial'):
            bad=copy.deepcopy(r)
            if kind=='empty':bad['sample_witness']['steps']=[]
            else:bad['sample_witness']['initial']['x']=9
            write(self.out/'result.json',bad)
            with self.subTest(kind=kind),self.assertRaises(ModelError):verify(self.model,self.primary,self.out)
