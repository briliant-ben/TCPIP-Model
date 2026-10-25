"""RFC 6298 numeric examples and independent fault controls for the finite profile."""
import copy
import importlib.util
import unittest

from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.ir import MOD, Machine, ModelError, load
from protocol_lab.symbolic import crosscheck_trace


def established(at=10, initial=None, model=None):
    machine = Machine(model or load(ROOT/'model/tcp-rto.json'), initial)
    machine.dispatch('app.connect')
    machine.dispatch('net.synack', {'seq':9000,'ack':machine.values['snd_nxt'],'window':16}, at)
    return machine


def send(machine, at, data):
    machine.dispatch('app.send', {'data':data}, at)
    machine.dispatch('app.transmit', time_ms=at+1)


def ack(machine, at, number):
    machine.dispatch('net.ack', {'seq':9001,'ack':number,'window':16}, at)


class RtoTests(unittest.TestCase):
    def test_hand_calculated_scenarios_and_inherited_corpus(self):
        model=load(ROOT/'model/tcp-rto.json')
        for directory in ('rto','data','reassembly','segments','close','fin','connection'):
            for path in sorted((ROOT/'scenarios'/directory).glob('*.json')):
                with self.subTest(scenario=path.stem):
                    scenario=read(path)
                    if directory=='connection':
                        for step in scenario['steps']:
                            if step.get('event')in ('net.ack','net.synack'):step['fields']['window']=8
                    run_scenario(model,scenario)

    def test_fresh_connection_resets_cached_estimator_at_actual_open(self):
        initial={'srtt_ms':{'n':2000,'d':1},'rttvar_ms':{'n':1000,'d':1},
                 'rtt_samples':1,'rtt_measured':True,'rto_base_ms':6000,'rto_ms':6000}
        m=established(initial=initial)
        self.assertEqual(m.values['rtt_samples'],1)
        self.assertEqual(m.values['srtt_ms'],{'n':10,'d':1})
        self.assertEqual(m.values['rto_ms'],1000)

    def test_partial_retransmission_overlap_makes_anchor_ambiguous(self):
        m=established();send(m,20,[0,128,255,7]);ack(m,30,1003)
        m.tick(1030)
        self.assertTrue(m.values['rtt_ambiguous'])
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'],[255,7])
        ack(m,1100,1005)
        self.assertEqual(m.values['rtt_samples'],1)
        self.assertEqual(m.values['rto_ms'],2000)

    def test_nonoverlapping_old_prefix_does_not_taint_later_anchor(self):
        m=established();send(m,20,list(range(8)));m.dispatch('app.transmit',time_ms=22)
        ack(m,30,1005)  # first sample completes; second segment still outstanding
        send(m,40,[8,9,10,11])  # third segment becomes the new anchor
        self.assertEqual(m.values['rtt_end'],1013)
        self.assertEqual(m.timers['rtx'],1030)  # more data cannot postpone old timer
        m.tick(1030)
        self.assertFalse(m.values['rtt_ambiguous'])
        ack(m,1100,1013)
        self.assertEqual(m.values['rtt_samples'],3)
        self.assertEqual(m.values['rtt_last_ms'],1059)

    def test_fresh_data_replaces_ambiguous_anchor_without_using_old_ack(self):
        m=established();send(m,20,[0,1,2,3]);m.tick(1021)
        send(m,1100,[4,5,6,7])
        self.assertFalse(m.values['rtt_ambiguous']);self.assertEqual(m.values['rtt_start_ms'],1101)
        ack(m,1150,1005)
        self.assertEqual(m.values['rtt_samples'],1);self.assertTrue(m.values['rtt_active'])
        ack(m,1201,1009)
        self.assertEqual(m.values['rtt_last_ms'],100);self.assertEqual(m.values['rtt_samples'],2)

    def test_sample_anchor_and_partial_ack_wrap_full_sequence_space(self):
        m=established(initial={'iss':MOD-3});send(m,20,[0,128,255,7])
        self.assertEqual(m.values['rtt_end'],2)
        ack(m,30,0);self.assertEqual(m.values['rtt_remaining'],2)
        ack(m,121,2)
        self.assertEqual(m.values['rtt_last_ms'],100);self.assertEqual(m.values['rtt_samples'],2)
        self.assertEqual(m.timers,{})

    def test_backoff_saturates_at_optional_sixty_second_limit(self):
        m=established();send(m,20,[1])
        for expected in (2000,4000,8000,16000,32000,60000,60000):
            deadline=m.timers['rtx'];m.tick(deadline)
            self.assertEqual(m.values['rto_ms'],expected)
            self.assertEqual(m.timers['rtx'],deadline+expected)
        self.assertTrue(m.values['rtt_ambiguous']);self.assertEqual(m.values['rtt_samples'],1)

    def test_karn_fault_is_rejected_with_atomic_rollback(self):
        model=load(ROOT/'model/tcp-rto.json')
        for rule in model['transitions']:
            for action in rule['actions']:
                setting=action.get('set',{})
                if setting.get('var')=='rtt_sample_used' and isinstance(setting['value'],dict) and setting['value'].get('op')=='and':
                    setting['value']=setting['value']['args'][0]  # omit !ambiguous
        m=established(model=model);send(m,20,[1]);m.tick(1021)
        before=copy.deepcopy((m.snapshot(),m.trace))
        with self.assertRaisesRegex(ModelError,'T-INV-KARN'):ack(m,1100,1002)
        self.assertEqual((m.snapshot(),m.trace),before)

    def test_using_new_srtt_in_variance_is_detected(self):
        model=load(ROOT/'model/tcp-rto.json')
        for rule in model['transitions']:
            actions=rule['actions']
            srtt=next((i for i,a in enumerate(actions) if a.get('set',{}).get('var')=='srtt_ms' and a['set']['value'].get('op')=='ite'),None)
            error=next((i for i,a in enumerate(actions) if a.get('set',{}).get('var')=='rtt_error_ms' and a['set']['value'].get('op')=='ite'),None)
            if srtt is not None and error is not None and srtt>error:
                actions.insert(error,actions.pop(srtt))
        m=established(model=model);send(m,20,[1])
        with self.assertRaisesRegex(ModelError,'T-INV-UPDATE-ORDER'):ack(m,121,1002)

    @unittest.skipUnless(importlib.util.find_spec('z3'),'Z3 required')
    def test_independent_full_byte_symbolic_replay_for_numeric_and_timer_cases(self):
        model=load(ROOT/'model/tcp-rto.json')
        for path in sorted((ROOT/'scenarios/rto').glob('*.json')):
            with self.subTest(scenario=path.stem):
                machine=run_scenario(model,read(path))
                result=crosscheck_trace(model,machine.trace)
                self.assertEqual(result['status'],'match',result.get('reason'))
