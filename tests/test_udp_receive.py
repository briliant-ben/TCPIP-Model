"""Finite raw-packet fixtures/translation checks, never real peer evidence."""
import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from protocol_lab.ir import load,Machine,Uncovered
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate,render
from protocol_lab.codegen.execute import build,run,commands,compare
from protocol_lab.udp_observe import decode_packet

ROOT=Path(__file__).resolve().parents[1]


class UdpReceiveTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/udp-wire-receive.json')
        self.oracle=json.loads((ROOT/'spec/udp-wire-receive-oracle.json').read_text())

    def scene(self,name):return json.loads((ROOT/'scenarios/udp-wire-receive'/(name+'.json')).read_text())

    def test_frozen_packets_match_reference_and_literal_traces(self):
        for name,c in self.oracle['cases'].items():
            with self.subTest(case=name):
                scene=self.scene(name)
                self.assertEqual(bytes(scene['steps'][-1]['fields']['packet']).hex(),c['hex'])
                reference=run_scenario(self.model,scene)
                self.assertEqual(reference.values['payload'],c['data'])
                self.assertEqual(reference.values['disposition'],c['disposition'])

    def test_independent_observer_confirms_valid_packets_and_invalid_checksums(self):
        for name in ('empty','odd-NUL','zero-mapped','absent-allowed','mtu'):
            c=self.oracle['cases'][name];decoded=decode_packet(bytes.fromhex(c['hex']))
            self.assertEqual(decoded['payload_hex'],bytes(c['data']).hex())
            self.assertEqual((decoded['source_port'],decoded['destination_port']),(8080,40000))
        self.assertEqual(decode_packet(bytes.fromhex(self.oracle['cases']['zero-mapped']['hex']))['udp_checksum'],65535)
        for name in ('bad-ip-checksum','bad-udp-checksum','bad-ip-length','udp-short-length','udp-over-length','short-packet'):
            with self.subTest(case=name),self.assertRaises(ValueError):decode_packet(bytes.fromhex(self.oracle['cases'][name]['hex']))

    def test_absent_policy_changes_and_drops_clear_old_delivery(self):
        machine=Machine(self.model)
        packet=lambda name:{'packet':list(bytes.fromhex(self.oracle['cases'][name]['hex']))}
        machine.dispatch('net.packet',packet('odd-NUL'),0)
        self.assertNotEqual(machine.values['payload'],[])
        machine.dispatch('net.packet',packet('bad-udp-checksum'),0)
        self.assertEqual(machine.values['payload'],[]);self.assertEqual(machine.trace[-1]['emitted'],[])
        machine.dispatch('app.require_checksum',{'required':True},0)
        machine.dispatch('net.packet',packet('absent-allowed'),0)
        self.assertEqual(machine.values['disposition'],'drop_absent')
        machine.dispatch('app.require_checksum',{'required':False},0)
        machine.dispatch('net.packet',packet('absent-allowed'),0)
        self.assertEqual(machine.values['disposition'],'deliver')
        self.assertEqual(crosscheck_trace(self.model,machine.trace)['status'],'match')

    def test_out_of_scope_packets_are_model_gaps_not_silent_discards(self):
        for name,raw in self.oracle['model_gaps'].items():
            machine=Machine(self.model);before=machine.snapshot()
            with self.subTest(case=name),self.assertRaises(Uncovered):machine.dispatch('net.packet',{'packet':list(bytes.fromhex(raw))},0)
            self.assertEqual(machine.snapshot(),before)

    def test_every_fixed_input_has_independent_exact_symbolic_replay(self):
        for name in self.oracle['cases']:
            with self.subTest(case=name):
                reference=run_scenario(self.model,self.scene(name))
                self.assertEqual(crosscheck_trace(self.model,reference.trace)['status'],'match')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_generated_c_process_consumes_all_literal_raw_packets(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/udp-wire-receive.json',out/'source')
            self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for name in self.oracle['cases']:
                with self.subTest(case=name):self.assertEqual(run(out/'source',out/'build',ROOT/'scenarios/udp-wire-receive'/(name+'.json'),out/name)['status'],'pass')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_shifted_delivery_fault_fails_exact_content_in_reference_and_c(self):
        bad=copy.deepcopy(self.model)
        rule=next(r for r in bad['transitions']if r['id']=='DELIVER')
        rule['actions'][0]['set']['value']['args'][1]=29
        scene=self.scene('odd-NUL')
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,scene)
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);(out/'fault.c').write_text(render(bad))
            subprocess.run([shutil.which('cc'),'-std=c99',str(out/'fault.c'),'-o',str(out/'fault')],check=True,capture_output=True)
            process=subprocess.run([str(out/'fault')],input=commands(self.model,scene),text=True,capture_output=True,env={'PATH':''},timeout=10)
            self.assertEqual(process.returncode,0)
            self.assertEqual(compare(self.model,scene,[json.loads(r)for r in process.stdout.splitlines()])['status'],'different')

    def test_dropping_ffff_as_absent_would_fail_zero_mapping_oracle(self):
        machine=Machine(self.model);machine.dispatch('app.require_checksum',{'required':True},0)
        case=self.oracle['cases']['zero-mapped']
        machine.dispatch('net.packet',{'packet':list(bytes.fromhex(case['hex']))},0)
        self.assertEqual(machine.values['disposition'],'deliver')
        self.assertEqual(machine.values['payload'],case['data'])
