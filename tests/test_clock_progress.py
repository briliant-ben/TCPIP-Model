"""Clock-only safety and exact fixed-choice translation, independent controls."""
import copy
import tempfile
from pathlib import Path
import unittest

from protocol_lab.ir import CLOCK_SEMANTICS, Machine, ModelError, load, evaluate
from protocol_lab.symbolic import Encoding, check, model_hash, replay
from protocol_lab.inductive import prove
from protocol_lab.refinement import refine

ROOT=Path(__file__).resolve().parents[1]


def clock_model(equal=False,timer=False):
    m={'ir_version':'0.3','semantics':CLOCK_SEMANTICS,'protocol':'clock-step-test',
       'scope':{'terminal_states':[]},'states':['A'],'initial_state':'A',
       'requirements':{'T':{'source':'docs/semantics.md','interpretation':'Clock-only operation semantics'}},
       'variables':{'seen':{'type':'int','initial':0}},'events':{'go':{'origin':'application','fields':{}}},
       'messages':{},'timers':{},'transitions':[{'id':'GO','from':'A','to':'A','event':'go','guard':True,
          'actions':[{'set':{'var':'seen','value':{'clock_ms':True}}}],'requirements':['T']}],
       'invariants':[{'id':'clock-seen','assert':{'op':'eq'if equal else'le','args':[{'var':'seen'},{'clock_ms':True}]},'requirements':['T']}]}
    if timer:
        m['events']['timer.a']={'origin':'timer','fields':{}};m['timers']['a']={'event':'timer.a'}
        m['transitions'][0]['actions'].append({'arm':{'timer':'a','delay_ms':10}})
        m['transitions'].append({'id':'TIMER','from':'A','to':'A','event':'timer.a','guard':True,
            'actions':[{'set':{'var':'seen','value':{'clock_ms':True}}}],'requirements':['T']})
    return m


