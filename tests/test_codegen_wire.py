"""Real native wire execution and independently decoded packet fault cases."""
import copy
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from protocol_lab.codegen import generate,render,Unsupported
from protocol_lab.codegen.execute import build
from protocol_lab.codegen.wire_execute import run,write_raw_pcap
from protocol_lab.capture import decode,sum_ok
from protocol_lab.ir import load
from protocol_lab.packets import ipv4_tcp

ROOT=Path(__file__).resolve().parents[1]


class NativeWireTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp=tempfile.TemporaryDirectory(prefix='native-wire-tests-');cls.base=Path(cls.tmp.name)
        cls.g=cls.base/'generated';cls.b=cls.base/'build'
        generate(ROOT/'model/tcp.json',cls.g,ROOT/'bindings/tcp-active-open-ipv4.json')
        report=build(cls.g,cls.b)
        if report['status']!='pass':raise AssertionError(report)

    @classmethod
    def tearDownClass(cls):cls.tmp.cleanup()

    def stimulus(self,seq=9000,ack=1001):
        return ipv4_tcp(dict(direction='in',flags='SA',seq=seq,ack=ack,window=65535),0)

    def observe(self,raw,at=10):
        p=subprocess.run([str(self.b/'protocol-native')],input='B\nD 0 app.connect\nP '+str(at)+' '+raw.hex()+'\n',text=True,capture_output=True,env={'PATH':''},timeout=5)
        return p,[json.loads(line)for line in p.stdout.splitlines()]

    def test_four_original_cases_have_actual_native_wire_packets(self):
        for name in ('handshake','syn-loss','two-syn-losses','sequence-wrap'):
            # Actual repository seed filenames are part of the fixture contract.
            scenario=ROOT/'scenarios'/(name+'.json')
            with self.subTest(name=name):
                r=run(self.g,self.b,scenario,self.base/('run-'+name))
                self.assertEqual(r['status'],'pass');self.assertGreaterEqual(r['native_egress_packets'],2)
                self.assertFalse(r['linux_tcp_network_evidence'])
                for record in decode(self.base/('run-'+name)/'native-virtual-link.pcap'):
                    self.assertTrue(sum_ok(record['ip']))
                    self.assertTrue(sum_ok(record['ip'][12:20]+b'\x00\x06'+len(record['tcp']).to_bytes(2,'big')+record['tcp']))

    def test_real_bytes_decode_and_native_runs_without_python_path(self):
        p,rows=self.observe(self.stimulus(seq=4294967295))
        self.assertEqual(p.returncode,0,p.stderr);self.assertEqual(rows[-1]['snapshot']['state'],'ESTABLISHED')
        packets=[bytes.fromhex(r['ipv4_hex'])for r in rows if r['status']=='wire_packet']
        self.assertEqual(int.from_bytes(packets[-1][28:32],'big'),0)
        self.assertEqual(packets[-1][33],16)

    def test_bad_checksum_is_not_accepted_as_an_event(self):
        raw=bytearray(self.stimulus());raw[24]^=1
        p,rows=self.observe(raw,at=1010)
        self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'invalid_wire_checksum')
        self.assertEqual(rows[-1]['snapshot']['state'],'SYN-SENT')
        self.assertEqual(rows[-1]['snapshot']['timers']['syn_rto'],1000)
        self.assertEqual(sum(r['status']=='wire_packet'for r in rows),1)

    def test_unsupported_shapes_and_unrelated_endpoints_remain_explicit(self):
        for index,value,reason in ((0,0x46,'unsupported_wire_shape'),(33,16,'unsupported_wire_shape'),(12,203,'wire_endpoint_outside_profile')):
            with self.subTest(index=index):
                raw=bytearray(self.stimulus());raw[index]=value
                p,rows=self.observe(raw)
                self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],reason)
                self.assertEqual(rows[-1]['snapshot']['state'],'SYN-SENT')

    def test_valid_packet_with_wrong_ack_reaches_ir_guard_and_rolls_back(self):
        p,rows=self.observe(self.stimulus(ack=1000),at=1010)
        self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'uncovered_event')
        self.assertEqual(rows[-1]['snapshot']['variables']['retries'],0)
        self.assertEqual(sum(r['status']=='wire_packet'for r in rows),1)

    def test_binding_cannot_silently_hide_new_network_fields(self):
        m=copy.deepcopy(load(ROOT/'model/tcp.json'));m['events']['net.synack']['fields']['window']='int'
        binding=json.loads((ROOT/'bindings/tcp-active-open-ipv4.json').read_text())
        with self.assertRaises(Unsupported):render(m,binding)

    def test_consistent_wire_sequence_shift_is_not_hidden_by_normalization(self):
        from unittest.mock import patch
        from protocol_lab.codegen.wire import render_codec
        def faulty(model,binding):
            return render_codec(model,binding).replace('wire_put32(p+24,(uint32_t)seq);','wire_put32(p+24,(uint32_t)(seq+1));')
        g=self.base/'fault-generated';b=self.base/'fault-build'
        with patch('protocol_lab.codegen.wire.render_codec',side_effect=faulty):
            generate(ROOT/'model/tcp.json',g,ROOT/'bindings/tcp-active-open-ipv4.json')
            self.assertEqual(build(g,b)['status'],'pass')
        out=self.base/'fault-run'
        r=run(g,b,ROOT/'scenarios/handshake.json',out)
        self.assertEqual(r['status'],'fail')
        difference=json.loads((out/'difference.json').read_text())
        self.assertEqual(difference['events']['status'],'match')
        self.assertEqual(difference['absolute_wire']['status'],'mismatch')

    def test_faulty_native_checksum_retains_invalid_observation_evidence(self):
        from unittest.mock import patch
        from protocol_lab.codegen.wire import render_codec
        def faulty(model,binding):
            return render_codec(model,binding).replace('wire_put16(p+36,wire_tcp_sum(p)^65535);','wire_put16(p+36,(wire_tcp_sum(p)^65535)^1);')
        g=self.base/'bad-checksum-generated';b=self.base/'bad-checksum-build'
        with patch('protocol_lab.codegen.wire.render_codec',side_effect=faulty):
            generate(ROOT/'model/tcp.json',g,ROOT/'bindings/tcp-active-open-ipv4.json')
            self.assertEqual(build(g,b)['status'],'pass')
        out=self.base/'bad-checksum-run';r=run(g,b,ROOT/'scenarios/handshake.json',out)
        self.assertEqual(r['status'],'fail');self.assertEqual(r['classification'],'invalid_observation')
        self.assertIn('checksum',r['reason']);self.assertTrue((out/'native.stdout').exists())
        self.assertTrue((out/'native-virtual-link.pcap').exists())
        self.assertEqual(json.loads((out/'execution.json').read_text())['status'],'fail')

    def test_raw_pcap_recorder_preserves_egress_bytes(self):
        raw=self.stimulus();path=self.base/'raw-recorder.pcap';write_raw_pcap(path,[(10,raw)])
        self.assertEqual(path.read_bytes()[40:],raw)


if __name__=='__main__':unittest.main()
