"""PTY/capture/negative fixtures, never real TAP/Linux evidence."""
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
from ports.native_session import Session
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,commands,compare


class LiveArpAdapterTests(unittest.TestCase):
    def test_shared_namespace_rejected_before_setup(self):
        with self.assertRaises(ValueError):driver.isolation('net:[1]','net:[1]')
        driver.isolation('net:[1]','net:[2]')

    def test_independent_ethernet_pcap_and_truncation(self):
        oracle=json.loads((driver.ROOT/'spec/arp-endpoint-oracle.json').read_text());raw=bytes.fromhex(oracle['request_hex'])
        with tempfile.TemporaryDirectory()as temporary:
            p=Path(temporary)/'unit.pcap';body=struct.pack('<IHHIIII',0xa1b2c3d4,2,4,0,0,65535,1)+struct.pack('<IIII',1,123, len(raw),len(raw))+raw;p.write_bytes(body)
            result=records(p);self.assertEqual(result[0]['decoded']['opcode'],1);self.assertEqual(result[0]['hex'],raw.hex());self.assertEqual(result[0]['timestamp_ns'],1000123000)
            p.write_bytes(body[:-1])
            with self.assertRaises(ValueError):records(p)
            damaged=bytearray(body);damaged[24+16+21]=3;p.write_bytes(damaged)
            with self.assertRaises(ValueError):records(p)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_one_pid_live_cache_timers_all_thirteen_contracts(self):
        model=driver.load(driver.ROOT/'model/arp-endpoint.json');oracle=json.loads((driver.ROOT/'spec/arp-endpoint-oracle.json').read_text())
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(driver.ROOT/'model/arp-endpoint.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for name,scene in oracle['cases'].items():
                folder=out/name;session=Session(out/'build/protocol-native',folder)
                try:
                    with patch('protocol_lab.ir.Machine.dispatch',side_effect=AssertionError('Reference used for live subject')):
                        pid=session.process.pid
                        for line in commands(model,scene).splitlines()[1:]:
                            self.assertEqual(session.operation(line)[-1]['status'],'ok');self.assertEqual(session.process.pid,pid)
                    self.assertIsNone(session.process.poll())
                finally:self.assertEqual(session.close(),0)
                rows,meta=driver.stream_check(folder,model,scene);self.assertEqual(compare(model,scene,rows)['status'],'match');self.assertEqual(meta['process_starts'],1)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_reset_and_same_length_ingress_tamper_fail(self):
        model=driver.load(driver.ROOT/'model/arp-endpoint.json');scene=json.loads((driver.ROOT/'scenarios/arp-endpoint/resolve-reply-hit.json').read_text())
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(driver.ROOT/'model/arp-endpoint.json',out/'source');build(out/'source',out/'build');session=Session(out/'build/protocol-native',out/'live')
            try:
                with self.assertRaisesRegex(ValueError,'no reset'):session.operation('B')
                for line in commands(model,scene).splitlines()[1:]:session.operation(line)
            finally:self.assertEqual(session.close(),0)
            driver.stream_check(out/'live',model,scene)
            bad=copy.deepcopy(scene);bad['steps'][1]['fields']['frame'][27]^=1
            with self.assertRaisesRegex(ValueError,'ingress/reset/replay'):driver.stream_check(out/'live',model,bad)
            p=out/'live/session.json';meta=json.loads(p.read_text());meta['operations'][1]['pid']+=1;p.write_text(json.dumps(meta))
            with self.assertRaisesRegex(ValueError,'timeline'):driver.stream_check(out/'live',model,scene)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_native_model_gap_preserves_committed_state_and_is_not_a_new_process(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(driver.ROOT/'model/arp-endpoint.json',out/'source');build(out/'source',out/'build');session=Session(out/'build/protocol-native',out/'live')
            try:
                session.operation('D 0 app.resolve b:c0000202');before=session.snapshot;pid=session.process.pid
                rows=session.operation('D 0 app.resolve b:c0000203')
                self.assertEqual(rows[-1]['status'],'error');self.assertEqual(rows[-1]['failure'],'uncovered_event');self.assertEqual(session.snapshot,before);self.assertEqual(session.process.pid,pid)
            finally:self.assertEqual(session.close(),1)


if __name__=='__main__':unittest.main(verbosity=2)
