"""Actual C/PT Y and synthetic capture faults; no Linux peer claim from fixtures."""
import copy
import importlib.util
import json
from pathlib import Path
import shutil
import struct
import sys
import tempfile
import time
import unittest
from unittest.mock import patch

ROOT=Path(__file__).resolve().parents[1];PORT=ROOT/'ports/linux-arp-udp-peer'
def module(name,path):
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
# Driver imports local capture by plain name when run as an executable. Isolate it
# while importing for discovery beside other adapters.
_capture=module('composed_capture',PORT/'capture.py')
with patch.dict(sys.modules,{'capture':_capture}):driver=module('composed_driver',PORT/'run.py')
from ports.native_session import Session
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,commands,write


def fixture(root):
    cfg=driver.config();model=driver.load(ROOT/cfg['model']);generate(ROOT/cfg['model'],root/'generated');build(root/'generated',root/'build');out=root/'network';out.mkdir();actor=Session(root/'build/protocol-native',out/'native');origin=time.monotonic_ns();events=[];links=[];services=[];received=[]
    scene=dict(scenario_version='0.2',id='synthetic-not-network-evidence',initial={},steps=[])
    def record(raw,direction):
        name='link-'+str(len(links))+'.raw';(out/name).write_bytes(raw);links.append(dict(file=name,direction=direction,monotonic_ns=time.monotonic_ns()))
    def op(step):
        sample=time.monotonic_ns();step['at_ms']=(sample-origin)//1000000;rows=actor.operation(commands(model,dict(initial={},steps=[step])).splitlines()[1]);scene['steps'].append(step);events.append(dict(step=len(scene['steps'])-1,pid=actor.process.pid,sampled_monotonic_ns=sample,reply_monotonic_ns=time.monotonic_ns()))
        for row in rows:
            for e in row.get('emitted',[]):
                if e['message']=='ethernet.tx':record(bytes(e['fields']['frame']),'subject_tx')
                else:services.append(e)
    try:
        for i,item in enumerate(cfg['payloads']):
            op(dict(event='app.send',fields=dict(data=list(bytes.fromhex(item['hex'])))))
            if i==0:
                raw=bytes.fromhex(json.loads((ROOT/'spec/arp-udp-transmit-oracle.json').read_text())['peer_reply_hex']);record(raw,'peer_tx');op(dict(event='net.frame',fields=dict(frame=list(raw))))
            received.append(dict(id=item['id'],hex=item['hex'],source_ip=cfg['subject']['ip'],source_port=cfg['subject']['port'],monotonic_ns=time.monotonic_ns()))
    finally:code=actor.close()
    last=time.monotonic_ns();stop=last+100000000
    ns=dict(parent_netns='net:[1]',execution_netns='net:[2]',actual_parent_netns='net:[1]',host_network_mutations=False,packet_bytes_rewritten=False,capture_command=['tcpdump','--immediate-mode','arp or udp'],capture_packet_limit=None,peer_bound_monotonic_ns=0,capture_ready_monotonic_ns=0,clock_origin_monotonic_ns=origin,last_receive_monotonic_ns=last,capture_stop_request_monotonic_ns=stop,capture_exit_monotonic_ns=stop+1,native_closed_monotonic_ns=stop+2,peer_closed_monotonic_ns=stop+3,resources_closed_monotonic_ns=stop+4,quiet_ms=100,native_returncode=code,capture_returncode=0,native_pid=actor.process.pid)
    scene['expect']=dict(state='RESOLVED',variables=dict(peer_mac=list(bytes.fromhex(cfg['peer']['mac'])),pending_packet=[]),timers=dict(cache=scene['steps'][1]['at_ms']+60000))
    for name,data in [('namespace',ns),('scenario',scene),('events',events),('links',links),('services',services),('received',received),('unselected',[])]:write(out/(name+'.json'),data)
    (out/'capture.log').write_text('6 packets captured\n6 packets received by filter\n0 packets dropped by kernel\n')
    raw=struct.pack('<IHHIIII',0xa1b2c3d4,2,4,0,0,65535,1)
    for i,link in enumerate(links):
        frame=(out/link['file']).read_bytes();raw+=struct.pack('<IIII',1,i*1000,len(frame),len(frame))+frame
    (out/'capture.pcap').write_bytes(raw);return out


