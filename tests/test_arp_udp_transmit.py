"""Finite single-IR cross-layer queue/wire checks, not live composed-peer evidence."""
import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from examples.ethernet_udp_observe import decode_frame
from protocol_lab.ir import load,Machine,Uncovered
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate,render
from protocol_lab.codegen.execute import build,run,commands,compare

ROOT=Path(__file__).resolve().parents[1]


class ArpUdpTransmitTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/arp-udp-transmit.json');self.oracle=json.loads((ROOT/'spec/arp-udp-transmit-oracle.json').read_text())
    def scenes(self):
        return list((ROOT/'scenarios/arp-udp-transmit').glob('*.json'))+list((ROOT/'scenarios/arp-endpoint').glob('*.json'))

    def test_seventeen_frozen_full_trace_queue_timer_scenarios(self):
        self.assertEqual(len(self.oracle['cases']),17);self.assertEqual(len(self.model['transitions']),30)
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):
                self.assertEqual(json.loads((ROOT/'scenarios/arp-udp-transmit'/(name+'.json')).read_text()),scene);run_scenario(self.model,scene)

    def test_original_thirteen_arp_scenarios_replay_unchanged(self):
        paths=list((ROOT/'scenarios/arp-endpoint').glob('*.json'));self.assertEqual(len(paths),13)
        for p in paths:
            with self.subTest(case=p.name):run_scenario(self.model,json.loads(p.read_text()))

    def test_component_encoding_and_arp_prefixes_have_not_forked(self):
        udp=load(ROOT/'model/udp-wire-transmit.json');arp=load(ROOT/'model/arp-endpoint.json');encode=next(t for t in udp['transitions']if t['id']=='TRANSMIT')
        for state in arp['states']:
            rule=next(t for t in self.model['transitions']if t['id']=='UDP-SEND-'+state)
            self.assertEqual(rule['guard'],encode['guard']);self.assertEqual(rule['actions'][:12],encode['actions'][:-1])
        for name in ('LOCAL-REQUEST-PENDING','LOCAL-REPLY-PENDING','QUERY-FAIL'):
            old=next(t for t in arp['transitions']if t['id']==name)
            for suffix in ('QUEUED','UNQUEUED'):
                rule=next(t for t in self.model['transitions']if t['id']==name+'-'+suffix)
                self.assertEqual(rule['actions'][:len(old['actions'])],old['actions'])
        for name,value in udp['variables'].items():self.assertEqual(self.model['variables'][name],value)

    def test_independent_full_ethernet_ip_udp_observer_and_padding_fault(self):
        sizes=set();padding=set();checksums=set()
        for scene in self.oracle['cases'].values():
            for step in scene['steps']:
                for row in step['expect_trace']:
                    for emission in row['emitted']:
                        if emission['message']!='ethernet.tx':continue
                        frame=bytes(emission['fields']['frame'])
                        if frame[12:14]!=b'\x08\0':continue
                        parsed=decode_frame(frame);sizes.add(len(frame));padding.add(parsed['padding_bytes']);checksums.add(parsed['ip_udp']['udp_checksum'])
                        self.assertEqual(parsed['source'],'020000000001');self.assertIn(parsed['destination'],('020000000002','020000000003'))
                        if parsed['padding_bytes']:
                            bad=frame[:-1]+b'\1'
                            with self.assertRaisesRegex(ValueError,'padding'):decode_frame(bad)
        self.assertTrue({60,1514}<=sizes);self.assertTrue({0,1,18}<=padding);self.assertTrue({0,65535}<=checksums)

    def test_all_thirty_exact_fixed_input_z3_replays(self):
        for p in self.scenes():
            with self.subTest(case=p.name):self.assertEqual(crosscheck_trace(self.model,run_scenario(self.model,json.loads(p.read_text())).trace)['status'],'match')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_generated_c_all_thirty_scenarios(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/arp-udp-transmit.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for i,p in enumerate(self.scenes()):
                with self.subTest(case=p.name):self.assertEqual(run(out/'source',out/'build',p,out/str(i))['status'],'pass')

    def test_latest_queue_lost_fault_passes_size_contract_but_fails_wire_oracle(self):
        bad=copy.deepcopy(self.model);rule=next(t for t in bad['transitions']if t['id']=='UDP-SEND-PENDING');rule['actions'][12]['set']['value']={'bytes':[]}
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.oracle['cases']['latest-replaces'])
        # With literal contracts removed, the incorrect model still commits all events/invariants.
        machine=Machine(bad)
        for step in self.oracle['cases']['latest-replaces']['steps']:machine.dispatch(step['event'],step['fields'],step['at_ms'])
        self.assertEqual(machine.state,'RESOLVED');self.assertEqual(machine.values['pending_packet'],[])

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_wrong_mac_native_frame_has_valid_ip_checksum_but_fails_exact_trace(self):
        bad=copy.deepcopy(self.model);rule=next(t for t in bad['transitions']if t['id']=='LOCAL-REPLY-PENDING-QUEUED')
        def replace(value):
            if value=={'var':'peer_mac'}:return {'bytes':[2,0,0,0,0,2]}
            if isinstance(value,dict):return {k:replace(v)for k,v in value.items()}
            if isinstance(value,list):return [replace(v)for v in value]
            return value
        rule['actions'][-2]=replace(rule['actions'][-2]);scene=self.oracle['cases']['nonlocal-does-not-flush']
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,scene)
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);(out/'fault.c').write_text(render(bad));subprocess.run([shutil.which('cc'),'-std=c99',str(out/'fault.c'),'-o',str(out/'fault')],check=True,capture_output=True)
            process=subprocess.run([str(out/'fault')],input=commands(self.model,scene),text=True,capture_output=True,env={'PATH':''},timeout=10);self.assertEqual(process.returncode,0)
            rows=[json.loads(r)for r in process.stdout.splitlines()];self.assertEqual(compare(self.model,scene,rows)['status'],'different')
            frames=[bytes(e['fields']['frame'])for row in rows for e in row.get('emitted',[])if e['message']=='ethernet.tx'];decoded=decode_frame(frames[-1]);self.assertEqual(decoded['destination'],'020000000002');self.assertEqual(rows[-1]['snapshot']['variables']['peer_mac'],[2,0,0,0,0,3])

    def test_over_mtu_is_atomic_gap_in_each_arp_state(self):
        for state in ('EMPTY','PENDING','RESOLVED'):
            machine=Machine(self.model)
            if state=='PENDING':machine.dispatch('app.send',{'data':[1]},0)
            if state=='RESOLVED':machine.dispatch('net.frame',{'frame':list(bytes.fromhex(self.oracle['peer_reply_hex']))},0)
            before=machine.snapshot()
            with self.subTest(state=state),self.assertRaises(Uncovered):machine.dispatch('app.send',{'data':self.oracle['over_mtu_data']},500)
            self.assertEqual(machine.snapshot(),before)
