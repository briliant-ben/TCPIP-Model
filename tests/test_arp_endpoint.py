"""Finite ARP literal and translation checks; no real-peer evidence from fixtures."""
import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from examples.arp_observe import decode_frame
from protocol_lab.ir import load,Machine,Uncovered
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate,render
from protocol_lab.codegen.execute import build,run,commands,compare
ROOT=Path(__file__).resolve().parents[1]


class ArpEndpointTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/arp-endpoint.json')
        self.oracle=json.loads((ROOT/'spec/arp-endpoint-oracle.json').read_text())

    def scene(self,name):return self.oracle['cases'][name]

    def test_all_independent_literal_contracts(self):
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):run_scenario(self.model,scene)

    def test_independent_frame_layout_and_endian_faults(self):
        request=decode_frame(bytes.fromhex(self.oracle['request_hex']))
        self.assertEqual((request['destination'],request['sender_ip'],request['target_ip'],request['opcode']),('ffffffffffff','192.0.2.1','192.0.2.2',1))
        reference=run_scenario(self.model,self.scene('incoming-request'))
        reply=decode_frame(bytes(reference.trace[0]['emitted'][0]['fields']['frame']))
        self.assertEqual((reply['destination'],reply['sender_mac'],reply['target_mac'],reply['opcode']),('020000000002','020000000001','020000000002',2))
        self.assertEqual(len(bytes.fromhex(reply['padding_hex'])),18)
        raw=bytearray.fromhex(self.oracle['request_hex']);raw[20:22]=b'\x01\0'
        with self.assertRaises(ValueError):decode_frame(raw)

    def test_timers_retry_coalescing_and_same_deadline_order(self):
        retry=run_scenario(self.model,self.scene('retry-failure'))
        times=[r['time_ms']for r in retry.trace if any(e['message']=='ethernet.tx'for e in r['emitted'])]
        self.assertEqual(times,[0,1000]);self.assertEqual(retry.state,'EMPTY')
        expire=run_scenario(self.model,self.scene('expire-before-query'))
        self.assertEqual([r['transition']for r in expire.trace[-2:]],['CACHE-EXPIRE','QUERY-START'])
        self.assertEqual([r['time_ms']for r in expire.trace[-2:]],[60000,60000])

    def test_wrong_merge_order_and_missing_refresh_are_caught(self):
        for name,remove in [('merge-before-target','all'),('refresh-extends','arm')]:
            bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='NONLOCAL-RESOLVED')
            rule['actions']=[]if remove=='all'else[a for a in rule['actions']if 'arm'not in a]
            with self.subTest(case=name),self.assertRaises(TraceContractMismatch):run_scenario(bad,self.scene(name))

    def test_model_gaps_remain_atomic_in_every_state(self):
        for state in ('EMPTY','PENDING','RESOLVED'):
            for name,case in self.oracle['model_gaps'].items():
                machine=Machine(self.model)
                if state=='PENDING':machine.dispatch('app.resolve',{'ip':[192,0,2,2]},0)
                elif state=='RESOLVED':machine.dispatch('net.frame',{'frame':list(bytes.fromhex(self.oracle['peer_reply_hex']))},0)
                before=machine.snapshot()
                with self.subTest(state=state,case=name),self.assertRaises(Uncovered):machine.dispatch(case['event'],case['fields'],0)
                self.assertEqual(machine.snapshot(),before)

    def test_independent_fixed_input_z3_replays_all_contracts(self):
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):self.assertEqual(crosscheck_trace(self.model,run_scenario(self.model,scene).trace)['status'],'match')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_native_all_wire_cache_and_timer_contracts(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/arp-endpoint.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for name in self.oracle['cases']:
                with self.subTest(case=name):self.assertEqual(run(out/'source',out/'build',ROOT/'scenarios/arp-endpoint'/(name+'.json'),out/name)['status'],'pass')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_wrong_reply_mac_keeps_invariants_but_fails_exact_native_oracle(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='LOCAL-REQUEST-EMPTY')
        emit=next(a['emit']for a in rule['actions']if 'emit'in a)
        def wrong(node):
            if node=={'var':'peer_mac'}:return {'bytes':[2,0,0,0,0,1]}
            if isinstance(node,dict):return {k:wrong(v)for k,v in node.items()}
            if isinstance(node,list):return [wrong(v)for v in node]
            return node
        emit['fields']['frame']=wrong(emit['fields']['frame']);scene=self.scene('incoming-request')
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,scene)
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);(out/'fault.c').write_text(render(bad))
            subprocess.run([shutil.which('cc'),'-std=c99',str(out/'fault.c'),'-o',str(out/'fault')],check=True,capture_output=True)
            p=subprocess.run([str(out/'fault')],input=commands(self.model,scene),capture_output=True,text=True,env={'PATH':''},timeout=10)
            self.assertEqual(p.returncode,0)
            self.assertEqual(compare(self.model,scene,[json.loads(row)for row in p.stdout.splitlines()])['status'],'different')
