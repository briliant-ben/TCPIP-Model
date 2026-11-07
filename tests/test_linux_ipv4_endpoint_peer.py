"""Real generated C with synthetic TAP/peer records, never Linux evidence."""
import copy
import importlib.util
import json
from pathlib import Path
import shutil
import socket
import struct
import sys
import tempfile
import time
import unittest
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[1];PORT=ROOT/'ports/linux-ipv4-endpoint-peer'
def module(name,path):
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
capture=module('endpoint_capture',PORT/'capture.py');oracle=module('endpoint_oracle',PORT/'oracle.py')
with patch.dict(sys.modules,{'capture':capture,'oracle':oracle}):driver=module('endpoint_driver',PORT/'run.py')
from ports.native_session import Session
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,commands,write


def packet(payload,protocol):
    # Offline independent struct fixtures. No IR/codegen encoder and no native
    # output bytes are consumed to construct the inputs or oracle.
    src=socket.inet_aton('192.0.2.2');dst=socket.inet_aton('192.0.2.1')
    if protocol==17:
        body=struct.pack('!HHHH',8080,40000,len(payload)+8,0)+payload;check=oracle.checksum(src+dst+struct.pack('!BBH',0,17,len(body))+body);body=body[:6]+struct.pack('!H',check or 65535)+body[8:]
    else:
        body=struct.pack('!BBHHH',8,0,0,77,1)+payload;body=body[:2]+struct.pack('!H',oracle.checksum(body))+body[4:]
    header=struct.pack('!BBHHHBBH4s4s',69,0,20+len(body),1234,16384,64,protocol,0,src,dst);header=header[:10]+struct.pack('!H',oracle.checksum(header))+header[12:]
    return bytes.fromhex('0200000000010200000000020800')+header+body


def fixture(root):
    cfg=driver.config();model=driver.load(ROOT/cfg['model']);generate(ROOT/cfg['model'],root/'generated');build(root/'generated',root/'build');out=root/'network';out.mkdir();actor=Session(root/'build/protocol-native',out/'native');origin=time.monotonic_ns();events=[];links=[];services=[];received=[];trials=[]
    scene=dict(scenario_version='0.2',id='synthetic-not-Linux-peer',initial={},steps=[])
    def record(raw,direction):
        name='link-'+str(len(links))+'.raw';(out/name).write_bytes(raw);links.append(dict(file=name,direction=direction,monotonic_ns=time.monotonic_ns()))
    def op(step):
        sample=time.monotonic_ns();step['at_ms']=(sample-origin)//1000000;rows=actor.operation(commands(model,dict(initial={},steps=[step])).splitlines()[1]);scene['steps'].append(step);events.append(dict(step=len(scene['steps'])-1,pid=actor.process.pid,sampled_monotonic_ns=sample,reply_monotonic_ns=time.monotonic_ns()));assert rows[-1]['status']=='ok',rows[-1]
        for row in rows:
            for e in row.get('emitted',[]):
                if e['message']=='ethernet.tx':record(bytes(e['fields']['frame']),'subject_tx')
                else:services.append(e)
    def ingress(raw):record(raw,'peer_tx');op(dict(event='net.frame',fields=dict(frame=list(raw))))
    try:
        for i,item in enumerate(cfg['payloads']):
            op(dict(event='app.send',fields=dict(data=list(bytes.fromhex(item['hex'])))))
            if i==0:ingress(bytes.fromhex(json.loads((ROOT/'spec/arp-udp-transmit-oracle.json').read_text())['peer_reply_hex']))
            stamp=time.monotonic_ns();received.append(dict(id=item['id'],hex=item['hex'],source_ip=cfg['subject']['ip'],source_port=cfg['subject']['port'],monotonic_ns=stamp,echo_bytes=len(bytes.fromhex(item['hex'])),echo_monotonic_ns=stamp));ingress(packet(bytes.fromhex(item['hex']),17))
        for i,item in enumerate(cfg['echoes']):
            stamp=time.monotonic_ns();trials.append(dict(case=item['id'],command=driver.ping_command(item),pid=100+i,started_monotonic_ns=stamp));data=(bytes.fromhex(cfg['pattern'])*300)[:item['data_bytes']];ingress(packet(data,1));(out/(item['id']+'.stdout')).write_text('1 packets transmitted, 1 received, 0% packet loss\n');(out/(item['id']+'.stderr')).write_text('')
    finally:code=actor.close()
    last=time.monotonic_ns();stop=last+100000000
    ns=dict(parent_netns='net:[1]',execution_netns='net:[2]',actual_parent_netns='net:[1]',host_network_mutations=False,packet_bytes_rewritten=False,capture_command=['tcpdump','--immediate-mode','arp or udp or icmp'],capture_packet_limit=None,peer_bound_monotonic_ns=0,capture_ready_monotonic_ns=0,clock_origin_monotonic_ns=origin,last_selected_monotonic_ns=last,capture_stop_request_monotonic_ns=stop,capture_exit_monotonic_ns=stop+1,native_closed_monotonic_ns=stop+20,peer_closed_monotonic_ns=stop+21,resources_closed_monotonic_ns=stop+22,quiet_ms=100,native_returncode=code,capture_returncode=0,native_pid=actor.process.pid)
    for i,trial in enumerate(trials):trial.update(stop_request_monotonic_ns=stop+2+2*i,returncode=0,exit_monotonic_ns=stop+3+2*i)
    scene['expect']=dict(state='RESOLVED',variables=dict(peer_mac=list(bytes.fromhex(cfg['peer']['mac'])),pending_packet=[],rxudp_payload=list(bytes.fromhex(cfg['payloads'][-1]['hex'])),rxudp_disposition='deliver',echo_disposition='reply'),timers=dict(cache=scene['steps'][1]['at_ms']+60000))
    for name,data in [('namespace',ns),('scenario',scene),('events',events),('links',links),('services',services),('received',received),('unselected',[]),('trials',trials)]:write(out/(name+'.json'),data)
    (out/'capture.log').write_text('16 packets captured\n16 packets received by filter\n0 packets dropped by kernel\n');raw=struct.pack('<IHHIIII',0xa1b2c3d4,2,4,0,0,65535,1)
    for i,link in enumerate(links):
        frame=(out/link['file']).read_bytes();raw+=struct.pack('<IIII',1,i*1000,len(frame),len(frame))+frame
    (out/'capture.pcap').write_bytes(raw);return out


