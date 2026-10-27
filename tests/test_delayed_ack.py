"""Independent fixed-input delayed ACK timing/output contracts."""
import copy
import tempfile
import unittest
from pathlib import Path

from protocol_lab.flow import ROOT, read, run_scenario, TraceContractMismatch
from protocol_lab.ir import MOD, Machine, ModelError, load
from protocol_lab.symbolic import crosscheck_trace


def established(model=None, initial=None, irs=9000):
    m=Machine(model or load(ROOT/'model/tcp-delayed-ack.json'),initial)
    m.dispatch('app.connect');m.dispatch('net.synack',{'seq':irs,'ack':m.values['snd_nxt'],'window':16},10)
    return m


def data(m,at,seq,values,ack=None,window=16):
    m.dispatch('net.data',{'seq':seq,'ack':m.values['snd_una']if ack is None else ack,'window':window,'data':values},at)


def wire(row):
    return [o for o in row['emitted']if o['message']in ('tcp','tcp_data')]


class DelayedAckTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):cls.model=load(ROOT/'model/tcp-delayed-ack.json')

    def test_first_full_segment_waits_until_exact_deadline_with_current_ack(self):
        m=established(self.model);data(m,20,9001,[0,128,255,7])
        self.assertEqual(wire(m.trace[-1]),[]);self.assertEqual(m.timers,{'delack':60})
        self.assertEqual(m.values['ack_bytes'],4);self.assertEqual(m.values['ack_full_segments'],1)
        count=len(m.trace);m.tick(59);self.assertEqual(len(m.trace),count)
        m.tick(60);self.assertEqual(wire(m.trace[-1]),[{'message':'tcp_data','fields':{'flags':'A','seq':1001,'ack':9005,'window':12,'payload':[]}}])
        self.assertEqual(m.timers,{});self.assertFalse(m.values['ack_pending'])

    def test_second_full_segment_acknowledges_both_and_cancels_timer(self):
        m=established(self.model);data(m,20,9001,[0,1,2,3]);data(m,50,9005,[4,5,6,7])
        self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],9009)
        self.assertEqual(m.timers,{});n=len(m.trace);m.tick(60);self.assertEqual(len(m.trace),n)

    def test_short_segments_accumulate_two_rmss_without_restarting_first_deadline(self):
        m=established(self.model);data(m,20,9001,[0,1,2]);data(m,30,9004,[3,4,5])
        self.assertEqual(m.timers,{'delack':60});self.assertEqual(m.values['ack_since_ms'],20)
        self.assertEqual(m.values['ack_bytes'],6);self.assertEqual(m.values['ack_full_segments'],0)
        data(m,40,9007,[6,7]);self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],9009);self.assertEqual(m.timers,{})

    def test_gap_fill_duplicate_and_zero_window_keep_immediate_ack_policy(self):
        m=established(self.model);data(m,20,9005,[4,5,6,7]);self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],9001)
        data(m,30,9001,[0,1,2,3]);self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],9009);self.assertEqual(m.timers,{})
        data(m,40,9009,[8]);self.assertEqual(m.timers,{'delack':80})
        data(m,41,9009,[8]);self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],9010);self.assertEqual(m.timers,{})
        full=established(self.model);data(full,20,9001,list(range(12)));data(full,30,9013,[12,13,14,15])
        self.assertEqual(wire(full.trace[-1])[0]['fields']['window'],0);self.assertEqual(full.timers,{})

    def test_piggyback_read_window_update_and_fin_discharge_pending_ack(self):
        for action in ('piggyback','read','close','peer_fin','reset','abort'):
            with self.subTest(action=action):
                m=established(self.model);data(m,20,9001,[0,1])
                if action=='piggyback':m.dispatch('app.send',{'data':[9,8]},30);m.dispatch('app.transmit',time_ms=31)
                elif action=='read':m.dispatch('app.receive',{'count':1},30)
                elif action=='close':m.dispatch('app.close',time_ms=30)
                elif action=='peer_fin':m.dispatch('net.fin_segment',{'seq':9003,'ack':1001,'window':16,'data':[]},30)
                elif action=='reset':m.dispatch('net.rst',{'seq':9003},30)
                else:m.dispatch('app.abort',time_ms=30)
                self.assertNotIn('delack',m.timers);self.assertFalse(m.values['ack_pending'])
                self.assertEqual(m.values['ack_bytes'],0)

    def test_deadline_timer_precedes_same_time_new_segment_and_starts_new_epoch(self):
        m=established(self.model);data(m,20,9001,[0,1,2,3]);n=len(m.trace)
        data(m,60,9005,[4,5,6,7]);rows=m.trace[n:]
        self.assertEqual([r['event']['name']for r in rows],['timer.delack','net.data'])
        self.assertEqual(wire(rows[0])[0]['fields']['ack'],9005);self.assertEqual(wire(rows[1]),[])
        self.assertEqual(m.timers,{'delack':100});self.assertEqual(m.values['ack_since_ms'],60)

    def test_wrap_and_configured_499ms_limit_are_exact_and_500_rejected(self):
        m=established(self.model,{'ack_delay_ms':499},irs=MOD-3);data(m,20,MOD-2,[0,1,2,3])
        self.assertEqual(m.timers,{'delack':519});n=len(m.trace);m.tick(518);self.assertEqual(len(m.trace),n)
        m.tick(519);self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],2)
        for delay in (0,500,-1):
            with self.subTest(delay=delay),self.assertRaisesRegex(ModelError,'ACK-INV-CONFIG'):Machine(self.model,{'ack_delay_ms':delay})

    def test_ack_timer_does_not_backoff_or_change_sender_history(self):
        m=established(self.model);m.dispatch('app.send',{'data':[1,2,3,4]},20);m.dispatch('app.transmit',time_ms=21)
        data(m,30,9001,[9,8],ack=1001);before={k:copy.deepcopy(m.values[k])for k in ('rto_ms','retries','rtt_start_ms','rtt_end','rtx_buf','tx_time_00')}
        self.assertEqual(m.timers,{'rtx':1021,'delack':70})
        m.timers['rtx']=40 # explicit early-timer fault; a suppressed output must not cancel ACK
        m.tick(40);self.assertEqual(wire(m.trace[-1]),[]);self.assertTrue(m.values['ack_pending'])
        self.assertEqual(m.timers,{'rtx':1021,'delack':70});m.tick(70)
        self.assertEqual({k:m.values[k]for k in before},before);self.assertEqual(m.timers,{'rtx':1021})

    def test_delayed_receive_keeps_general_ack_window_and_rtt_update(self):
        m=established(self.model);m.dispatch('app.send',{'data':[9,8,7,6]},20);m.dispatch('app.transmit',time_ms=21)
        data(m,30,9001,[0,1],ack=1005,window=3)
        self.assertEqual(m.values['snd_una'],1005);self.assertEqual(m.values['snd_wnd'],3)
        self.assertEqual(m.values['rtt_samples'],2);self.assertEqual(m.values['rtt_last_ms'],9)
        self.assertEqual(m.values['rtx_buf'],[]);self.assertEqual(m.timers,{'delack':70})
        m.tick(70);self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],9003)
        self.assertEqual(m.values['rtt_sample_at_ms'],30)

    def test_delay_timer_covers_both_local_half_close_states(self):
        for acknowledged in (False,True):
            with self.subTest(fin_acknowledged=acknowledged):
                m=established(self.model);m.dispatch('app.close',time_ms=20)
                if acknowledged:m.dispatch('net.ack',{'seq':9001,'ack':1002,'window':16},25)
                expected_state='FIN-WAIT-2'if acknowledged else'FIN-WAIT-1'
                data(m,30,9001,[0,1],ack=1002 if acknowledged else 1001)
                self.assertEqual(m.state,expected_state);self.assertIn('delack',m.timers)
                m.tick(70);self.assertEqual(m.state,expected_state)
                self.assertEqual(wire(m.trace[-1])[0]['fields'],{'flags':'A','seq':1002,'ack':9003,'window':14,'payload':[]})
                self.assertNotIn('delack',m.timers)

    def test_ack_deadline_precedes_same_time_retransmission_without_moving_rto(self):
        m=established(self.model);m.dispatch('app.send',{'data':[9]},20);m.dispatch('app.transmit',time_ms=21)
        data(m,981,9001,[0]);self.assertEqual(m.timers,{'rtx':1021,'delack':1021})
        n=len(m.trace);m.tick(1021);rows=m.trace[n:]
        self.assertEqual([r['event']['name']for r in rows],['timer.delack','timer.rtx'])
        self.assertEqual(wire(rows[0])[0]['fields']['payload'],[])
        self.assertEqual(wire(rows[1])[0]['fields']['payload'],[9])
        self.assertEqual(m.values['rto_ms'],2000);self.assertEqual(m.values['retries'],1)

    def test_fault_restarting_deadline_cannot_pass_independent_timing_oracle(self):
        model=copy.deepcopy(self.model)
        for r in model['transitions']:
            for a in r['actions']:
                if a.get('arm_if',{}).get('timer')=='delack':a['arm_if']['when']={'var':'ack_defer_now'}
        scenario=read(ROOT/'scenarios/delayed-ack/delayed-short-first-deadline.json')
        with self.assertRaises(TraceContractMismatch):run_scenario(model,scenario)

    def test_dropped_timer_ack_is_caught_even_when_final_state_matches(self):
        model=copy.deepcopy(self.model)
        for r in model['transitions']:
            if r['event']=='timer.delack':r['actions']=[a for a in r['actions']if 'emit'not in a]
        with self.assertRaises(TraceContractMismatch):
            run_scenario(model,read(ROOT/'scenarios/delayed-ack/delayed-single-full-deadline.json'))

    def test_missing_conditional_timer_cancel_fails_invariant_atomically(self):
        model=copy.deepcopy(self.model)
        for r in model['transitions']:
            if r['id']!='D-FLUSH-FIRST':continue
            for a in r['actions']:
                if a.get('cancel_if',{}).get('timer')=='delack':a['cancel_if']['when']=False
        m=established(model);data(m,20,9001,[0]);m.dispatch('app.send',{'data':[9]},30)
        before=copy.deepcopy((m.now_ms,m.snapshot(),m.trace))
        with self.assertRaisesRegex(ModelError,'ACK-INV-TIMER'):m.dispatch('app.transmit',time_ms=31)
        self.assertEqual((m.now_ms,m.snapshot(),m.trace),before)

    def test_explicit_fixed_input_scenarios_and_full_byte_backend(self):
        paths=sorted((ROOT/'scenarios/delayed-ack').glob('*.json'));self.assertGreaterEqual(len(paths),7)
        for path in paths:
            with self.subTest(scenario=path.stem):
                m=run_scenario(self.model,read(path));self.assertEqual(crosscheck_trace(self.model,m.trace)['status'],'match')
