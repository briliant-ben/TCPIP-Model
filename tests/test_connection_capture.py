"""Independent raw-PCAP fixtures for explicit partial/passive/simultaneous opens."""
import copy
from pathlib import Path
import tempfile
import unittest

from protocol_lab.capture import normalize
from protocol_lab.flow import ROOT,read,run_scenario
from protocol_lab.ir import ModelError,load
from protocol_lab.packets import compare,write_pcap
from protocol_lab.profiles import control_packets
from test_validation import PROFILE,wire_fixture


def packet(direction,flags,seq,ack,at,payload=None):
    return {'direction':direction,'flags':flags,'seq':seq,'ack':ack,'time_ms':at,'window':12345,'payload':payload or [],'packet_id':'fixture','event_id':'fixture','requirements':['fixture']}


class ConnectionCaptureTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup)
        self.path=Path(self.temp.name)/'raw.pcap'

    def check(self,rows,expected):
        wire_fixture(self.path,rows=rows)
        observed,meta=normalize(self.path,PROFILE,expected,origin='synthetic',projection='tcp-connection-v1')
        self.assertEqual(compare(expected,observed,tolerance_ms=0,projection='tcp-connection-v1')['status'],'match')
        return observed,meta

    def test_passive_raw_capture_anchors_both_endpoint_syns_and_original_time_offset(self):
        rows=[(0,False,2,55,0),(0,True,18,0xffffffff,56),(1000,True,18,0xffffffff,56)]
        expected=[packet('in','S',9000,0,50),packet('out','SA',1000,9001,50),packet('out','SA',1000,9001,1050)]
        _,meta=self.check(rows,expected)
        self.assertEqual((meta['wire_local_iss'],meta['wire_peer_iss']),(0xffffffff,55))
        with self.assertRaisesRegex(ModelError,'initial outgoing SYN'):normalize(self.path,PROFILE,expected,projection='tcp-fin-v1')

    def test_simultaneous_open_uses_incoming_syn_without_requiring_synack(self):
        rows=[(0,True,2,0xffffffff,0),(900,False,2,55,0),(900,True,18,0xffffffff,56),(1900,True,18,0xffffffff,56)]
        expected=[packet('out','S',1000,0,0),packet('in','S',9000,0,900),packet('out','SA',1000,9001,900),packet('out','SA',1000,9001,1900)]
        self.check(rows,expected)
        rows[2]=(900,True,18,0xffffffff,57);wire_fixture(self.path,rows=rows)
        observed,_=normalize(self.path,PROFILE,expected,projection='tcp-connection-v1')
        self.assertTrue(any(d.get('field')=='ack'for d in compare(expected,observed,projection='tcp-connection-v1')['differences']))

    def test_partial_syn_only_capture_has_no_fabricated_peer_iss_or_retransmission_alignment(self):
        rows=[(0,True,2,0xffffffff,0),(1000,True,2,0xffffffff,0)]
        expected=[packet('out','S',1000,0,0),packet('out','S',1000,0,1000)]
        _,meta=self.check(rows,expected);self.assertIsNone(meta['wire_peer_iss'])
        with self.assertRaisesRegex(ModelError,'No peer SYN'):normalize(self.path,PROFILE,expected,projection='tcp-fin-v1')
        rows[1]=(1000,True,2,0,0);wire_fixture(self.path,rows=rows)
        observed,_=normalize(self.path,PROFILE,expected,projection='tcp-connection-v1')
        self.assertTrue(any(d.get('field')=='seq'for d in compare(expected,observed,projection='tcp-connection-v1')['differences']))

    def test_missing_anchor_is_rejected_when_sequence_or_ack_requires_it(self):
        expected=[packet('out','S',1000,0,0),packet('out','A',1001,9001,10)]
        for row in ((10,True,16,0,56),(10,False,16,56,0)):
            wire_fixture(self.path,rows=[(0,True,2,0xffffffff,0),row])
            with self.subTest(row=row),self.assertRaisesRegex(ModelError,'SYN anchor'):
                normalize(self.path,PROFILE,expected,projection='tcp-connection-v1')

    def test_fin_payload_window_ack_and_order_remain_strict(self):
        rows=[(0,False,2,55,0),(0,True,18,0xffffffff,56),(10,False,16,56,0),(20,False,17,56,0,12345,b'\x80\xff')]
        expected=[packet('in','S',9000,0,0),packet('out','SA',1000,9001,0),packet('in','A',9001,1001,10),packet('in','FA',9001,1001,20,[128,255])]
        observed,_=self.check(rows,expected);bad=copy.deepcopy(observed)
        bad[-1].update(payload=[128,0],window=1,ack=1002)
        diff=compare(expected,bad,projection='tcp-connection-v1')
        self.assertTrue({'payload','window','ack'}<={d.get('field')for d in diff['differences']})
        bad=copy.deepcopy(observed);bad.reverse()
        self.assertEqual(compare(expected,bad,projection='tcp-connection-v1')['status'],'mismatch')

    def test_checksums_and_unknown_flags_are_still_rejected(self):
        expected=[packet('out','S',1000,0,0)]
        for options in ({'corrupt':True},{'flags_override':3}):
            wire_fixture(self.path,rows=[(0,True,2,0xffffffff,0)],**options)
            with self.subTest(options=options),self.assertRaises(ModelError):
                normalize(self.path,PROFILE,expected,projection='tcp-connection-v1')

    def test_three_new_syn_scenarios_have_synthetic_only_codec_roundtrips(self):
        model=load(ROOT/'model/tcp-syn-history.json')
        for p in sorted((ROOT/'scenarios/syn-history').glob('*.json')):
            with self.subTest(scenario=p.stem):
                scenario=read(p);runtime=run_scenario(model,scenario);expected=control_packets(runtime,scenario)
                write_pcap(self.path,expected)
                actual,meta=normalize(self.path,PROFILE,expected,origin='synthetic',projection='tcp-connection-v1')
                self.assertEqual(compare(expected,actual,tolerance_ms=0,projection='tcp-connection-v1')['status'],'match')
                self.assertEqual(meta['capture_origin'],'synthetic')
