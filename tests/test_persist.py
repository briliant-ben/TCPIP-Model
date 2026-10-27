"""Independent byte, sequence, deadline and ownership checks for persist."""
import copy
import unittest

from protocol_lab.flow import ROOT,read,run_scenario,TraceContractMismatch
from protocol_lab.ir import MOD,Machine,ModelError,load
from protocol_lab.symbolic import crosscheck_trace


def established(model=None,window=0,initial=None):
    m=Machine(model or load(ROOT/'model/tcp-persist.json'),initial)
    m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':m.values['snd_nxt'],'window':window},10)
    return m


def ack(m,at,number,window=0):
    m.dispatch('net.ack',{'seq':m.values['rcv_nxt'],'ack':number,'window':window},at)


def queue(m,at=20,values=None):m.dispatch('app.send',{'data':values if values is not None else[0,128,255]},at)


def wire(row):return [o for o in row['emitted']if o['message']in ('tcp','tcp_data')]


class PersistTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):cls.model=load(ROOT/'model/tcp-persist.json')

    def test_first_probe_and_repeat_share_queue_and_consume_sequence_once(self):
        m=established(self.model);queue(m)
        self.assertEqual(m.timers,{'persist':1020});n=len(m.trace);m.tick(1019);self.assertEqual(len(m.trace),n)
        m.tick(1020);self.assertEqual(wire(m.trace[-1])[0]['fields'],{'flags':'A','seq':1001,'ack':9001,'window':16,'payload':[0]})
        self.assertEqual(m.values['snd_nxt'],1002);self.assertEqual(m.values['rtx_buf'],[0]);self.assertEqual(m.values['snd_buf'],[128,255])
        ack(m,1100,1001);self.assertEqual(m.timers,{'persist':3020});m.tick(3020)
        self.assertEqual(wire(m.trace[-1])[0]['fields']['payload'],[0]);self.assertEqual(m.values['snd_nxt'],1002)
        self.assertEqual(m.values['tx_time_00'],3020);self.assertEqual(m.timers,{'persist':7020})
        self.assertEqual(m.values['rto_ms'],1000);self.assertEqual(m.values['retries'],0)
        self.assertEqual(m.values['rtt_samples'],1);self.assertFalse(m.values['rtt_active'])

    def test_acked_probe_allows_next_new_byte_on_existing_deadline(self):
        m=established(self.model);queue(m,values=[0,128]);m.tick(1020);ack(m,1100,1002)
        self.assertEqual(m.values['rtx_buf'],[]);self.assertEqual(m.values['snd_una'],m.values['snd_nxt'])
        self.assertEqual(m.timers,{'persist':3020});m.tick(3020)
        f=wire(m.trace[-1])[0]['fields'];self.assertEqual((f['seq'],f['payload']),(1002,[128]))
        self.assertEqual(m.values['snd_nxt'],1003);self.assertEqual(m.values['snd_buf'],[])

    def test_window_reopening_transfers_only_unacknowledged_flight_to_rto(self):
        for confirmed in (False,True):
            with self.subTest(confirmed=confirmed):
                m=established(self.model);queue(m,values=[0,128]);m.tick(1020)
                ack(m,1100,1002 if confirmed else 1001,window=4)
                self.assertFalse(m.values['persist_active']);self.assertNotIn('persist',m.timers)
                self.assertEqual(m.timers,{}if confirmed else{'rtx':2100})
                self.assertEqual(m.values['rtx_buf'],[]if confirmed else[0])
                self.assertEqual(m.values['persist_probes'],0)
                m.dispatch('app.transmit',time_ms=1101)
                self.assertEqual(wire(m.trace[-1])[0]['fields']['payload'],[128])
                self.assertEqual(m.timers,{'rtx':2101 if confirmed else 2100})

    def test_window_opens_before_first_probe_and_no_data_never_starts_timer(self):
        empty=established(self.model);empty.tick(100000);self.assertEqual(empty.timers,{})
        m=established(self.model);queue(m,values=[0,128]);ack(m,100,1001,window=2)
        self.assertEqual(m.timers,{});m.dispatch('app.transmit',time_ms=101)
        self.assertEqual(wire(m.trace[-1])[0]['fields']['payload'],[0,128]);self.assertEqual(m.timers,{'rtx':1101})

    def test_duplicate_updates_new_queue_and_blocked_transmit_do_not_postpone(self):
        m=established(self.model);queue(m);ack(m,30,1001);queue(m,40,[9]);m.dispatch('app.transmit',time_ms=50)
        self.assertEqual(m.timers,{'persist':1020});self.assertEqual(m.values['persist_since_ms'],20)
        m.tick(1020);ack(m,1100,1007,window=16) # invalid future ACK must not grant this window
        self.assertEqual(m.values['snd_wnd'],0);self.assertEqual(m.timers,{'persist':3020})

    def test_early_timer_fault_waits_without_output_backoff_or_count(self):
        m=established(self.model);queue(m);m.timers['persist']=30;m.tick(30)
        self.assertEqual(wire(m.trace[-1]),[]);self.assertEqual(m.timers,{'persist':1020})
        self.assertEqual(m.values['persist_interval_ms'],1000);self.assertEqual(m.values['persist_probes'],0)
        self.assertEqual(m.values['snd_nxt'],1001);m.tick(1020);self.assertEqual(m.values['persist_probes'],1)

    def test_exponential_cap_and_responsive_zero_window_do_not_abort_connection(self):
        m=established(self.model);queue(m,values=[0])
        for at,next_at in ((1020,3020),(3020,7020),(7020,15020),(15020,31020),(31020,63020),(63020,123020),(123020,183020)):
            m.tick(at);ack(m,at+1,1001);self.assertEqual(m.timers,{'persist':next_at})
        self.assertEqual(m.state,'ESTABLISHED');self.assertEqual(m.values['persist_probes'],7)
        self.assertEqual(m.values['persist_interval_ms'],60000);self.assertEqual(m.values['retries'],0)
        self.assertEqual(m.values['rto_ms'],1000)

    def test_existing_flight_keeps_parent_rto_and_ack_can_enter_no_flight_mode(self):
        m=established(self.model,window=16);queue(m,values=[0,1,2,3,4,5]);m.dispatch('app.transmit',time_ms=21)
        ack(m,30,1001,window=0);self.assertEqual(m.timers,{'rtx':1021});self.assertFalse(m.values['persist_active'])
        ack(m,40,1005,window=0);self.assertEqual(m.timers,{'persist':1040});self.assertEqual(m.values['snd_buf'],[4,5])
        m.tick(1040);self.assertEqual(wire(m.trace[-1])[0]['fields']['seq'],1005)

    def test_half_close_reset_and_abort_preserve_or_clear_ownership(self):
        for mode in ('local_close','peer_close','simultaneous_close','peer_then_local_close','reset','abort'):
            with self.subTest(mode=mode):
                m=established(self.model)
                if mode in ('peer_close','peer_then_local_close'):m.dispatch('net.fin_segment',{'seq':9001,'ack':1001,'window':0,'data':[]},15)
                queue(m,values=[0,1])
                if mode in ('local_close','peer_then_local_close','simultaneous_close'):m.dispatch('app.close',time_ms=30)
                if mode=='simultaneous_close':m.dispatch('net.fin',{'seq':9001,'ack':1001},40)
                elif mode=='reset':m.dispatch('net.rst',{'seq':9001},30)
                elif mode=='abort':m.dispatch('app.abort',time_ms=30)
                if mode in ('reset','abort'):
                    self.assertEqual(m.state,'CLOSED');self.assertEqual(m.timers,{});self.assertFalse(m.values['persist_active'])
                else:
                    expected={'local_close':'FIN-WAIT-1','peer_close':'CLOSE-WAIT','simultaneous_close':'CLOSING','peer_then_local_close':'CLOSE-WAIT'}
                    self.assertEqual(m.state,expected[mode])
                    m.tick(1020);self.assertEqual(wire(m.trace[-1])[0]['fields']['payload'],[0]);self.assertNotIn('rtx',m.timers)

    def test_declared_pending_last_ack_fixture_is_not_a_reachability_claim(self):
        # Explicit arbitrary legal state fixture, separate from reachable lifecycle scenarios.
        m=established(self.model);m.dispatch('net.fin_segment',{'seq':9001,'ack':1001,'window':0,'data':[]},15)
        queue(m,values=[0,1]);m.dispatch('app.close',time_ms=30)
        m.state='LAST-ACK';m.timers['user']=30030 # required by the parent's declared LAST-ACK state
        m.check_invariants();m.tick(1020)
        self.assertEqual(m.state,'LAST-ACK')
        self.assertEqual(wire(m.trace[-1])[0]['fields'],{'flags':'A','seq':1001,'ack':9002,'window':16,'payload':[0]})
        self.assertEqual(m.timers,{'persist':3020,'user':30030})

    def test_probe_piggybacks_pending_ack_and_same_time_window_update_follows_timer(self):
        m=established(self.model);queue(m)
        m.dispatch('net.data',{'seq':9001,'ack':1001,'window':0,'data':[9,8]},1000)
        self.assertEqual(m.timers,{'persist':1020,'delack':1040});m.tick(1020)
        self.assertEqual(wire(m.trace[-1])[0]['fields']['ack'],9003);self.assertNotIn('delack',m.timers)
        tie=established(self.model);queue(tie);n=len(tie.trace);ack(tie,1020,1002,window=4)
        self.assertEqual([r['event']['name']for r in tie.trace[n:]],['timer.persist','net.ack'])
        self.assertEqual(tie.timers,{});self.assertEqual(tie.values['snd_una'],1002)

    def test_wrap_and_faulty_sequence_or_missing_history_fail_atomically(self):
        m=established(self.model,initial={'iss':MOD-2});queue(m,values=[0,128]);m.tick(1020)
        self.assertEqual(m.values['snd_nxt'],0);ack(m,1100,0);m.tick(3020)
        self.assertEqual(wire(m.trace[-1])[0]['fields']['seq'],0);self.assertEqual(m.values['snd_nxt'],1)
        for field,error in (('snd_nxt','CL-INV-FLIGHT'),('tx_time_00','P-INV-PROBE-HISTORY')):
            model=copy.deepcopy(self.model)
            for r in model['transitions']:
                if r['id']=='PERSIST-PROBE-ESTABLISHED':
                    for action in r['actions']:
                        if action.get('set',{}).get('var')==field:
                            action['set']['value']={'op':'seq_add','args':[{'var':'snd_nxt'},2]}if field=='snd_nxt'else 0
            bad=established(model);queue(bad);before=copy.deepcopy((bad.now_ms,bad.snapshot(),bad.trace))
            with self.subTest(field=field),self.assertRaisesRegex(ModelError,error):bad.tick(1020)
            self.assertEqual((bad.now_ms,bad.snapshot(),bad.trace),before)

    def test_duplicate_timer_ownership_and_missing_normal_rto_are_rejected(self):
        for probe in (True,False):
            model=copy.deepcopy(self.model)
            for r in model['transitions']:
                if probe and r['id']=='PERSIST-PROBE-ESTABLISHED':r['actions'].append({'arm':{'timer':'rtx','delay_ms':1000}})
                if not probe and r['id']=='D-FLUSH-FIRST':r['actions']=[a for a in r['actions']if a.get('arm',{}).get('timer')!='rtx']
            m=established(model,window=0 if probe else 16);queue(m)
            with self.subTest(probe=probe),self.assertRaisesRegex(ModelError,'P-INV-TIMER-OWNERSHIP'):
                if probe:m.tick(1020)
                else:m.dispatch('app.transmit',time_ms=21)

    def test_fixed_handwritten_scenarios_have_full_byte_replays(self):
        paths=sorted((ROOT/'scenarios/persist').glob('*.json'));self.assertGreaterEqual(len(paths),7)
        for path in paths:
            with self.subTest(scenario=path.stem):
                m=run_scenario(self.model,read(path));self.assertEqual(crosscheck_trace(self.model,m.trace)['status'],'match')
