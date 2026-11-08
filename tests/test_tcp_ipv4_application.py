import sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'ports/linux-tcp-ipv4-peer'))
import unittest
from application import run_tcp_echo_application
class Port:
 def __init__(self,bad=False,missing=False):self.ops=[];self.waits=0;self.bad=bad;self.missing=missing
 def dispatch(self,event,fields):
  self.ops.append((event,fields))
  if event=='T.app.receive':return []if self.missing else[dict(message='T.application_data',fields=dict(data=[9,9,9,9]if self.bad else[0,128,255,7]))]
  return []
 def wait_for(self,predicate,timeout_s,purpose):
  i=self.waits;self.waits+=1
  snap=dict(variables={'T.control':'TIME-WAIT'if i==3 else'ESTABLISHED','T.rcv_buf':[0,128,255,7]if i==1 else[],'T.rtx_buf':[],'T.snd_buf':[],'T.snd_una':1005,'T.snd_nxt':1005})
  if not predicate(snap):raise AssertionError('Predicate disagrees with correct declared application phase')
  return snap
class Contracts(unittest.TestCase):
 def test_exact_application_sequence(self):
  p=Port();r=run_tcp_echo_application(p)
  self.assertEqual(p.ops,[('T.app.connect',{}),('T.app.send',{'data':[0,128,255,7]}),('T.app.transmit',{}),('T.app.receive',{'count':4}),('T.app.close',{})]);self.assertEqual(p.waits,4);self.assertEqual(r['status'],'application_script_complete');self.assertFalse(r['full_ipv4_endpoint_complete']);self.assertFalse(r['time_wait_expiry_observed'])
 def test_corrupt_or_missing_service_never_fabricated(self):
  for p in [Port(bad=True),Port(missing=True)]:
   with self.assertRaises((ValueError,RuntimeError,AssertionError)):run_tcp_echo_application(p)

 def test_invalid_payload_and_timeout_are_rejected_before_dispatch(self):
  for payload in [[],b'',b'12345']:
   p=Port()
   with self.assertRaises(ValueError):run_tcp_echo_application(p,payload)
   self.assertEqual(p.ops,[])
  for timeout in [True,0,-1,float('inf'),float('nan')]:
   p=Port()
   with self.assertRaises(ValueError):run_tcp_echo_application(p,timeout_s=timeout)
   self.assertEqual(p.ops,[])
 def test_timeout_propagates_without_reset_or_retry(self):
  class TimeoutPort(Port):
   def wait_for(self,*args,**kwargs):raise TimeoutError('fixture timeout')
  p=TimeoutPort()
  with self.assertRaises(TimeoutError):run_tcp_echo_application(p)
  self.assertEqual(p.ops,[('T.app.connect',{})])
