"""Unit fixtures test adapters/rejection, never Linux peer execution evidence."""
import json
from pathlib import Path
import shutil
import struct
import tempfile
import unittest
from unittest.mock import patch
import run as driver
from capture import records
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build
from protocol_lab.codegen.wire_execute import write_raw_pcap


class PeerAdapterTests(unittest.TestCase):
    def test_shared_namespace_is_rejected(self):
        for a,b in [('net:[1]','net:[1]'),('','net:[2]')]:
            with self.assertRaises(ValueError):driver.isolation(a,b)
        driver.isolation('net:[1]','net:[2]')

    def test_same_length_changed_payload_is_rejected(self):
        with self.assertRaisesRegex(ValueError,'payload differs'):driver.verify_payload(b'abc',b'bca')

    def test_egress_bytes_are_unchanged_and_extra_datagrams_reject(self):
        event=dict(emitted=[dict(message='ipv4.tx',fields=dict(packet=[0,128,255]))])
        self.assertEqual(driver.egress([event]),b'\0\x80\xff')
        with self.assertRaises(ValueError):driver.egress([event,event])

    def test_actual_pcap_shapes_and_corruption_reject(self):
        oracle=json.loads((driver.ROOT/'spec/udp-wire-receive-oracle.json').read_text())
        raw=bytes.fromhex(oracle['cases']['odd-NUL']['hex'])
        with tempfile.TemporaryDirectory()as temporary:
            path=Path(temporary)/'fixture.pcap';write_raw_pcap(path,[(0,raw),(1,raw)])
            decoded=records(path);self.assertEqual([r['timestamp_ns']for r in decoded],[0,1000000]);self.assertEqual(decoded[0]['hex'],raw.hex())
            original=path.read_bytes();path.write_bytes(original[:-1])
            with self.assertRaises(ValueError):records(path)
            bad=bytearray(raw);bad[-1]^=1;write_raw_pcap(path,[(0,bytes(bad))])
            with self.assertRaisesRegex(ValueError,'UDP checksum'):records(path)
            path.write_bytes(struct.pack('>IHHIIII',0xa1b23c4d,2,4,0,0,65535,101)+struct.pack('>IIII',1,123, len(raw),len(raw))+raw)
            self.assertEqual(records(path)[0]['timestamp_ns'],1000000123)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_complete_fixture_assessment_and_tamper_gates(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);cfg=json.loads((driver.PORT/'cases.json').read_text());cfg['scenarios']=cfg['scenarios'][:1]
            port=out/'fake-port';port.mkdir();(port/'cases.json').write_text(json.dumps(cfg))
            for kind in ('tx','rx'):
                generate(driver.ROOT/cfg[kind+'_model'],out/(kind+'-source'));self.assertEqual(build(out/(kind+'-source'),out/(kind+'-build'))['status'],'pass')
            scene=json.loads((driver.ROOT/cfg['scenarios'][0]).read_text())
            with patch.object(driver,'PORT',port),patch.object(driver,'compare',side_effect=AssertionError('Reference cannot construct actual egress')):
                observed,code=driver.native(out,'tx','case-0',scene);self.assertEqual(code,0);tx=driver.egress(observed)
            oracle=json.loads((driver.ROOT/'spec/udp-wire-receive-oracle.json').read_text());rx=bytes.fromhex(oracle['cases']['empty']['hex'])
            (out/'case-0/tx.raw').write_bytes(tx);(out/'case-0/rx.raw').write_bytes(rx)
            rxscene=dict(scenario_version='0.1',id='fixture',initial={},steps=[dict(at_ms=0,event='net.packet',fields=dict(packet=list(rx)))],expect=dict(state='READY',variables=dict(payload=[],disposition='deliver'),timers={}))
            with patch.object(driver,'PORT',port):driver.native(out,'rx','case-0',rxscene)
            write_raw_pcap(out/'capture.pcap',[(0,tx),(1,rx)])
            (out/'capture.log').write_text('0 packets dropped by kernel\n')
            namespace=dict(parent_netns='net:[1]',execution_netns='net:[2]',actual_parent_netns='net:[1]',host_network_mutations=False,generated_subject_uses_host_stack=False,packet_bytes_rewritten=False,capture_packet_limit=None,capture_command=['fixture','--immediate-mode'],capture_ready_monotonic_ns=1,last_inject_monotonic_ns=2,last_reply_read_monotonic_ns=3,capture_stop_request_monotonic_ns=100000003,capture_exit_monotonic_ns=100000004,socket_and_tun_closed_monotonic_ns=100000005,capture_returncode=0,quiet_ms=100)
            (out/'namespace.json').write_text(json.dumps(namespace));trial=dict(case='case-0',scenario=cfg['scenarios'][0],peer_received_hex='',peer_source=['192.0.2.1',40000],peer_send_bytes=0)
            (out/'trials.json').write_text(json.dumps([trial]))
            with patch.object(driver,'PORT',port):self.assertEqual(driver.assess(out)['status'],'pass')
            namespace['capture_stop_request_monotonic_ns']=100000002;(out/'namespace.json').write_text(json.dumps(namespace))
            with patch.object(driver,'PORT',port),self.assertRaisesRegex(ValueError,'Quiet capture'):driver.assess(out)
            namespace['capture_stop_request_monotonic_ns']=100000003;(out/'namespace.json').write_text(json.dumps(namespace))
            changed=bytearray(tx);changed[10]^=1;(out/'case-0/tx.raw').write_bytes(changed)
            with patch.object(driver,'PORT',port),self.assertRaisesRegex(ValueError,'egress'):driver.assess(out)
            (out/'case-0/tx.raw').write_bytes(tx)
            trial['peer_received_hex']='00';(out/'trials.json').write_text(json.dumps([trial]))
            with patch.object(driver,'PORT',port),self.assertRaisesRegex(ValueError,'payload differs'):driver.assess(out)


if __name__=='__main__':unittest.main(verbosity=2)
