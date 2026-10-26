"""Independent output-age checks; protocol decisions remain in the JSON IR."""
import copy
import json
import importlib.util
import unittest
import shutil
import tempfile
from pathlib import Path

from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.ir import MOD, Machine, ModelError, load, model_files
from protocol_lab.symbolic import Encoding, crosscheck_trace


def established(model=None,initial=None):
    m=Machine(model or load(ROOT/'model/tcp-tx-history.json'),initial)
    m.dispatch('app.connect')
    m.dispatch('net.synack',{'seq':9000,'ack':m.values['snd_nxt'],'window':16},10)
    return m


def send(m,at,data):
    m.dispatch('app.send',{'data':data},at)
    m.dispatch('app.transmit',time_ms=at+1)


def ack(m,at,number,window=16):
    m.dispatch('net.ack',{'seq':9001,'ack':number,'window':window},at)


def check_actual_output_ages(test,trace):
    """Reconstruct send ages from emissions, without reading model time slots."""
    sent={}
    for row in trace:
        now=row['time_ms'];timeout=row['event']['name']=='timer.rtx'
        rto=row['before']['variables']['rto_ms']
        for output in row['emitted']:
            if output['message']not in ('tcp','tcp_data'):continue
            fields=output['fields'];payload=fields.get('payload',[])
            items=[(fields['seq']+i)%MOD for i in range(len(payload))]
            if 'F'in fields['flags']:items.append((fields['seq']+len(payload))%MOD)
            for seq in items:
                if timeout:
                    test.assertIn(seq,sent,'timeout output has no previous transmission')
                    test.assertGreaterEqual(now-sent[seq],rto,'timeout retransmitted a recently sent octet/FIN')
                sent[seq]=now