class IntegratedPeerTests(unittest.TestCase):
    def test_namespace_must_differ_before_link_configuration(self):
        with self.assertRaises(ValueError):driver.isolation('net:[1]','net:[1]')
        driver.isolation('net:[1]','net:[2]')

    def test_independent_decoders_retain_unpadded_frames_and_reject_partial_padding(self):
        for protocol in (1,17):
            raw=packet(b'\0\xff\0',protocol);row=capture.decode_frame(raw);self.assertEqual(row['kind'],'icmp'if protocol==1 else'udp');self.assertEqual(row['padding_hex'],'');self.assertEqual(capture.decode_frame(raw+b'\0'*(60-len(raw)))['kind'],row['kind'])
            with self.assertRaises(ValueError):capture.decode_frame(raw+b'\0')
            bad=bytearray(raw);bad[-1]^=1
            with self.assertRaises(ValueError):capture.decode_frame(bad)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_one_native_pid_integrated_udp_echo_and_icmp_contract(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=fixture(Path(temporary));r=driver.assess_case(out);self.assertEqual(r['udp_roundtrips'],4);self.assertEqual(r['icmp_roundtrips'],3);self.assertEqual(driver.assess_case(out,False),r)
            rows=capture.records(out/'capture.pcap');self.assertEqual(len(rows),16);self.assertEqual(len(bytes.fromhex(rows[5]['hex'])),42)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_capture_peer_lifecycle_and_service_faults_are_rejected(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=fixture(Path(temporary));driver.assess_case(out)
            for filename,mutate in [('received.json',lambda x:x[1].update(hex='00')),('trials.json',lambda x:x[0].update(stop_request_monotonic_ns=0)),('namespace.json',lambda x:x.update(capture_stop_request_monotonic_ns=x['last_selected_monotonic_ns']+99999999)),('services.json',lambda x:x[-1]['fields'].update(data=[]))]:
                p=out/filename;original=p.read_text();bad=json.loads(original);mutate(bad);write(p,bad)
                with self.assertRaises(ValueError,msg=filename):driver.assess_case(out)
                p.write_text(original)
            (out/'capture.log').write_text('16 packets captured\n16 packets received by filter\n1 packets dropped by kernel\n')
            with self.assertRaisesRegex(ValueError,'drops'):driver.assess_case(out)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_native_reset_ingress_pid_and_exact_echo_corruption_rejected(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=fixture(Path(temporary));driver.assess_case(out);model=driver.load(ROOT/driver.config()['model']);scene=json.loads((out/'scenario.json').read_text());bad=copy.deepcopy(scene);bad['steps'][2]['fields']['frame'][-1]^=1
            with self.assertRaisesRegex(ValueError,'ingress/reset'):driver.stream_check(out/'native',model,bad)
            p=out/'native/session.json';original=p.read_text();bad=json.loads(original);bad['operations'][1]['pid']+=1;write(p,bad)
            with self.assertRaisesRegex(ValueError,'timeline'):driver.assess_case(out)
            p.write_text(original);p=out/'capture.pcap';raw=bytearray(p.read_bytes());raw[-1]^=1;p.write_bytes(raw)
            with self.assertRaises(ValueError):driver.assess_case(out)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_continuous_trace_fixed_input_z3_and_tamper(self):
        from protocol_lab.flow import run_scenario
        from protocol_lab.symbolic import crosscheck_trace
        with tempfile.TemporaryDirectory()as temporary:
            root=Path(temporary);out=fixture(root);model=driver.load(ROOT/driver.config()['model']);scene=json.loads((out/'scenario.json').read_text());r=crosscheck_trace(model,run_scenario(model,scene).trace,root/'symbolic');self.assertEqual(r['status'],'match');driver.symbolic_trace_check(r,model,scene);r['witness']['steps'][-1]['fields']['frame'][0]^=1
            with self.assertRaisesRegex(ValueError,'witness differs'):driver.symbolic_trace_check(r,model,scene)

if __name__=='__main__':unittest.main(verbosity=2)