class ClockProgressTests(unittest.TestCase):
    def test_empty_tick_checks_invariant_and_rolls_back_clock_state_and_trace(self):
        m=Machine(clock_model(equal=True));m.dispatch('go',time_ms=5)
        before=copy.deepcopy((m.now_ms,m.snapshot(),m.trace))
        with self.assertRaisesRegex(ModelError,'clock-seen'):m.tick(6)
        self.assertEqual((m.now_ms,m.snapshot(),m.trace),before)

    def test_dispatch_is_one_atomic_event_clock_update_not_an_extra_tick(self):
        m=Machine(clock_model(equal=True));m.dispatch('go',time_ms=5);m.dispatch('go',time_ms=10)
        self.assertEqual(m.values['seen'],10)
        m.tick(10);self.assertEqual(len(m.trace),2)

    def test_timer_events_precede_final_tick_check_and_whole_failure_rolls_back(self):
        m=Machine(clock_model(equal=True,timer=True));m.dispatch('go')
        before=copy.deepcopy((m.now_ms,m.snapshot(),m.trace))
        with self.assertRaisesRegex(ModelError,'clock-seen'):m.tick(11)
        self.assertEqual((m.now_ms,m.snapshot(),m.trace),before)
        m.tick(10);self.assertEqual(m.trace[-1]['transition'],'TIMER')
        self.assertEqual(m.values['seen'],10)

    def test_rtt_sample_uses_saved_epoch_under_quiet_time_progress(self):
        for name in ('tcp-rto','tcp-tx-history','tcp-syn-history'):
            with self.subTest(model=name):
                m=Machine(load(ROOT/'model'/f'{name}.json'));m.dispatch('app.connect')
                m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':8},10)
                m.tick(20);m.tick(99)
                self.assertEqual(m.values['rtt_last_ms'],10)
                self.assertEqual(m.values['rtt_sample_at_ms'],10)
                self.assertTrue(all(evaluate(i['assert'],m)for i in m.model['invariants']))

    def test_wrong_sample_epoch_is_detected_not_hidden_by_idle_tick(self):
        model=load(ROOT/'model/tcp-rto.json')
        for rule in model['transitions']:
            for action in rule['actions']:
                setting=action.get('set',{})
                if setting.get('var')=='rtt_sample_at_ms'and isinstance(setting['value'],dict)and setting['value'].get('op')=='ite'and setting['value']['args'][1]=={'clock_ms':True}:
                    setting['value']['args'][1]=0
        m=Machine(model);m.dispatch('app.connect')
        with self.assertRaisesRegex(ModelError,'T-INV-KARN'):m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':8},10)

    def test_bmc_finds_clock_only_counterexample_and_reference_rejects_it(self):
        r=check(clock_model(equal=True),depth=1,symbolic_initials=())
        self.assertEqual(r['status'],'counterexample')
        self.assertEqual(r['counterexample']['steps'][0]['origin'],'clock')
        self.assertEqual(r['replay']['status'],'runtime_rejected')
        self.assertIn('clock-seen',r['replay']['error'])
        self.assertEqual(r['clock_progress'],'monotonic_integer_before_next_due')

    def test_clock_progress_is_checked_even_for_declared_terminal_state(self):
        m=clock_model(equal=True);m['scope']['terminal_states']=['A']
        r=check(m,depth=1,symbolic_initials=())
        self.assertEqual(r['status'],'counterexample')
        self.assertEqual(r['counterexample']['steps'][0]['origin'],'clock')

    def test_monotone_clock_invariant_has_bounded_and_inductive_evidence(self):
        m=clock_model();r=check(m,depth=3,symbolic_initials=())
        self.assertEqual(r['status'],'bounded_pass')
        with tempfile.TemporaryDirectory()as tmp:
            i=prove(m,symbolic_initials=(),out=tmp)
            self.assertEqual(i['status'],'inductive_invariants_pass')
            self.assertEqual(i['clock_advance_query'],'unsat')
            self.assertIn('clock-preservation.smt2',i['query_hashes'])

    def test_clock_induction_failure_is_not_skipped_by_query_refinement(self):
        m=clock_model(equal=True)
        with tempfile.TemporaryDirectory()as tmp:
            primary=Path(tmp)/'primary';out=Path(tmp)/'refined'
            i=prove(m,symbolic_initials=(),out=primary)
            self.assertEqual(i['clock_advance_query'],'sat')
            self.assertEqual(i['status'],'inductive_obligations_failed')
            r=refine(m,primary,out)
            self.assertEqual(r['status'],'refinement_unavailable')

    def test_clock_branch_cannot_skip_due_timer_or_stand_in_for_sample(self):
        m=clock_model(timer=True);enc=Encoding(m,2,());z=enc.z
        enc.solver.add(z.Int('choice_0')==0,enc.frames[1]['now']==0,z.Int('choice_1')==-2)
        enc.solver.push();enc.solver.add(enc.frames[2]['now']==10)
        self.assertEqual(enc.solve(),z.unsat);enc.solver.pop()
        enc.solver.add(enc.frames[2]['now']==9);self.assertEqual(enc.solve(),z.sat)
        self.assertEqual(replay(m,enc.witness(enc.solver.model()))['status'],'match')
        empty=clock_model();empty['transitions'][0]['guard']=False
        self.assertEqual(check(empty,depth=1,symbolic_initials=())['status'],'vacuous')

    def test_clock_witness_cannot_hide_real_timer_firing(self):
        m=clock_model(timer=True);runtime=Machine(m);runtime.dispatch('go');runtime.tick(20)
        initial={k:v['initial']for k,v in m['variables'].items()}
        enc=Encoding(m,1,());z=enc.z;enc.solver.add(z.Int('choice_0')==0,enc.frames[1]['now']==0)
        self.assertEqual(enc.solve(),z.sat);w=enc.witness(enc.solver.model())
        w['steps'].append({'origin':'clock','event':None,'transition':'@clock_advance','fields':{},'at_ms':20,'after':runtime.snapshot(),'emitted':[]})
        self.assertEqual(replay(m,w)['status'],'semantic_mismatch')

    def test_fixed_choice_encoding_is_equivalent_to_full_relation_and_faults(self):
        m=clock_model(timer=True)
        for j in range(len(m['transitions'])):
            full=Encoding(m,1,tuple(m['variables']),arbitrary_state=True)
            reduced=Encoding(m,1,tuple(m['variables']),arbitrary_state=True,fixed_choices=[j])
            z=full.z;full.solver.add(z.Int('choice_0')==j)
            solver=z.Solver();solver.add(z.Xor(z.And(*full.solver.assertions()),z.And(*reduced.solver.assertions())))
            self.assertEqual(solver.check(),z.unsat)
            solver=z.Solver();solver.add(*full.solver.assertions(),z.Xor(z.Or(*full.action_faults),z.Or(*reduced.action_faults)))
            self.assertEqual(solver.check(),z.unsat)
            self.assertEqual(len(full.enabled[0]),len(reduced.enabled[0]))
        for choices in ([-2],[-1],[True],[0,0],[99]):
            with self.subTest(choices=choices),self.assertRaisesRegex(ModelError,'Invalid fixed rule'):
                Encoding(m,1,(),fixed_choices=choices)

    def test_claims_cannot_reuse_clock_omitting_bounded_or_inductive_results(self):
        from protocol_lab.claims import build
        m=clock_model();formal=check(m,depth=1,symbolic_initials=())
        artifacts={name:'0'*64 for name in ('formal/result.json','formal/model.smt2','formal/overlap.smt2')}
        bad=copy.deepcopy(formal);bad.pop('clock_progress')
        with self.assertRaisesRegex(ModelError,'clock progress coverage'):
            build(m,{'id':'clock'},{},[],bad,{'status':'not_run'},artifacts)
        with tempfile.TemporaryDirectory()as tmp:
            i=prove(m,symbolic_initials=(),out=tmp)
            files={'inductive/'+name:'0'*64 for name in (*i['query_hashes'],'result.json')}
            bad=copy.deepcopy(i);bad.pop('clock_advance_query')
            with self.assertRaisesRegex(ModelError,'clock obligation'):
                build(m,{'id':'clock'},{},[],{'status':'not_run'},bad,files)
            bad=copy.deepcopy(i);bad['query_hashes'].pop('clock-preservation.smt2')
            with self.assertRaisesRegex(ModelError,'clock query'):
                build(m,{'id':'clock'},{},[],{'status':'not_run'},bad,files)

    def test_clock_unknown_and_missing_clock_query_cannot_be_refined_away(self):
        from protocol_lab.refinement import write
        m=clock_model()
        with tempfile.TemporaryDirectory()as tmp:
            primary=Path(tmp)/'primary';out=Path(tmp)/'out'
            i=prove(m,symbolic_initials=(),out=primary)
            i['status']='unknown';i['clock_advance_query']='unknown'
            write(primary/'result.json',i)
            self.assertEqual(refine(m,primary,out)['status'],'refinement_unavailable')
            i['query_hashes'].pop('clock-preservation.smt2');write(primary/'result.json',i)
            with self.assertRaisesRegex(ModelError,'Missing primary query'):
                refine(m,primary,out)

    def test_fixed_trace_optimization_does_not_hide_a_conflicting_rule(self):
        from protocol_lab.symbolic import crosscheck_trace
        m=clock_model();runtime=Machine(m);runtime.dispatch('go',time_ms=5)
        bad=copy.deepcopy(m);other=copy.deepcopy(bad['transitions'][0]);other['id']='CONFLICT'
        bad['transitions'].append(other)
        r=crosscheck_trace(bad,runtime.trace)
        self.assertEqual(r['status'],'runtime_rejected')
        self.assertIn('Overlapping rules',r['replay']['error'])
