import unittest,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'ports/linux-tcp-ipv4-peer'))
import probe
class ControllerContracts(unittest.TestCase):
 def test_actual_protocol_offset(self):
  for proto in (6,17):
   frame=b'\x00'*12+b'\x08\x00'+bytes([0x45,0,0,40,0,0,0x40,0,64,proto])+b'\x00'*10
   self.assertEqual(probe.is_tcp_ipv4(frame),proto==6)
 def test_actual_capture_stop_deadline_and_exact_bytes(self):
  frame=b'\x00'*12+b'\x08\x06'+b'\x00'*46
  records=[dict(timestamp_ns=1000000000,raw=frame)]
  stats=dict(captured=1,received=2,dropped=0)
  probe.verify_capture_final(records,[frame],stats,1100000000,100)
  for selected,st,stop in [([frame],stats,1099999999),([],stats,1100000000),([frame+b'\x00'],stats,1100000000),([frame],dict(captured=1,received=2,dropped=1),1100000000),([frame],dict(captured=2,received=2,dropped=0),1100000000)]:
   with self.assertRaises((ValueError,RuntimeError)):probe.verify_capture_final(records,selected,st,stop,100)

 def test_real_log_headers_and_malformed_singular_stats(self):
  from ports.tcp_ipv4_probe_support import capture_stats
  text='tcpdump: listening on tap0\n2 packets captured\n3 packets received by filter\n0 packets dropped by kernel\n'
  self.assertEqual(capture_stats(text),dict(captured=2,received=3,dropped=0))
  for bad in ['-1 packet dropped by kernel','bad packet captured','-1   packet   received by filter']:
   with self.subTest(bad=bad):
    with self.assertRaises(ValueError):capture_stats(text+bad+'\n')

 def test_actual_namespaced_wire_message_is_forwarded_exactly(self):
  import tempfile
  from unittest.mock import patch
  frame=bytes(range(60))
  rows=[dict(status='transition',emitted=[dict(message='L.ethernet.tx',fields=dict(frame=list(frame))),dict(message='L.udp.rx',fields=dict(data=[7]))]),dict(status='ok')]
  with tempfile.TemporaryDirectory() as folder,patch('probe.os.write',return_value=len(frame))as write:
   links,services=[],[]
   r=probe.process_model_operation(rows,123,0,Path(folder),links,services,[])
   self.assertEqual(r['status'],'ok');write.assert_called_once_with(123,frame)
   self.assertEqual(services,[dict(message='L.udp.rx',fields=dict(data=[7]))])
   self.assertEqual((Path(folder)/links[0]['file']).read_bytes(),frame)
 def test_partial_injection_is_rejected(self):
  import tempfile
  from unittest.mock import patch
  rows=[dict(status='transition',emitted=[dict(message='L.ethernet.tx',fields=dict(frame=[1,2,3]))]),dict(status='ok')]
  with tempfile.TemporaryDirectory()as folder,patch('probe.os.write',return_value=1):
   with self.assertRaisesRegex(RuntimeError,'Incomplete TAP write'):
    probe.process_model_operation(rows,123,0,Path(folder),[],[],[])
