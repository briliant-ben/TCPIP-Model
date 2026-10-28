"""Finite congestion decisions, queue ownership and negative controls."""
import copy
import hashlib
import json
import unittest
from protocol_lab.flow import ROOT,read,run_scenario
from protocol_lab.ir import Machine,ModelError,load
from protocol_lab.symbolic import crosscheck_trace


def established(initial=None,window=16,model=None):
 m=Machine(model or load(ROOT/'model/tcp-congestion.json'),initial)
 m.dispatch('app.connect');m.dispatch('net.synack',{'seq':9000,'ack':m.values['snd_nxt'],'window':window},10);return m

def send(m,data,t=20):m.dispatch('app.send',{'data':data},t)
def flush(m,t=21):m.dispatch('app.transmit',time_ms=t)
def ack(m,n,t=30,w=16,seq=9001):m.dispatch('net.ack',{'seq':seq,'ack':n,'window':w},t)


class CongestionTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):cls.model=load(ROOT/'model/tcp-congestion.json')

 def test_source_lock_and_generator_output(self):
  import subprocess,sys
  lock=read(ROOT/'spec/sources/tcp-congestion.json')[0]
  self.assertEqual(lock['rfc'],5681);self.assertEqual(lock['version'],'September 2009')
  self.assertEqual(hashlib.sha256((ROOT/'spec/sources/rfc5681.txt').read_bytes()).hexdigest(),lock['sha256'])
  before=(ROOT/'model/tcp-congestion.json').read_bytes()
  subprocess.run([sys.executable,str(ROOT/'tools/build_congestion_model.py')],check=True,capture_output=True)
  self.assertEqual((ROOT/'model/tcp-congestion.json').read_bytes(),before)

 def test_window_gate_partial_ack_and_no_zero_length_send(self):
  m=established(model=self.model);send(m,list(range(8)));flush(m);flush(m,22)
  self.assertEqual((m.values['snd_nxt'],m.values['rtx_buf'],m.values['cc_cwnd']),(1005,[0,1,2,3],4))
  self.assertEqual(m.trace[-1]['transition'],'D-FLUSH-BLOCKED')
  ack(m,1003);self.assertEqual((m.values['cc_cwnd'],m.values['cc_acked']),(6,2));flush(m,31)
  self.assertEqual(m.values['rtx_buf'],[2,3,4,5,6,7]);self.assertEqual(m.values['snd_nxt'],1009)
  ack(m,1009,40);self.assertEqual(m.values['cc_cwnd'],10)

 def test_ca_counts_bytes_not_ack_packets_and_drops_excess_credit(self):
  m=established({'cc_initial_window':8,'cc_initial_threshold':8},model=self.model)
  send(m,list(range(8)));flush(m);flush(m)
  for i in range(1,5):ack(m,1001+i,30+i)
  self.assertEqual((m.values['cc_cwnd'],m.values['cc_ca_credit']),(8,4))
  ack(m,1005,36);self.assertEqual(m.values['cc_ca_credit'],4)
  ack(m,1009,40);self.assertEqual((m.values['cc_cwnd'],m.values['cc_ca_credit']),(12,0))

 def test_invalid_old_future_and_unacceptable_seq_do_not_grow(self):
  m=established(model=self.model);send(m,[0,128,255,7]);flush(m)
  for n,t,seq in [(1009,30,9001),(1000,31,9001),(1005,32,9000),(1001,33,9001)]:
   ack(m,n,t,seq=seq);self.assertEqual((m.values['cc_cwnd'],m.values['cc_acked']),(4,0))
  ack(m,1005,40);self.assertEqual(m.values['cc_cwnd'],8)

 def test_actual_first_repeat_and_early_rto(self):
  m=established({'cc_initial_window':16,'cc_initial_threshold':32},model=self.model)
  send(m,list(range(8)));flush(m);flush(m,22);m.tick(1021)
  self.assertEqual((m.values['cc_cwnd'],m.values['cc_ssthresh'],m.values['cc_threshold_updates']),(4,8,1))
  self.assertEqual([m.values[f'cc_rto_{i:02}']for i in range(8)],[True]*4+[False]*4)
  self.assertGreater(len(m.values['rtx_buf']),m.values['cc_cwnd']) # old flight survives collapse
  m.tick(3021);self.assertEqual(m.values['cc_threshold_updates'],1)
  m.timers['rtx']=3022;m.tick(3022)
  self.assertFalse(m.values['cc_loss']);self.assertEqual(m.values['cc_threshold_updates'],1)

 def test_ack_shift_exposes_a_fresh_oldest_timeout_epoch(self):
  m=established({'cc_initial_window':16,'cc_initial_threshold':32},model=self.model)
  send(m,list(range(8)));flush(m);flush(m);m.tick(1021);ack(m,1005,1100)
  self.assertFalse(m.values['cc_rto_00']);self.assertEqual(m.values['cc_cwnd'],8)
  m.tick(3100);self.assertEqual(m.values['cc_threshold_updates'],2)
  self.assertEqual(m.values['cc_cwnd'],4)

 def test_persist_probe_and_reopen_ack_do_not_inflate_or_collapse(self):
  m=established(window=0,model=self.model);send(m,[0,128]);m.tick(1020);ack(m,1002,1100,w=0)
  self.assertEqual(m.values['cc_cwnd'],4);self.assertEqual(m.values['cc_growth'],0)
  m.tick(3020);ack(m,1003,3200,w=16)
  self.assertEqual((m.values['cc_cwnd'],m.values['cc_threshold_updates']),(4,0));self.assertFalse(m.values['persist_active'])

 def test_cwnd_gate_composes_with_pending_close_and_fin_ack(self):
  m=established(model=self.model);send(m,list(range(8)));flush(m);m.dispatch('app.close',time_ms=22);flush(m,23)
  self.assertEqual(m.values['snd_nxt'],1005);ack(m,1005,30);flush(m,31);flush(m,32)
  self.assertTrue(m.values['fin_sent']);ack(m,1010,40)
  self.assertEqual((m.state,m.values['cc_cwnd'],m.values['cc_acked']),('FIN-WAIT-2',12,4))

 def test_close_wait_data_gate_uses_same_window(self):
  m=established(model=self.model);m.dispatch('net.fin_segment',{'seq':9001,'ack':1001,'window':16,'data':[]},20)
  send(m,list(range(8)),21);flush(m,22);flush(m,23)
  self.assertEqual(m.state,'CLOSE-WAIT');self.assertEqual(m.values['snd_nxt'],1005)

 def test_bad_config_and_growth_fault_are_rejected(self):
  with self.assertRaisesRegex(ModelError,'CC-INV-CONFIG'):Machine(self.model,{'cc_initial_window':17})
  broken=copy.deepcopy(self.model)
  t=next(t for t in broken['transitions']if t['id']=='S-ACK-VALID')
  action=next(a for a in t['actions']if 'set'in a and a['set']['var']=='cc_growth')
  action['set']['value']=5
  m=established(model=broken);send(m,[0,128,255,7]);flush(m)
  with self.assertRaisesRegex(ModelError,'CC-INV-BOUNDS'):ack(m,1005)

 def test_slow_start_ack_division_and_sequence_wrap(self):
  m=established({'iss':2**32-3},model=self.model);send(m,[0,128,255,7]);flush(m)
  for i in range(1,5):
   ack(m,(2**32-2+i)%(2**32),30+i)
   self.assertEqual(m.values['cc_cwnd'],4+i)

 def test_handwritten_scenarios_full_byte_symbolic_replay(self):
  for path in sorted((ROOT/'scenarios/congestion').glob('*.json')):
   with self.subTest(scenario=path.stem):
    m=run_scenario(self.model,read(path));self.assertEqual(crosscheck_trace(self.model,m.trace)['status'],'match')

if __name__=='__main__':unittest.main(verbosity=2)
