import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest

from protocol_lab.capture import normalize
from protocol_lab.flow import ROOT, TraceContractMismatch, read, run_scenario
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.packets import compare, write_pcap
from protocol_lab.profiles import control_packets, profile_inputs, scenario_paths
from protocol_lab.symbolic import crosscheck_trace, encode_trace, replay


def established():
    m=Machine(load(ROOT/'model/tcp-fin.json'))
    m.dispatch('app.connect')
    m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':8},10)
    return m


def fin(m,seq,payload,at=20,ack=1001,window=8):
    m.dispatch('net.fin_segment',{'seq':seq,'ack':ack,'window':window,'data':payload},at)


def data(m,seq,payload,at=30,ack=1001,window=8):
    m.dispatch('net.data',{'seq':seq,'ack':ack,'window':window,'data':payload},at)


class FinTests(unittest.TestCase):
    def test_new_and_inherited_reference_corpus(self):
        model=load(ROOT/'model/tcp-fin.json')
        for directory in ('data','reassembly','segments','close','fin','connection'):
            for path in sorted((ROOT/'scenarios'/directory).glob('*.json')):
                with self.subTest(scenario=path.stem):
                    scenario=read(path)
                    if directory=='connection':
                        for step in scenario['steps']:
                            if step.get('event')in ('net.ack','net.synack'):step['fields']['window']=8
                    run_scenario(model,scenario)

    def test_marker_tracks_gap_and_fin_is_consumed_before_single_ack(self):
        m=established();fin(m,9004,[255])
        self.assertEqual(m.state,'ESTABLISHED');self.assertEqual(m.values['rx_fin_offset'],4)
        self.assertEqual(m.values['rx_fin_seq'],9005);self.assertEqual(m.values['rx_slot_03'],[255])
        self.assertEqual(len(m.trace[-1]['emitted']),1)
        data(m,9001,[0,128])
        self.assertEqual(m.values['rx_fin_offset'],2);self.assertEqual(m.values['rcv_nxt'],9003)
        data(m,9003,[7],40)
        self.assertEqual(m.state,'CLOSE-WAIT');self.assertEqual(m.values['rcv_nxt'],9006)
        self.assertEqual(m.values['rcv_buf'],[0,128,7,255]);self.assertEqual(m.values['rx_fin_offset'],0)
        self.assertEqual([o['message']for o in m.trace[-1]['emitted']],['tcp_data','application'])
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['ack'],9006)
        self.assertEqual(m.trace[-1]['emitted'][1]['fields']['code'],'peer_eof')

    def test_receive_sequence_and_future_ack_block_marker_and_window_updates(self):
        m=established();m.dispatch('app.close',time_ms=20)
        fin(m,9001,[7],30,ack=1003,window=0)
        self.assertEqual(m.state,'FIN-WAIT-1');self.assertFalse(m.values['rx_fin_pending'])
        self.assertFalse(m.values['rx_fin_done']);self.assertEqual(m.values['rcv_buf'],[])
        self.assertEqual(m.values['snd_wnd'],8);self.assertEqual(m.timers,{'rtx':1020,'user':30020})
        fin(m,9017,[],40,ack=1002,window=0)
        self.assertEqual(m.state,'FIN-WAIT-1');self.assertEqual(m.values['snd_una'],1001)
        self.assertEqual(m.values['snd_wnd'],8)

    def test_zero_window_trims_fin_until_explicit_retransmission(self):
        m=established();fin(m,9001,list(range(16)))
        self.assertEqual(m.values['rcv_nxt'],9017);self.assertFalse(m.values['rx_fin_done'])
        self.assertFalse(m.values['rx_fin_pending']);self.assertEqual(m.values['local_window'],0)
        fin(m,9017,[],30,window=2)
        self.assertFalse(m.values['rx_fin_done']);self.assertEqual(m.values['snd_wnd'],8)
        m.dispatch('app.receive',{'count':4},40)
        fin(m,9017,[],50,window=2)
        self.assertTrue(m.values['rx_fin_done']);self.assertEqual(m.values['snd_wnd'],2)
        self.assertEqual(m.values['rcv_nxt'],9018)

    def test_duplicate_eof_and_time_wait_deadline_are_independent_contracts(self):
        scenario=read(ROOT/'scenarios/fin/fin-time-wait-duplicate-payload.json')
        m=run_scenario(load(ROOT/'model/tcp-fin.json'),scenario)
        self.assertEqual(m.timers,{'time_wait':120040})
        notifications=[o for row in m.trace for o in row['emitted']if o['message']=='application'and o['fields']['code']=='peer_eof']
        self.assertEqual(len(notifications),1);self.assertEqual(m.values['rcv_buf'],[7])

    def test_canonical_fin_has_closed_and_listen_reset_paths(self):
        for listening in (False,True):
            m=Machine(load(ROOT/'model/tcp-fin.json'))
            if listening:m.dispatch('app.listen')
            fin(m,55,[128],20,ack=77,window=3)
            self.assertEqual(m.state,'LISTEN'if listening else'CLOSED')
            self.assertEqual(m.trace[-1]['emitted'][0]['fields']['flags'],'R')
            self.assertEqual(m.trace[-1]['emitted'][0]['fields']['seq'],77)

    def test_wrong_control_increment_rolls_back_with_position_invariant(self):
        model=load(ROOT/'model/tcp-fin.json');r=next(r for r in model['transitions']if r['id']=='F-RECEIVE-ESTABLISHED-net-fin_segment')
        update=next(a['set']for a in r['actions']if a.get('set',{}).get('var')=='rcv_nxt'and a['set']['value'].get('op')=='seq_add'and a['set']['value']['args'][1].get('op')=='ite')
        update['value']['args'][1]['args'][1]=2
        m=Machine(model);m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':8},10)
        before=copy.deepcopy((m.snapshot(),m.trace))
        with self.assertRaisesRegex(ModelError,'F-INV-CONSUMED-POSITION'):fin(m,9001,[0,128])
        self.assertEqual((m.snapshot(),m.trace),before)

    def test_missing_clip_cannot_deliver_bytes_past_queued_fin(self):
        model=load(ROOT/'model/tcp-fin.json');r=next(r for r in model['transitions']if r['id']=='F-RECEIVE-ESTABLISHED-net-data')
        store=next(a['set']for a in r['actions']if a.get('set',{}).get('var')=='rx_slot_02')
        store['value']=store['value']['args'][2]
        m=Machine(model);m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':8},10);fin(m,9003,[])
        with self.assertRaisesRegex(ModelError,'F-INV-'):data(m,9001,[0,128,99])

    def test_duplicate_eof_fault_fails_contract_even_when_state_would_match(self):
        model=load(ROOT/'model/tcp-fin.json');r=next(r for r in model['transitions']if r['id']=='F-RECEIVE-CLOSE-WAIT-net-fin_segment')
        output=next(a['emit_if']for a in r['actions']if a.get('emit_if',{}).get('fields',{}).get('code')=='peer_eof');output['when']=True
        with self.assertRaises(TraceContractMismatch)as context:
            run_scenario(model,read(ROOT/'scenarios/fin/fin-duplicate-payload-eof-once.json'))
        error=context.exception
        self.assertEqual(error.at_ms,30);self.assertEqual(len(error.expected[0]['emitted']),1)
        self.assertEqual(len(error.observed[0]['emitted']),2)

    def test_fin_payload_codec_is_opt_in_and_oracle_remains_strict(self):
        scenario=read(ROOT/'scenarios/fin/fin-payload-contiguous.json')
        m=run_scenario(load(ROOT/'model/tcp-fin.json'),scenario);packets=control_packets(m,scenario)
        profile=read(ROOT/'packet-profile.json')
        with tempfile.TemporaryDirectory()as tmp:
            path=Path(tmp)/'fin.pcap';write_pcap(path,packets)
            observed,metadata=normalize(path,profile,packets,origin='synthetic',projection='tcp-fin-v1')
            self.assertEqual(compare(packets,observed,projection='tcp-fin-v1')['status'],'match')
            incoming=next(p for p in observed if p['flags']=='FA')
            self.assertEqual(incoming['window'],5);self.assertEqual(incoming['payload'],[0,128,255])
            self.assertEqual(metadata['normalizer'],'classic-pcap-ipv4-tcp-fin-v1')
            self.assertEqual(metadata['capture_origin'],'synthetic')
            for old in ('active-open-v1','tcp-data-v1'):
                with self.assertRaises(ModelError):normalize(path,profile,packets,origin='synthetic',projection=old)
            bad=copy.deepcopy(observed);next(p for p in bad if p['flags']=='FA')['payload']=[0,128,254]
            self.assertEqual(compare(packets,bad,projection='tcp-fin-v1')['status'],'mismatch')
            # FIN support does not enable SYN payload in the new projection.
            wrong=copy.deepcopy(packets);wrong[0]['payload']=[1];write_pcap(path,wrong)
            with self.assertRaises(ModelError):normalize(path,profile,wrong,origin='synthetic',projection='tcp-fin-v1')

    def test_new_profile_binds_model_chain_and_explicit_scope(self):
        profile=next(p for p in read(ROOT/'profiles.json')['profiles']if p['id']=='tcp-fin')
        model=load(ROOT/profile['model']);inputs=profile_inputs(profile,model)
        for part in ('connection','data','reassembly','segments','close','fin'):
            self.assertIn('model/tcp-'+part+'.json',inputs)
        self.assertIn('docs/tcp-fin.md',inputs);self.assertEqual(len(scenario_paths(profile)),84)
        self.assertEqual(model['semantics'],'flat-efsm-atomic-ordered-post-target-v2')


