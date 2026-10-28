import copy
import importlib.util
import unittest

from protocol_lab.ir import Machine, ModelError, POST_SEMANTICS, validate
from protocol_lab.profiles import graph
from protocol_lab.symbolic import Encoding, crosscheck_trace, encode_trace, replay


def model():
    return {'ir_version':'0.2','semantics':POST_SEMANTICS,'protocol':'post-target-test',
            'scope':{'terminal_states':[]},'states':['A','B','C'],'initial_state':'A',
            'requirements':{'S':{'source':'docs/semantics.md','interpretation':'Generic post action targets and conditional output'}},
            'variables':{'x':{'type':'int','initial':0}},
            'events':{'go':{'origin':'application','fields':{'n':'int','b':'bytes'}}},
            'messages':{'out':{'fields':{'value':'int'}}},'timers':{},
            'transitions':[{'id':'GO','from':'A','to':'A','event':'go','guard':True,
                'actions':[{'set':{'var':'x','value':{'event':'n'}}},
                  {'emit_if':{'when':{'op':'ge','args':[{'var':'x'},1]},'message':'out','fields':{'value':{'var':'x'}}}},
                  {'set':{'var':'x','value':{'op':'add','args':[{'var':'x'},1]}}},
                  {'emit_if':{'when':{'op':'ge','args':[{'var':'x'},3]},'message':'out','fields':{'value':{'var':'x'}}}}],
                'target_cases':[{'when':{'op':'ge','args':[{'var':'x'},3]},'to':'C'},
                                {'when':{'op':'ge','args':[{'var':'x'},1]},'to':'B'}],
                'requirements':['S']}],
            'invariants':[{'id':'C-bound','assert':{'op':'implies','args':[{'state':'C'},{'op':'ge','args':[{'var':'x'},3]}]},'requirements':['S']}]}


class PostTargetTests(unittest.TestCase):
    def test_targets_observe_final_assignments_outputs_observe_emission_position(self):
        for n,state,outputs in [(-2,'A',[]),(1,'B',[1]),(2,'C',[2,3])]:
            m=Machine(model());m.dispatch('go',{'n':n,'b':[]})
            self.assertEqual(m.state,state)
            self.assertEqual([o['fields']['value']for o in m.trace[-1]['emitted']],outputs)
        self.assertIn('"A" -> "C"',graph(model()))
        self.assertIn('post case 1',graph(model()))

    def test_source_state_remains_visible_until_target_commit(self):
        m=model();m['transitions'][0]['target_cases']=[{'when':{'state':'A'},'to':'B'}]
        runtime=Machine(m);runtime.dispatch('go',{'n':2,'b':[]})
        self.assertEqual(runtime.state,'B')

    def test_false_emit_is_statically_checked_and_old_semantics_reject_features(self):
        m=model();m['transitions'][0]['actions'][1]['emit_if']['when']=False
        m['transitions'][0]['actions'][1]['emit_if']['fields']['value']='wrong'
        with self.assertRaisesRegex(ModelError,'field type'):validate(m)
        for feature in ('targets','emit'):
            m=model();m['semantics']='flat-efsm-atomic-ordered-v1'
            if feature=='emit':del m['transitions'][0]['target_cases']
            with self.assertRaisesRegex(ModelError,'versioned'):validate(m)

    def test_target_shape_type_and_state_fail_closed(self):
        for change in ({'when':1,'to':'B'},{'when':True,'to':'missing'},{'when':True,'to':'B','callback':'f'}):
            m=model();m['transitions'][0]['target_cases']=[change]
            with self.assertRaises(ModelError):validate(m)

    def test_failure_after_conditional_output_and_target_rolls_back(self):
        m=model();m['transitions'][0]['target_cases'][0]['when']=True
        runtime=Machine(m);before=copy.deepcopy(runtime.snapshot())
        with self.assertRaisesRegex(ModelError,'C-bound'):runtime.dispatch('go',{'n':0,'b':[]})
        self.assertEqual(runtime.snapshot(),before);self.assertEqual(runtime.trace,[])


@unittest.skipUnless(importlib.util.find_spec('z3'),'Z3 required')
class SymbolicPostTargetTests(unittest.TestCase):
    def test_independent_encoding_matches_conditions_priority_and_output_order(self):
        for n in (-2,1,2):
            m=Machine(model());m.dispatch('go',{'n':n,'b':[]})
            self.assertEqual(crosscheck_trace(m.model,m.trace)['status'],'match')

    def test_wrong_target_has_independent_invariant_counterexample_and_replay(self):
        good=Machine(model());good.dispatch('go',{'n':0,'b':[]})
        bad=model();bad['transitions'][0]['target_cases'][0]['when']=True
        enc=encode_trace(bad,good.trace);z=enc.z
        enc.solver.add(z.Not(enc.expr(bad['invariants'][0]['assert'],enc.frames[1])))
        self.assertEqual(enc.solve(),z.sat)
        self.assertEqual(replay(bad,enc.witness(enc.solver.model()))['status'],'runtime_rejected')

    def test_length_projection_rejects_content_in_post_target_or_conditional_emit(self):
        for location in ('target','emit'):
            m=model();predicate={'op':'eq','args':[{'event':'b'},{'bytes':[]}]}
            if location=='target':m['transitions'][0]['target_cases'][0]['when']=predicate
            else:m['transitions'][0]['actions'][1]['emit_if']['when']=predicate
            with self.assertRaisesRegex(ModelError,'content'):
                Encoding(m,1,(),byte_encoding='length')

    def test_induction_enumerates_default_and_all_declared_destinations(self):
        import json
        from pathlib import Path
        import tempfile
        from protocol_lab.inductive import prove, verify
        from protocol_lab.symbolic import check
        self.assertEqual(check(model(),depth=2,symbolic_initials=())['status'],'bounded_pass')
        with tempfile.TemporaryDirectory() as tmp:
            result=prove(model(),symbolic_initials=(),out=tmp)
            self.assertEqual(result['status'],'inductive_invariants_pass')
            targets=result['preservation'][0]['targets']
            self.assertEqual([r['state']for r in targets],['A','B','C'])
            self.assertTrue(all(r['query']=='unsat'for r in targets))
            self.assertEqual(verify(model(),tmp)['status'],'valid_inductive_artifacts')
            result['preservation'][0]['targets'].pop()
            (Path(tmp)/'result.json').write_text(json.dumps(result))
            with self.assertRaisesRegex(ModelError,'Missing target'):
                verify(model(),tmp)
