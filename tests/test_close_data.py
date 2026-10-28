import copy
import importlib.util
import unittest

from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets, profile_inputs
from protocol_lab.symbolic import crosscheck_trace, encode_trace, replay


def established(window=8):
    m = Machine(load(ROOT/'model/tcp-close.json'))
    m.dispatch('app.connect')
    m.dispatch('net.synack', {'seq':9000, 'ack':1001, 'window':window}, 10)
    return m


def sent(m):
    m.dispatch('app.send', {'data':[0, 1, 128, 255, 4, 5]}, 20)
    m.dispatch('app.transmit', time_ms=21)
    m.dispatch('app.transmit', time_ms=22)


def ack(m, number, at, window=8, seq=9001):
    m.dispatch('net.ack', {'seq':seq, 'ack':number, 'window':window}, at)


class CloseDataTests(unittest.TestCase):
    def test_declared_and_all_inherited_connection_scenarios(self):
        model=load(ROOT/'model/tcp-close.json')
        for directory in ('data','reassembly','segments','close','connection'):
            for path in sorted((ROOT/'scenarios'/directory).glob('*.json')):
                with self.subTest(scenario=path.stem):
                    scenario=read(path)
                    if directory=='connection':
                        for step in scenario['steps']:
                            if step.get('event') in ('net.ack','net.synack'):
                                step['fields']['window']=8
                    run_scenario(model, scenario)

    def test_fin_preserves_old_deadline_and_partial_ack_retransmits_exact_bytes(self):
        m=established();sent(m);m.dispatch('app.close',time_ms=30)
        self.assertEqual(m.timers,{'rtx':1021,'user':30030})
        self.assertEqual(m.trace[-1]['emitted'][0]['fields'],{'flags':'FA','seq':1007,'ack':9001,'window':16})
        ack(m,1003,40);m.tick(1040)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['payload'],[128,255,4,5])
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['seq'],1003)
        ack(m,1007,1100)
        self.assertTrue(m.values['fin_sent']);self.assertEqual(m.timers['rtx'],3100)
        m.tick(3100)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields'],{'flags':'FA','seq':1007,'ack':9001,'window':16})
        ack(m,1008,3200)
        self.assertEqual(m.state,'FIN-WAIT-2');self.assertEqual(m.timers,{'user':30030})

    def test_unsent_bytes_precede_one_fin_and_new_send_is_rejected(self):
        m=established();m.dispatch('app.send',{'data':[0,1,128,255,4,5]},20)
        m.dispatch('app.close',time_ms=30)
        self.assertEqual(m.state,'FIN-WAIT-1');self.assertFalse(m.values['fin_sent'])
        self.assertEqual(m.timers,{'user':30030});self.assertEqual(m.trace[-1]['emitted'],[])
        m.dispatch('app.send',{'data':[99]},35)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['code'],'connection_closing')
        for t in (40,41,42):m.dispatch('app.transmit',time_ms=t)
        packets=[x['fields']for row in m.trace for x in row['emitted']if x['message']in ('tcp','tcp_data')]
        self.assertEqual([p.get('payload')for p in packets if p.get('payload')],[[0,1,128,255],[4,5]])
        self.assertEqual([p['seq']for p in packets if p['flags']=='FA'],[1007])
        m.dispatch('app.close',time_ms=45)
        self.assertEqual(m.values['snd_nxt'],1008)
        m.dispatch('app.transmit',time_ms=46);self.assertEqual(m.trace[-1]['emitted'],[])

    def test_peer_fin_keeps_unread_and_outstanding_bytes(self):
        m=established();sent(m)
        m.dispatch('net.data',{'seq':9001,'ack':1001,'window':8,'data':[7,8]},25)
        m.dispatch('net.fin',{'seq':9003,'ack':1003},30)
        self.assertEqual(m.state,'CLOSE-WAIT')
        self.assertEqual(m.values['rtx_buf'],[128,255,4,5])
        self.assertEqual(m.values['rcv_buf'],[7,8]);self.assertEqual(m.timers,{'rtx':1030})
        m.dispatch('app.send',{'data':[6]},40)
        self.assertEqual(m.values['snd_buf'],[6])
        m.dispatch('app.receive',{'count':2},50)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields']['data'],[7,8])

    def test_fin_retransmission_uses_current_ack_after_simultaneous_close(self):
        m=established();m.dispatch('app.close',time_ms=20)
        m.dispatch('net.fin',{'seq':9001,'ack':1001},30)
        m.dispatch('app.transmit',time_ms=35);self.assertEqual(m.trace[-1]['emitted'],[])
        m.tick(1020)
        self.assertEqual(m.trace[-1]['emitted'][0]['fields'],{'flags':'FA','seq':1001,'ack':9002,'window':16})
        self.assertEqual(m.values['snd_nxt'],1002)

    def test_pending_fin_waits_for_window_after_bytes_are_acked(self):
        m=established();sent(m);ack(m,1001,30,0);m.dispatch('app.close',time_ms=40)
        ack(m,1007,50,0)
        self.assertFalse(m.values['fin_sent']);self.assertEqual(m.timers,{'user':30040})
        m.dispatch('app.transmit',time_ms=60);self.assertEqual(m.trace[-1]['emitted'],[])
        ack(m,1007,70,1);m.dispatch('app.transmit',time_ms=80)
        self.assertEqual(m.values['fin_seq'],1007);self.assertEqual(m.timers,{'user':30040,'rtx':1080})

    def test_ahead_fin_is_acknowledged_without_eof_until_retransmitted(self):
        m=established();m.dispatch('net.fin',{'seq':9003,'ack':1001},20)
        self.assertEqual(m.state,'ESTABLISHED');self.assertEqual(m.values['rcv_nxt'],9001)
        self.assertEqual(len(m.trace[-1]['emitted']),1)
        m.dispatch('net.data',{'seq':9001,'ack':1001,'window':8,'data':[128,255]},30)
        self.assertEqual(m.state,'ESTABLISHED')
        m.dispatch('net.fin',{'seq':9003,'ack':1001},40)
        self.assertEqual(m.state,'CLOSE-WAIT');self.assertEqual(m.values['rcv_buf'],[128,255])

    def test_wrong_fin_sequence_and_premature_fin_are_rejected_atomically(self):
        for premature in (False,True):
            model=load(ROOT/'model/tcp-close.json')
            rule=next(r for r in model['transitions']if r['id']=='CL-CLOSE-ESTABLISHED-FIN')
            if premature:
                rule['guard']=True
                next(r for r in model['transitions']if r['id']=='CL-CLOSE-ESTABLISHED-QUEUE')['guard']=False
            else:next(a['set']for a in rule['actions']if a.get('set',{}).get('var')=='snd_nxt')['value']['args'][1]=2
            m=Machine(model);m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':8},10)
            if premature:m.dispatch('app.send',{'data':[1]},20)
            before=copy.deepcopy((m.state,m.values,m.timers,m.trace))
            with self.assertRaisesRegex(ModelError,'CL-INV-FIN-POSITION'if premature else'CL-INV-FLIGHT'):
                m.dispatch('app.close',time_ms=30)
            self.assertEqual((m.state,m.values,m.timers,m.trace),before)

    def test_full_byte_ack_cannot_cancel_outstanding_fin_timer(self):
        model=load(ROOT/'model/tcp-close.json')
        rule=next(r for r in model['transitions']if r['id']=='CL-S-ACK-VALID-FIN-WAIT-1-FIN-WAIT-1')
        next(a['cancel_if']for a in rule['actions']if 'cancel_if'in a)['when']={'op':'eq','args':[{'op':'bytes_len','args':[{'var':'rtx_buf'}]},0]}
        next(a['arm_if']for a in rule['actions']if 'arm_if'in a)['when']={'op':'ge','args':[{'op':'bytes_len','args':[{'var':'rtx_buf'}]},1]}
        m=Machine(model);m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':1001,'window':8},10);sent(m);m.dispatch('app.close',time_ms=30)
        with self.assertRaisesRegex(ModelError,'CL-INV-TIMER'):ack(m,1007,40)

    def test_stale_fin_ack_is_detected_by_output_oracle(self):
        model=load(ROOT/'model/tcp-close.json')
        scenario=read(ROOT/'scenarios/close/close-retransmit-fin-with-current-ack.json')
        good=run_scenario(model,scenario)
        bad=copy.deepcopy(model);rule=next(r for r in bad['transitions']if r['id']=='CL-RETRANSMIT-FIN-CLOSING')
        rule['actions'][0]['emit']['fields']['ack']={'seq':9001}
        wrong=run_scenario(bad,scenario)
        self.assertEqual(compare(control_packets(good,scenario),control_packets(wrong,scenario),projection='tcp-data-v1')['status'],'mismatch')

    def test_profile_hashes_include_full_chain_and_scope(self):
        profile=next(p for p in read(ROOT/'profiles.json')['profiles']if p['id']=='tcp-close')
        hashes=profile_inputs(profile,load(ROOT/profile['model']))
        for name in ['tcp-connection','tcp-data','tcp-reassembly','tcp-segments','tcp-close']:
            self.assertIn('model/'+name+'.json',hashes)
        self.assertIn('docs/tcp-close.md',hashes)