class ComposedPeerTests(unittest.TestCase):
    def test_namespace_precedes_network_operations(self):
        with self.assertRaises(ValueError):driver.isolation('net:[1]','net:[1]')
        driver.isolation('net:[1]','net:[2]')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_single_live_c_and_independent_mixed_capture_contract(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=fixture(Path(temporary));result=driver.assess_case(out);self.assertEqual(result['udp_deliveries'],4);self.assertEqual(result['packets'],6);self.assertEqual(driver.assess_case(out,False),result)
            with patch('protocol_lab.ir.Machine.dispatch',side_effect=AssertionError('Reference must not drive live subject')):
                model=driver.load(ROOT/driver.config()['model']);rows,meta=driver.stream_check(out/'native',model,json.loads((out/'scenario.json').read_text()));self.assertEqual(meta['process_starts'],1)
            self.assertEqual(len(_capture.records(out/'capture.pcap')),6)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_peer_payload_capture_and_quiet_faults_rejected(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=fixture(Path(temporary));driver.assess_case(out)
            p=out/'received.json';original=p.read_text();bad=json.loads(original);bad[2]['hex']='00414200ff';write(p,bad)
            with self.assertRaisesRegex(ValueError,'delivery'):driver.assess_case(out)
            p.write_text(original);p=out/'namespace.json';original=p.read_text();bad=json.loads(original);bad['capture_stop_request_monotonic_ns']=bad['last_receive_monotonic_ns']+99999999;write(p,bad)
            with self.assertRaisesRegex(ValueError,'Quiet'):driver.assess_case(out)
            p.write_text(original);p=out/'capture.log';p.write_text('6 packets captured\n6 packets received by filter\n1 packets dropped by kernel\n')
            with self.assertRaisesRegex(ValueError,'drops'):driver.assess_case(out)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_reset_pid_ingress_and_packet_corruption_rejected(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=fixture(Path(temporary));driver.assess_case(out);model=driver.load(ROOT/driver.config()['model']);scene=json.loads((out/'scenario.json').read_text());bad=copy.deepcopy(scene);bad['steps'][1]['fields']['frame'][27]^=1
            with self.assertRaisesRegex(ValueError,'ingress/reset'):driver.stream_check(out/'native',model,bad)
            p=out/'native/session.json';original=p.read_text();bad=json.loads(original);bad['operations'][1]['pid']+=1;write(p,bad)
            with self.assertRaisesRegex(ValueError,'timeline'):driver.assess_case(out)
            p.write_text(original);p=out/'capture.pcap';raw=bytearray(p.read_bytes());raw[-1]^=1;p.write_bytes(raw)
            with self.assertRaises(ValueError):driver.assess_case(out)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_sequence_fixed_input_z3_and_witness_tamper(self):
        from protocol_lab.flow import run_scenario
        from protocol_lab.symbolic import crosscheck_trace
        with tempfile.TemporaryDirectory()as temporary:
            root=Path(temporary);out=fixture(root);model=driver.load(ROOT/driver.config()['model']);scene=json.loads((out/'scenario.json').read_text());result=crosscheck_trace(model,run_scenario(model,scene).trace,root/'symbolic');self.assertEqual(result['status'],'match');driver.symbolic_trace_check(result,model,scene)
            result['witness']['steps'][0]['fields']['data'][0]^=1
            with self.assertRaisesRegex(ValueError,'witness differs'):driver.symbolic_trace_check(result,model,scene)

if __name__=='__main__':unittest.main(verbosity=2)