class TraceContractTests(unittest.TestCase):
    def test_contract_includes_automatic_timer_rows_before_requested_event(self):
        scenario=read(ROOT/'scenarios/syn-loss.json');scenario['scenario_version']='0.2'
        expected=[{'at_ms':1000,'emitted':[{'message':'tcp','fields':{'flags':'S','seq':1000,'ack':0,'window':65535}}]},
                  {'at_ms':1010,'emitted':[{'message':'tcp','fields':{'flags':'A','seq':1001,'ack':9001,'window':65535}}]}]
        scenario['steps'][1]['expect_trace']=expected
        run_scenario(load(ROOT/'model/tcp.json'),scenario)
        for wrong in (expected[1:],list(reversed(expected))):
            bad=copy.deepcopy(scenario);bad['steps'][1]['expect_trace']=wrong
            with self.assertRaises(TraceContractMismatch):run_scenario(load(ROOT/'model/tcp.json'),bad)

    def test_contract_versions_and_types_are_checked_before_comparison(self):
        scenario=read(ROOT/'scenarios/fin/fin-payload-contiguous.json')
        for version in ('0.1','0.3'):
            bad=copy.deepcopy(scenario);bad['scenario_version']=version
            with self.assertRaises(ModelError):run_scenario(load(ROOT/'model/tcp-fin.json'),bad)
        for malformed in ('time','field'):
            bad=copy.deepcopy(scenario);row=bad['steps'][-1]['expect_trace'][0]
            if malformed=='time':row['at_ms']=True
            else:row['emitted'][0]['fields']['ack']=True
            with self.assertRaisesRegex(ModelError,'Bad trace contract'):run_scenario(load(ROOT/'model/tcp-fin.json'),bad)