@unittest.skipUnless(importlib.util.find_spec('z3'),'Z3 required')
class SymbolicCloseTests(unittest.TestCase):
    def test_declared_close_traces_match_independent_full_byte_backend(self):
        model=load(ROOT/'model/tcp-close.json')
        for path in sorted((ROOT/'scenarios/close').glob('*.json')):
            with self.subTest(scenario=path.stem):
                m=run_scenario(model,read(path));r=crosscheck_trace(model,m.trace)
                self.assertEqual(r['status'],'match',r.get('reason'))

    def test_wrong_fin_sequence_has_replayable_full_byte_counterexample(self):
        model=load(ROOT/'model/tcp-close.json')
        s=read(ROOT/'scenarios/close/close-repeat-no-second-fin.json')
        good=run_scenario(model,s)
        rule=next(r for r in model['transitions']if r['id']=='CL-CLOSE-ESTABLISHED-FIN')
        next(a['set']for a in rule['actions']if a.get('set',{}).get('var')=='snd_nxt')['value']['args'][1]=2
        enc=encode_trace(model,good.trace);z=enc.z
        enc.solver.add(z.Not(z.And(*[enc.expr(i['assert'],f)for f in enc.frames for i in model['invariants']])))
        self.assertEqual(enc.solve(),z.sat)
        self.assertEqual(replay(model,enc.witness(enc.solver.model()))['status'],'runtime_rejected')
