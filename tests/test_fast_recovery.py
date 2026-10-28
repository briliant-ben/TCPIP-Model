"""Finite Reno byte output, ACK classification, Karn and timer fault tests."""
import copy
import tempfile
import unittest
from protocol_lab.flow import ROOT,read,run_scenario
from protocol_lab.ir import MOD,Machine,ModelError,load
from protocol_lab.symbolic import crosscheck_trace


def setup(model,initial=None,window=16,data=None):
 m=Machine(model,initial or {'cc_initial_window':16});m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':m.values['snd_nxt'],'window':window},10)
 if data is not None:m.dispatch('app.send',{'data':data},20)
 return m

def flush(m,n=4,t=21):
 for _ in range(n):m.dispatch('app.transmit',time_ms=t)
def ack(m,t=30,n=None,w=16,seq=None):
 m.dispatch('net.ack',{'seq':m.values['rcv_nxt']if seq is None else seq,'ack':m.values['snd_una']if n is None else n,'window':w},t)
def wire(m):return [a for a in m.trace[-1]['emitted']if a['message']in ('tcp','tcp_data')]


class FastRecoveryTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):cls.model=load(ROOT/'model/tcp-fast-recovery.json')

 def full(self):
  m=setup(self.model,data=list(range(16)));flush(m);return m

 def trigger(self,m):
  for t in (30,31,32):ack(m,t)

 def test_third_ack_retransmits_exact_prefix_without_rto_or_sequence_change(self):
  m=self.full();self.assertTrue(m.values['fr_window_valid']);timers=dict(m.timers)
  for t in (30,31):ack(m,t);self.assertEqual(wire(m),[])
  ack(m,32);self.assertTrue(m.values['fr_active']);self.assertEqual((m.values['fr_dupacks'],m.values['cc_ssthresh'],m.values['cc_cwnd']),(3,8,20))
  self.assertEqual(wire(m),[{'message':'tcp_data','fields':{'flags':'A','seq':1001,'ack':9001,'window':16,'payload':[0,1,2,3]}}])
  self.assertEqual(m.values['snd_nxt'],1017);self.assertEqual(m.timers,timers)
  self.assertEqual((m.values['rto_ms'],m.values['retries']),(1000,0));self.assertFalse(m.values['tx_retransmitted'])
  self.assertTrue(m.values['rtt_ambiguous']);self.assertEqual([m.values[f'tx_time_{i:02}']for i in range(8)],[32]*4+[21]*4)

 def test_extra_dup_inflates_but_does_not_retransmit_and_new_ack_deflates(self):
  m=self.full();self.trigger(m);ack(m,33);self.assertEqual(m.values['cc_cwnd'],24);self.assertEqual(wire(m),[])
  ack(m,40,1017);self.assertFalse(m.values['fr_active']);self.assertEqual((m.values['cc_cwnd'],m.values['cc_ca_credit'],m.values['fr_dupacks']),(8,0,0))
  self.assertEqual(m.values['rtt_samples'],1);self.assertFalse(m.values['rtt_sample_used'])

 def test_classic_reno_partial_ack_exits_without_newreno_retransmission(self):
  m=self.full();self.trigger(m);ack(m,40,1003)
  self.assertFalse(m.values['fr_active']);self.assertEqual((m.values['cc_cwnd'],m.values['cc_ca_credit']),(8,0))
  self.assertEqual(m.values['rtx_buf'],list(range(2,16)));self.assertEqual(wire(m),[])

 def test_last_wire_ack_window_is_not_cached_send_window(self):
  m=self.full();ack(m,25,1000,w=8)
  self.assertEqual(m.values['snd_wnd'],16);self.assertEqual(m.values['fr_last_window'],8)
  ack(m,30,w=16);self.assertEqual(m.values['fr_dupacks'],0)
  for t in (31,32,33):ack(m,t)
  self.assertTrue(m.values['fr_active'])

 def test_window_change_payload_fin_invalid_seq_and_future_do_not_count(self):
  m=self.full();ack(m,23,w=8);self.assertEqual(m.values['fr_dupacks'],0)
  ack(m,24,w=16);self.assertEqual(m.values['fr_dupacks'],0)
  m.dispatch('net.data',{'seq':9001,'ack':1001,'window':16,'data':[128]},25)
  self.assertEqual(m.values['fr_dupacks'],0)
  ack(m,26,seq=9001);self.assertEqual(m.values['fr_dupacks'],0) # stale receive sequence
  ack(m,27,1020,w=4);self.assertEqual(m.values['fr_last_window'],16)
  for t in (30,31,32):ack(m,t)
  self.assertTrue(m.values['fr_active']);self.assertFalse(m.values['ack_pending']);self.assertNotIn('delack',m.timers)
  self.assertEqual(wire(m)[0]['fields']['ack'],9002)

 def test_real_fast_piggyback_cancels_pending_delayed_ack(self):
  m=self.full();m.dispatch('net.data',{'seq':9001,'ack':1001,'window':16,'data':[128]},25)
  self.assertTrue(m.values['ack_pending']);self.assertEqual(m.timers['delack'],65)
  for t in (30,31):ack(m,t);self.assertTrue(m.values['ack_pending'])
  ack(m,32);self.assertEqual(wire(m)[0]['fields']['ack'],9002)
  self.assertFalse(m.values['ack_pending']);self.assertNotIn('delack',m.timers)
  count=len(m.trace);m.tick(65);self.assertEqual(len(m.trace),count)

 def test_parent_congestion_scenarios_remain_reference_compatible(self):
  for path in sorted((ROOT/'scenarios/congestion').glob('*.json')):
   with self.subTest(scenario=path.stem):run_scenario(self.model,read(path))

 def test_sending_new_data_during_recovery_obeys_same_budget(self):
  m=setup(self.model,{'cc_initial_window':12},data=list(range(16)));flush(m,3);self.trigger(m);m.dispatch('app.transmit',time_ms=33)
  self.assertEqual(wire(m)[0]['fields']['payload'],[12,13,14,15]);self.assertEqual(m.values['snd_nxt'],1017)
  self.assertEqual(m.values['cc_new_sent'],4);self.assertEqual(m.values['cc_send_budget'],4)

 def test_fast_send_preserves_no_early_timeout_and_actual_loss_exits(self):
  m=self.full();self.trigger(m);m.tick(1021)
  self.assertFalse(m.values['tx_retransmitted']);self.assertTrue(m.values['fr_active']);self.assertEqual(m.timers,{'rtx':1032})
  m.tick(1032);self.assertTrue(m.values['cc_loss']);self.assertFalse(m.values['fr_active']);self.assertEqual(m.values['cc_cwnd'],4)
  self.assertEqual((m.values['fr_dupacks'],m.values['retries']),(0,1))

 def test_persist_zero_window_and_no_flight_do_not_trigger(self):
  m=setup(self.model,window=0,data=[0,128]);m.tick(1020)
  for t in (1030,1031,1032):ack(m,t,w=0)
  self.assertFalse(m.values['fr_active']);self.assertEqual(m.values['fr_dupacks'],0)
  empty=setup(self.model)
  for t in (30,31,32):ack(empty,t)
  self.assertEqual(empty.values['fr_entries'],0)

 def test_canonical_fin_updates_window_without_counting_and_close_wait_recovers(self):
  m=self.full();m.dispatch('net.fin_segment',{'seq':9001,'ack':1001,'window':16,'data':[]},25)
  self.assertEqual(m.state,'CLOSE-WAIT');self.assertEqual(m.values['fr_dupacks'],0);self.trigger(m)
  self.assertTrue(m.values['fr_active']);self.assertEqual(wire(m)[0]['fields']['ack'],9002)

 def test_passive_handshake_seeds_last_window_before_first_duplicate(self):
  m=Machine(self.model,{'cc_initial_window':16});m.dispatch('app.listen')
  m.dispatch('net.syn',{'seq':9000},10)
  m.dispatch('net.ack',{'seq':9001,'ack':1001,'window':16},20)
  self.assertTrue(m.values['fr_window_valid']);self.assertEqual(m.values['fr_last_window'],16)
  m.dispatch('app.send',{'data':list(range(16))},20);flush(m);self.trigger(m)
  self.assertTrue(m.values['fr_active']);self.assertEqual(m.values['fr_dupacks'],3)

 def test_fast_recovery_with_local_fin_outstanding_uses_data_flight(self):
  m=setup(self.model,{'cc_initial_window':12},data=list(range(12)));flush(m,3)
  m.dispatch('app.close',time_ms=25)
  self.assertTrue(m.values['fin_sent']);self.assertEqual(m.state,'FIN-WAIT-1')
  self.trigger(m);self.assertTrue(m.values['fr_active'])
  self.assertEqual(wire(m)[0]['fields']['payload'],[0,1,2,3]);self.assertEqual(m.values['snd_nxt'],1014)
  ack(m,40,1005);self.assertEqual((m.values['cc_cwnd'],m.values['fr_active']),(8,False))
  ack(m,50,1014);self.assertEqual(m.state,'FIN-WAIT-2');self.assertEqual(m.timers,{'user':30025})

 def test_cached_zero_window_does_not_enter_without_retransmission(self):
  m=self.full();ack(m,25,w=0,seq=9005);ack(m,26,1000,w=16,seq=9005)
  self.assertEqual((m.values['snd_wnd'],m.values['fr_last_window']),(0,16))
  for t in (30,31,32):
   ack(m,t);self.assertEqual(wire(m),[])
  self.assertEqual((m.values['fr_active'],m.values['fr_dupacks'],m.values['cc_cwnd']),(False,0,16))
  ack(m,40,seq=9005);self.assertEqual(m.values['snd_wnd'],16)
  for t in (41,42,43):ack(m,t,seq=9005)
  self.assertTrue(m.values['fr_entered']);self.assertTrue(m.values['fr_retransmitted'])

 def test_rejected_payload_and_fin_preserve_accepted_window_and_third_ack(self):
  cases=[('net.data',9030,1001,[128]),('net.data',9001,1020,[128]),('net.fin_segment',9030,1001,[])]
  for name,seq,number,data in cases:
   with self.subTest(event=name,seq=seq,ack=number):
    m=self.full();m.dispatch(name,{'seq':seq,'ack':number,'window':8,'data':data},25)
    self.assertTrue(m.values['fr_window_ignored']);self.assertEqual(m.values['fr_last_window'],16)
    self.assertEqual(m.values['rcv_nxt'],9001);self.trigger(m);self.assertTrue(m.values['fr_retransmitted'])
  broken=copy.deepcopy(self.model);t=next(t for t in broken['transitions']if t['id']=='F-RECEIVE-ESTABLISHED-net-data')
  next(a for a in reversed(t['actions'])if 'set'in a and a['set']['var']=='fr_last_window')['set']['value']={'event':'window'}
  m=setup(broken,data=list(range(16)));flush(m)
  with self.assertRaisesRegex(ModelError,'FR-INV-WINDOW-IGNORED'):
   m.dispatch('net.data',{'seq':9030,'ack':1001,'window':8,'data':[128]},25)

 def test_wrap_and_reset_cleanup(self):
  m=setup(self.model,{'cc_initial_window':16,'iss':MOD-3},data=list(range(16)));flush(m);self.trigger(m)
  self.assertEqual(wire(m)[0]['fields']['seq'],MOD-2)
  ack(m,40,(MOD-2+16)%MOD);self.assertFalse(m.values['fr_active'])
  m.dispatch('app.abort',time_ms=41);self.assertFalse(m.values['fr_window_valid']);self.assertEqual(m.values['fr_dupacks'],0)

 def test_early_trigger_and_wrong_deflation_faults_rejected(self):
  for field,value,expected in [('fr_emit_count',0,'FR-INV-FAST-CAUSE'),('cc_cwnd',4,'FR-INV-ENTRY-WINDOW')]:
   broken=copy.deepcopy(self.model);t=next(t for t in broken['transitions']if t['id']=='S-ACK-VALID')
   if field=='fr_emit_count':
    # Remove actual retransmission while retaining the entry obligation below.
    a=next(a for a in reversed(t['actions'])if 'set'in a and a['set']['var']=='fr_retransmitted');a['set']['value']=True
    next(a for a in t['actions']if 'set'in a and a['set']['var']=='fr_emit_count')['set']['value']=0
   else:next(a for a in reversed(t['actions'])if 'set'in a and a['set']['var']=='cc_cwnd')['set']['value']=value
   m=setup(broken,data=list(range(16)));flush(m)
   with self.subTest(field=field),self.assertRaisesRegex(ModelError,expected):self.trigger(m)

 def test_source_pins_and_reproducible_generator(self):
  import hashlib,subprocess,sys
  for source in read(ROOT/'spec/sources/tcp-fast-recovery.json'):
   path=ROOT/'spec/sources'/('rfc'+str(source['rfc'])+'.txt')
   self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),source['sha256'])
  before=(ROOT/'model/tcp-fast-recovery.json').read_bytes();subprocess.run([sys.executable,str(ROOT/'tools/build_fast_recovery_model.py')],check=True,capture_output=True)
  self.assertEqual((ROOT/'model/tcp-fast-recovery.json').read_bytes(),before)

 def test_handwritten_scenarios_have_full_byte_replay(self):
  paths=sorted((ROOT/'scenarios/fast-recovery').glob('*.json'));self.assertGreaterEqual(len(paths),6)
  for path in paths:
   with self.subTest(scenario=path.stem):
    m=run_scenario(self.model,read(path));self.assertEqual(crosscheck_trace(self.model,m.trace)['status'],'match')

if __name__=='__main__':unittest.main(verbosity=2)
