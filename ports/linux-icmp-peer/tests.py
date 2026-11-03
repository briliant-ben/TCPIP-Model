"""Local fixture/PTY faults only; synthetic PCAP never Linux evidence."""
import copy
import json
from pathlib import Path
import shutil
import struct
import tempfile
import unittest
from unittest.mock import patch
import run as driver
from capture import records
from oracle import expected_reply,assert_echo,checksum
from examples.icmp_observe import decode_packet
from ports.native_session import Session
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,commands,compare


class IcmpPeerTests(unittest.TestCase):
    def oracle(self):return json.loads((driver.ROOT/'spec/icmp-echo-oracle.json').read_text())

    def test_frozen_independent_oracle_all_thirteen_inputs(self):
        for name,case in self.oracle()['cases'].items():
            raw=bytes.fromhex(case['hex'])
            if case['disposition']=='reply':self.assertEqual(expected_reply(raw).hex(),case['reply_hex'],name)
            else:
                with self.subTest(case=name),self.assertRaises(ValueError):expected_reply(raw)
        for name,hexraw in self.oracle()['model_gaps'].items():
            with self.subTest(case=name),self.assertRaises(ValueError):expected_reply(bytes.fromhex(hexraw))

    def test_wrong_identifier_with_valid_checksum_is_not_an_echo_match(self):
        case=self.oracle()['cases']['odd-NUL'];raw=bytes.fromhex(case['hex']);bad=bytearray.fromhex(case['reply_hex']);bad[24]^=1;bad[22:24]=b'\0\0';bad[22:24]=struct.pack('!H',checksum(bytes(bad[20:])))
        decoded=decode_packet(bytes(bad));self.assertNotEqual(decoded['identifier'],0x1234)
        with self.assertRaisesRegex(ValueError,'exact Echo'):assert_echo(raw,bytes(bad))

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_all_thirteen_live_ingresses_one_pid_no_reference_drives_subject(self):
        model=driver.load(driver.ROOT/'model/icmp-echo.json');scene=dict(scenario_version='0.2',id='continuous-fixtures',initial={},steps=[])
        for i,(name,c)in enumerate(self.oracle()['cases'].items()):
            emitted=[dict(message='ipv4.tx',fields=dict(packet=list(bytes.fromhex(c['reply_hex']))))]if c['reply_hex']else[]
            scene['steps'].append(dict(at_ms=i,event='net.packet',fields=dict(packet=list(bytes.fromhex(c['hex']))),expect_trace=[dict(at_ms=i,emitted=emitted)]))
        scene['expect']=dict(state='READY',variables=dict(disposition=c['disposition'],reply=list(bytes.fromhex(c['reply_hex']))),timers={})
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(driver.ROOT/'model/icmp-echo.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass');actor=Session(out/'build/protocol-native',out/'native');pid=actor.process.pid
            try:
                with patch('protocol_lab.ir.Machine.dispatch',side_effect=AssertionError('Reference used as live subject')):
                    for line in commands(model,scene).splitlines()[1:]:self.assertEqual(actor.operation(line)[-1]['status'],'ok');self.assertEqual(actor.process.pid,pid)
            finally:self.assertEqual(actor.close(),0)
            rows,session=driver.stream_check(out/'native',model,scene);self.assertEqual(compare(model,scene,rows)['status'],'match');self.assertEqual(session['process_starts'],1)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_reset_ingress_and_pid_tampering_rejected(self):
        model=driver.load(driver.ROOT/'model/icmp-echo.json');scene=json.loads((driver.ROOT/'scenarios/icmp-echo/odd-NUL.json').read_text())
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(driver.ROOT/'model/icmp-echo.json',out/'source');build(out/'source',out/'build');actor=Session(out/'build/protocol-native',out/'native')
            try:
                with self.assertRaisesRegex(ValueError,'reset'):actor.operation('B')
                for line in commands(model,scene).splitlines()[1:]:actor.operation(line)
            finally:self.assertEqual(actor.close(),0)
            driver.stream_check(out/'native',model,scene);bad=copy.deepcopy(scene);bad['steps'][0]['fields']['packet'][24]^=1
            with self.assertRaisesRegex(ValueError,'ingress/reset/replay'):driver.stream_check(out/'native',model,bad)
            p=out/'native/session.json';data=json.loads(p.read_text());data['operations'][1]['pid']+=1;p.write_text(json.dumps(data))
            with self.assertRaisesRegex(ValueError,'PID/timeline'):driver.stream_check(out/'native',model,scene)

    def test_synthetic_raw_pcap_exact_bytes_and_truncation(self):
        case=self.oracle()['cases']['odd-NUL'];raw=bytes.fromhex(case['hex'])
        with tempfile.TemporaryDirectory()as temporary:
            p=Path(temporary)/'synthetic.pcap';header=struct.pack('<IHHIIII',0xa1b2c3d4,2,4,0,0,65535,101);body=struct.pack('<IIII',1,123,len(raw),len(raw))+raw;p.write_bytes(header+body)
            record=records(p)[0];self.assertEqual(record['hex'],case['hex']);self.assertEqual(record['timestamp_ns'],1000123000)
            p.write_bytes(header+body[:-1])
            with self.assertRaises(ValueError):records(p)
            p.write_bytes(header+struct.pack('<IIII',1,0,len(raw)-1,len(raw))+raw[:-1])
            with self.assertRaises(ValueError):records(p)

    def test_fixed_input_symbolic_witness_is_bound_to_actual_ingress(self):
        from protocol_lab.flow import run_scenario
        from protocol_lab.symbolic import crosscheck_trace
        model=driver.load(driver.ROOT/'model/icmp-echo.json');scene=json.loads((driver.ROOT/'scenarios/icmp-echo/odd-NUL.json').read_text());symbolic=crosscheck_trace(model,run_scenario(model,scene).trace)
        self.assertEqual(symbolic['status'],'match');driver.symbolic_trace_check(symbolic,model,scene)
        bad=copy.deepcopy(symbolic);bad['witness']['steps'][0]['fields']['packet'][24]^=1
        with self.assertRaisesRegex(ValueError,'symbolic witness differs'):driver.symbolic_trace_check(bad,model,scene)

    def test_shared_namespace_rejected_before_network_setup(self):
        with self.assertRaises(ValueError):driver.isolation('net:[1]','net:[1]')
        driver.isolation('net:[1]','net:[2]')


if __name__=='__main__':unittest.main(verbosity=2)