class TransmissionHistoryTests(unittest.TestCase):
    def test_handwritten_scenarios_and_actual_output_ages(self):
        model=load(ROOT/'model/tcp-tx-history.json')
        for p in sorted((ROOT/'scenarios/tx-history').glob('*.json')):
            with self.subTest(scenario=p.stem):
                m=run_scenario(model,read(p));check_actual_output_ages(self,m.trace)

    def test_inherited_data_fin_rto_and_connection_reference_corpus(self):
        model=load(ROOT/'model/tcp-tx-history.json')
        for directory in ('rto','data','reassembly','segments','close','fin','connection'):
            for path in sorted((ROOT/'scenarios'/directory).glob('*.json')):
                with self.subTest(scenario=path.stem):
                    scenario=read(path)
                    if directory=='connection':
                        for step in scenario['steps']:
                            if step.get('event')in ('net.ack','net.synack'):step['fields']['window']=8
                    m=run_scenario(model,scenario)
                    check_actual_output_ages(self,m.trace)

    def test_original_model_exhibits_the_retained_reachable_time_violation(self):
        m=established(load(ROOT/'model/tcp-rto.json'));send(m,20,[0,1]);send(m,999,[2,3,4,5]);m.tick(1021)
        with self.assertRaisesRegex(AssertionError,'recently sent'):check_actual_output_ages(self,m.trace)

    def test_full_cumulative_ack_clears_all_slots_and_uses_actual_clip_for_karn(self):
        m=established();send(m,20,[0,1]);send(m,999,[2,3,4,5]);m.tick(1021)
        ack(m,1100,1007)
        self.assertEqual(m.timers,{})
        self.assertEqual([m.values[f'tx_time_{i:02}']for i in range(16)],[0]*16)
        self.assertEqual(m.values['rtt_samples'],1)
        self.assertFalse(m.values['rtt_active']);check_actual_output_ages(self,m.trace)

    def test_one_millisecond_younger_tail_remains_queued_at_exact_deadline(self):
        m=established();send(m,20,[0,1]);m.tick(1021);send(m,1021,[2,3])
        m.tick(3021)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'],[0,1])
        self.assertEqual(m.values['tx_time_02'],1022)
        self.assertEqual(m.values['rto_ms'],4000);check_actual_output_ages(self,m.trace)

    def test_zero_probe_then_larger_window_handles_nonmonotone_slot_times(self):
        m=established();send(m,20,[0,1]);send(m,999,[2,3,4,5]);ack(m,1001,1001,0)
        m.tick(1021);ack(m,1500,1001,2);m.tick(3021)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'],[0,1])
        self.assertEqual(m.values['tx_elapsed'],2000)
        check_actual_output_ages(self,m.trace)

    def test_fin_keeps_independent_time_while_data_prefix_retransmits(self):
        m=established();send(m,20,[0,1]);m.dispatch('app.close',time_ms=1000)
        self.assertEqual(m.values['tx_fin_time'],1000)
        m.tick(1021);ack(m,1030,1003)
        self.assertEqual(m.values['tx_fin_time'],1000)
        self.assertEqual(m.timers['rtx'],3030)
        m.tick(3030)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['flags'],'FA')
        self.assertEqual(m.values['tx_fin_time'],3030)
        self.assertEqual(m.values['tx_elapsed'],2030)
        check_actual_output_ages(self,m.trace)

    def test_wrap_and_partial_ack_shift_the_history_with_octets(self):
        m=established(initial={'iss':MOD-3});send(m,20,[0,1]);send(m,999,[2,3,4,5]);m.tick(1021)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['seq'],MOD-2)
        ack(m,1100,0)
        self.assertEqual(m.values['rtx_buf'],[2,3,4,5])
        self.assertEqual([m.values[f'tx_time_{i:02}']for i in range(5)],[1000]*4+[0])
        check_actual_output_ages(self,m.trace)

    def test_injected_early_timer_waits_without_emission_backoff_or_retry(self):
        m=established();send(m,20,[0,1])
        # Fault injection of an arbitrary timer prestate; not a reachable-path claim.
        m.timers['rtx']=22;m.tick(22)
        self.assertEqual(m.trace[-1]['emitted'],[]);self.assertTrue(m.values['tx_waiting'])
        self.assertEqual(m.values['rto_ms'],1000);self.assertEqual(m.values['retries'],0)
        self.assertEqual(m.timers,{'rtx':1021})
        m.tick(1021);check_actual_output_ages(self,m.trace)

    def test_missing_fresh_timestamp_is_detected_by_output_history_oracle(self):
        model=load(ROOT/'model/tcp-tx-history.json')
        for rule in model['transitions']:
            if rule['event']!='app.transmit':continue
            for action in rule['actions']:
                setting=action.get('set',{})
                if setting.get('var','').startswith('tx_time_')and isinstance(setting['value'],dict)and setting['value'].get('op')=='ite'and setting['value']['args'][1]=={'clock_ms':True}:
                    setting['value']['args'][1]=0
        m=established(model);send(m,20,[0,1]);send(m,999,[2,3,4,5]);m.tick(1021)
        with self.assertRaisesRegex(AssertionError,'recently sent'):check_actual_output_ages(self,m.trace)

    def test_wrong_eligibility_threshold_fails_invariant_and_rolls_back(self):
        model=load(ROOT/'model/tcp-tx-history.json')
        for rule in model['transitions']:
            if rule['event']!='timer.rtx':continue
            for action in rule['actions']:
                setting=action.get('set',{})
                if setting.get('var')=='tx_eligible'and isinstance(setting['value'],dict)and setting['value'].get('op')=='ite':
                    setting['value']['args'][0]=True
        m=established(model);send(m,20,[0,1]);send(m,999,[2,3,4,5])
        before=copy.deepcopy((m.snapshot(),m.trace))
        with self.assertRaisesRegex(ModelError,'TX-INV-NO-EARLY-TIMEOUT'):m.tick(1021)
        self.assertEqual((m.snapshot(),m.trace),before)

    def test_fin_wait_partition_branches_keep_pending_and_sent_fin_behavior(self):
        for pending in (False,True):
            for label,number in [('ACK-DUPLICATE',1001),('ACK-NEW',1002),('ACK-OTHER',999)]:
                with self.subTest(pending=pending,ack=label):
                    m=established();send(m,20,list(range(8))if pending else [0,1])
                    m.dispatch('app.close',time_ms=30)
                    m.dispatch('net.fin_segment',{'seq':9003,'ack':number,'window':16,'data':[]},40)
                    prefix='PENDING'if pending else'OTHER'
                    self.assertEqual(m.trace[-1]['transition'],'F-RECEIVE-FIN-WAIT-1-net-fin_segment-'+prefix+'-'+label)
                    self.assertEqual(m.values['fin_sent'],not pending)
                    self.assertTrue(m.values['rx_fin_pending'])
                    check_actual_output_ages(self,m.trace)

    @unittest.skipUnless(importlib.util.find_spec('z3'),'Z3 required')
    def test_guard_partition_is_exhaustive_disjoint_and_keeps_all_actions(self):
        current=ROOT/'model/tcp-tx-history.json';model=load(current)
        # Reconstruct the unpartitioned current overlay from its canonical
        # shared amendment, rather than combining an archived overlay with a
        # changed parent. All three branches must preserve that operation.
        raw=read(current);unpartitioned=copy.deepcopy(raw)
        unpartitioned['transitions']=[];unpartitioned['remove_transitions']=[]
        for suffix in ('PENDING','OTHER'):
            rid='F-RECEIVE-FIN-WAIT-1-net-fin_segment-'+suffix
            variants=[a for a in unpartitioned['amend_transitions']if a['id'].startswith(rid+'-ACK-')]
            canonical=copy.deepcopy(variants[0]);canonical['id']=rid
            unpartitioned['amend_transitions']=[a for a in unpartitioned['amend_transitions']if not a['id'].startswith(rid+'-ACK-')]+[canonical]
        with tempfile.TemporaryDirectory()as tmp:
            folder=Path(tmp)
            for source in model_files(current)[1:]:shutil.copyfile(source,folder/source.name)
            (folder/current.name).write_text(json.dumps(unpartitioned))
            original=load(folder/current.name)
        self.assertEqual(model['invariants'],original['invariants'])
        oldrules={r['id']:r for r in original['transitions']}
        enc=Encoding(model,1,(),byte_encoding='length',sequence_encoding='modular-int');z=enc.z
        for suffix in ('PENDING','OTHER'):
            rid='F-RECEIVE-FIN-WAIT-1-net-fin_segment-'+suffix
            branches=[r for r in model['transitions']if r['id'].startswith(rid+'-ACK-')]
            self.assertEqual(len(branches),3)
            predicates=[]
            for rule in branches:
                self.assertEqual({k:v for k,v in rule.items()if k not in ('id','guard')},{k:v for k,v in oldrules[rid].items()if k not in ('id','guard')})
                self.assertEqual(rule['guard']['args'][0],{'op':'and','args':[True,oldrules[rid]['guard']]})
                predicates.append(enc.expr(rule['guard']['args'][1],enc.frames[0],enc.events[0]['net.fin_segment']))
            solver=z.Solver();solver.add(z.Not(z.PbEq([(p,1)for p in predicates],1)))
            self.assertEqual(solver.check(),z.unsat)
        for rule in model['transitions']:
            if '-ACK-'not in rule['id']:self.assertEqual(rule,oldrules[rule['id']])

    @unittest.skipUnless(importlib.util.find_spec('z3'),'Z3 required')
    def test_complete_byte_backend_checks_new_handwritten_time_contracts(self):
        model=load(ROOT/'model/tcp-tx-history.json')
        for p in sorted((ROOT/'scenarios/tx-history').glob('*.json')):
            with self.subTest(scenario=p.stem):
                m=run_scenario(model,read(p));r=crosscheck_trace(model,m.trace)
                self.assertEqual(r['status'],'match',r.get('reason'))
