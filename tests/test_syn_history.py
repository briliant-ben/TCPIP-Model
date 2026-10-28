"""SYN timeout ledger tests; immediate replies are distinct from timeouts."""
import copy
import importlib.util
import unittest

from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.ir import MOD, Machine, ModelError, load
from protocol_lab.symbolic import crosscheck_trace


def machine(model=None,initial=None):
    return Machine(model or load(ROOT/'model/tcp-syn-history.json'),initial)


def simultaneous(model=None,initial=None):
    m=machine(model,initial);m.dispatch('app.connect');m.dispatch('net.syn',{'seq':9000},900)
    return m


def actual_syn_ages(test,trace):
    last={}
    for row in trace:
        for output in row['emitted']:
            if output['message']not in ('tcp','tcp_data')or 'S'not in output['fields']['flags']:continue
            seq=output['fields']['seq'];now=row['time_ms']
            if row['event']['name']=='timer.rtx':
                test.assertIn(seq,last)
                test.assertGreaterEqual(now-last[seq],row['before']['variables']['rto_ms'],'premature SYN timeout output')
            last[seq]=now


class SynHistoryTests(unittest.TestCase):
    def test_new_contracts_and_all_inherited_data_fin_rto_reference_inputs(self):
        model=load(ROOT/'model/tcp-syn-history.json')
        for directory in ('syn-history','tx-history','rto','data','reassembly','segments','close','fin'):
            for p in sorted((ROOT/'scenarios'/directory).glob('*.json')):
                with self.subTest(scenario=p.stem):
                    m=run_scenario(model,read(p));actual_syn_ages(self,m.trace)

    def test_retained_parent_exhibits_the_scope_gap(self):
        m=simultaneous(load(ROOT/'model/tcp-tx-history.json'));m.tick(1000)
        with self.assertRaisesRegex(AssertionError,'premature SYN'):actual_syn_ages(self,m.trace)

    def test_reply_rearms_only_rtx_without_extending_user_deadline(self):
        m=simultaneous()
        self.assertEqual(m.values['tx_syn_time'],900);self.assertEqual(m.timers,{'rtx':1900,'user':30000})
        start=len(m.trace);m.tick(1000);self.assertEqual(len(m.trace),start)
        self.assertEqual(m.values['rto_ms'],1000);self.assertEqual(m.values['retries'],0)
        m.tick(1900);self.assertEqual(m.values['tx_elapsed'],1000)
        self.assertEqual(m.timers,{'rtx':3900,'user':30000});actual_syn_ages(self,m.trace)

    def test_ack_before_revised_deadline_clears_control_without_false_loss(self):
        m=simultaneous();m.dispatch('net.ack',{'seq':9001,'ack':1001,'window':8},1100)
        self.assertEqual(m.state,'ESTABLISHED');self.assertEqual(m.timers,{})
        self.assertFalse(m.values['tx_syn_pending']);self.assertEqual(m.values['tx_syn_time'],0)
        self.assertEqual(m.values['rto_ms'],1000);self.assertEqual(m.values['rtt_samples'],0)
        actual_syn_ages(self,m.trace)

    def test_real_timeout_precedes_same_time_reply_and_keeps_three_second_initialization(self):
        m=machine();m.dispatch('app.connect');m.dispatch('net.syn',{'seq':9000},1000)
        self.assertEqual([row['event']['name']for row in m.trace[-2:]],['timer.rtx','net.syn'])
        self.assertEqual(m.values['retries'],1);self.assertEqual(m.timers,{'rtx':3000,'user':30000})
        m.dispatch('net.ack',{'seq':9001,'ack':1001,'window':8},1100)
        self.assertEqual(m.values['rto_ms'],3000);self.assertFalse(m.values['tx_syn_pending'])
        actual_syn_ages(self,m.trace)

    def test_wrap_loss_and_passive_abort_use_one_control_position_and_cleanup(self):
        m=machine(initial={'iss':MOD-1});m.dispatch('app.connect');m.tick(1000)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['seq'],MOD-1)
        m.dispatch('net.synack',{'seq':9000,'ack':0,'window':8},1100)
        self.assertEqual(m.values['rto_ms'],3000);self.assertEqual(m.values['tx_syn_time'],0)
        actual_syn_ages(self,m.trace)
        passive=machine();passive.dispatch('app.listen');passive.dispatch('net.syn',{'seq':9000},50)
        self.assertEqual(passive.values['tx_syn_time'],50)
        passive.dispatch('app.abort',time_ms=60)
        self.assertFalse(passive.values['tx_syn_pending']);self.assertEqual(passive.values['tx_syn_time'],0)
        self.assertEqual(passive.timers,{})

    def test_injected_early_deadline_waits_without_send_backoff_or_retry(self):
        m=simultaneous();m.timers['rtx']=1000  # arbitrary timer fault, not a normal reachability claim
        m.tick(1000)
        self.assertEqual(m.trace[-1]['emitted'],[]);self.assertTrue(m.values['tx_waiting'])
        self.assertEqual(m.values['rto_ms'],1000);self.assertEqual(m.values['retries'],0)
        self.assertEqual(m.timers,{'rtx':1900,'user':30000});m.tick(1900)
        actual_syn_ages(self,m.trace)

    def test_missing_reply_registration_plus_stale_deadline_is_caught_from_outputs(self):
        model=load(ROOT/'model/tcp-syn-history.json')
        rule=next(r for r in model['transitions']if r['id']=='C-SIMULTANEOUS-SYN')
        setting=next(a['set']for a in rule['actions']if a.get('set',{}).get('var')=='tx_syn_time'and a['set']['value']=={'clock_ms':True})
        setting['value']=0
        m=simultaneous(model);m.timers['rtx']=1000;m.tick(1000)
        with self.assertRaisesRegex(AssertionError,'premature SYN'):actual_syn_ages(self,m.trace)

    def test_wrong_qualification_on_early_deadline_fails_atomic_invariant(self):
        model=load(ROOT/'model/tcp-syn-history.json')
        for rule in model['transitions']:
            if rule['event']!='timer.rtx'or rule['from']not in ('SYN-SENT','SYN-RECEIVED'):continue
            for action in rule['actions']:
                setting=action.get('set',{})
                if setting.get('var')=='syn_timeout_eligible'and isinstance(setting['value'],dict)and setting['value'].get('op')=='le':setting['value']=True
        m=simultaneous(model);m.timers['rtx']=1000;before=copy.deepcopy((m.snapshot(),m.trace))
        with self.assertRaisesRegex(ModelError,'TX-INV-NO-EARLY-TIMEOUT'):m.tick(1000)
        self.assertEqual((m.snapshot(),m.trace),before)

    def test_user_timeout_still_closes_before_renewed_rtx_deadline(self):
        m=simultaneous(initial={'user_timeout_ms':1000});m.tick(1000)
        self.assertEqual(m.state,'CLOSED');self.assertEqual(m.timers,{})
        self.assertFalse(m.values['tx_syn_pending']);self.assertEqual(m.values['tx_syn_time'],0)
        self.assertFalse(any('S'in out['fields'].get('flags','')for row in m.trace if row['time_ms']==1000 for out in row['emitted']))
        actual_syn_ages(self,m.trace)

    @unittest.skipUnless(importlib.util.find_spec('z3'),'Z3 required')
    def test_full_byte_symbolic_replay_checks_exact_control_time_contracts(self):
        model=load(ROOT/'model/tcp-syn-history.json')
        for p in sorted((ROOT/'scenarios/syn-history').glob('*.json')):
            with self.subTest(scenario=p.stem):
                m=run_scenario(model,read(p));r=crosscheck_trace(model,m.trace)
                self.assertEqual(r['status'],'match',r.get('reason'))