@unittest.skipUnless(importlib.util.find_spec('z3'),'Z3 required')
class SymbolicFinTests(unittest.TestCase):
    def test_full_byte_replay_for_every_new_fin_input(self):
        model=load(ROOT/'model/tcp-fin.json')
        for path in sorted((ROOT/'scenarios/fin').glob('*.json')):
            with self.subTest(scenario=path.stem):
                m=run_scenario(model,read(path));result=crosscheck_trace(model,m.trace)
                self.assertEqual(result['status'],'match',result.get('reason'))

    def test_missing_post_target_has_independent_counterexample(self):
        good=load(ROOT/'model/tcp-fin.json');scenario=read(ROOT/'scenarios/fin/fin-payload-contiguous.json');m=run_scenario(good,scenario)
        bad=copy.deepcopy(good);r=next(r for r in bad['transitions']if r['id']=='F-RECEIVE-ESTABLISHED-net-fin_segment');r['target_cases'][0]['when']=False
        enc=encode_trace(bad,m.trace);z=enc.z
        enc.solver.add(z.Not(z.And(*[enc.expr(i['assert'],f)for f in enc.frames for i in bad['invariants']])))
        self.assertEqual(enc.solve(),z.sat)
        self.assertEqual(replay(bad,enc.witness(enc.solver.model()))['status'],'runtime_rejected')
