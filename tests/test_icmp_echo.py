"""Finite literal raw ICMP checks; not real network peer evidence."""
import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from examples.icmp_observe import decode_packet
from protocol_lab.ir import load,Machine,Uncovered
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate,render
from protocol_lab.codegen.execute import build,run,commands,compare

ROOT=Path(__file__).resolve().parents[1]


class IcmpEchoTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/icmp-echo.json');self.oracle=json.loads((ROOT/'spec/icmp-echo-oracle.json').read_text())
    def scene(self,name):return json.loads((ROOT/'scenarios/icmp-echo'/(name+'.json')).read_text())

    def test_thirteen_frozen_bytes_and_literal_reference_contracts(self):
        self.assertEqual(len(self.oracle['cases']),13)
        for name,c in self.oracle['cases'].items():
            with self.subTest(case=name):
                scene=self.scene(name);self.assertEqual(bytes(scene['steps'][0]['fields']['packet']).hex(),c['hex'])
                result=run_scenario(self.model,scene);self.assertEqual(bytes(result.values['reply']).hex(),c['reply_hex']);self.assertEqual(result.values['disposition'],c['disposition'])

    def test_independent_observer_exact_content_odd_zero_and_atomic_fields(self):
        for name,c in self.oracle['cases'].items():
            if c['disposition']!='reply':continue
            request=decode_packet(bytes.fromhex(c['hex']));reply=decode_packet(bytes.fromhex(c['reply_hex']))
            self.assertEqual((request['type'],reply['type']),(8,0));self.assertEqual((reply['source'],reply['destination']),('192.0.2.1','192.0.2.2'))
            self.assertEqual((reply['ip_id'],reply['ttl']),(0,64))
            for key in ('identifier','sequence','data_hex','length'):self.assertEqual(request[key],reply[key])
        self.assertEqual(decode_packet(bytes.fromhex(self.oracle['cases']['reply-checksum-zero']['reply_hex']))['icmp_checksum'],0)
        self.assertEqual(decode_packet(bytes.fromhex(self.oracle['cases']['identifier-sequence-zero']['reply_hex']))['icmp_checksum'],65535)
        self.assertEqual(decode_packet(bytes.fromhex(self.oracle['cases']['request-checksum-zero']['hex']))['icmp_checksum'],0)
        for name in ('bad-ip-length','bad-ip-checksum','bad-icmp-checksum','short'):
            with self.subTest(case=name),self.assertRaises(ValueError):decode_packet(bytes.fromhex(self.oracle['cases'][name]['hex']))

    def test_each_drop_clears_previous_reply_and_all_intermediates(self):
        for name,c in self.oracle['cases'].items():
            if not c['disposition'].startswith('drop'):continue
            machine=Machine(self.model);machine.dispatch('net.packet',{'packet':list(bytes.fromhex(self.oracle['cases']['odd-NUL']['hex']))},0)
            rows=machine.dispatch('net.packet',{'packet':list(bytes.fromhex(c['hex']))},1)
            self.assertEqual(machine.values['disposition'],c['disposition'])
            for key in ('reply','icmp_zero','icmp_wire','ip_zero'):self.assertEqual(machine.values[key],[])
            self.assertEqual(machine.trace[-1]['emitted'],[])

    def test_ten_domain_gaps_are_atomic_even_with_old_reply(self):
        self.assertEqual(len(self.oracle['model_gaps']),10)
        for name,raw in self.oracle['model_gaps'].items():
            machine=Machine(self.model);machine.dispatch('net.packet',{'packet':list(bytes.fromhex(self.oracle['cases']['empty']['hex']))},0);before=machine.snapshot()
            with self.subTest(case=name),self.assertRaises(Uncovered):machine.dispatch('net.packet',{'packet':list(bytes.fromhex(raw))},1)
            self.assertEqual(machine.snapshot(),before)

    def test_all_thirteen_independent_exact_fixed_input_z3_replays(self):
        for name in self.oracle['cases']:
            with self.subTest(case=name):self.assertEqual(crosscheck_trace(self.model,run_scenario(self.model,self.scene(name)).trace)['status'],'match')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_generated_standalone_c_all_thirteen_literal_inputs(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/icmp-echo.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for name in self.oracle['cases']:
                with self.subTest(case=name):self.assertEqual(run(out/'source',out/'build',ROOT/'scenarios/icmp-echo'/(name+'.json'),out/name)['status'],'pass')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_wrong_identifier_valid_checksum_fault_caught_despite_invariants(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='ECHO')
        # Same total length, altered identifier high octet, checksums recomputed by IR.
        rule['actions'][0]['set']['value']['args'][0]['bytes']=[0,0,0,0,0]
        rule['actions'][0]['set']['value']['args'][1]['args'][1]=25
        rule['actions'][0]['set']['value']['args'][1]['args'][2]['args'][1]=25
        scene=self.scene('odd-NUL')
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,scene)
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);(out/'fault.c').write_text(render(bad));subprocess.run([shutil.which('cc'),'-std=c99',str(out/'fault.c'),'-o',str(out/'fault')],check=True,capture_output=True)
            process=subprocess.run([str(out/'fault')],input=commands(self.model,scene),text=True,capture_output=True,env={'PATH':''},timeout=10)
            self.assertEqual(process.returncode,0);rows=[json.loads(r)for r in process.stdout.splitlines()];self.assertEqual(compare(self.model,scene,rows)['status'],'different')
            reply=next(e['fields']['packet']for r in rows for e in r.get('emitted',[]));decoded=decode_packet(bytes(reply));self.assertNotEqual(decoded['identifier'],0x1234)

    def test_faulty_zero_to_ffff_remapping_fails_literal_trace(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='ECHO');checksum=rule['actions'][1]['set']['value']['args'][0]['args'][1]['args'][0]
        rule['actions'][1]['set']['value']['args'][0]['args'][1]['args'][0]={'op':'ite','args':[{'op':'eq','args':[copy.deepcopy(checksum),0]},65535,checksum]}
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.scene('reply-checksum-zero'))
