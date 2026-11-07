"""Literal finite single-IR composition gates; no live ingress/proof claim."""
import copy
import hashlib
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from protocol_lab.ir import Machine,Uncovered,load
from protocol_lab.flow import TraceContractMismatch,run_scenario
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,run

ROOT=Path(__file__).resolve().parents[1]


class Ipv4UdpIcmpEndpointTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/ipv4-udp-icmp-endpoint.json')
        self.oracle=json.loads((ROOT/'spec/ipv4-udp-icmp-endpoint-oracle.json').read_text())

    def test_frozen_sources_and_nine_literal_mixed_scenarios(self):
        self.assertEqual(len(self.oracle['cases']),9)
        for name,digest in self.oracle['sources'].items():self.assertEqual(hashlib.sha256((ROOT/'spec/sources'/name).read_bytes()).hexdigest(),digest)
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):
                self.assertEqual(json.loads((ROOT/'scenarios/ipv4-udp-icmp-endpoint'/(name+'.json')).read_text()),scene)
                run_scenario(self.model,scene)

    def test_existing_thirty_rules_and_queue_variables_unchanged(self):
        old=load(ROOT/'model/arp-udp-transmit.json');self.assertEqual(self.model['transitions'][:30],old['transitions'])
        for name,value in old['variables'].items():self.assertEqual(self.model['variables'][name],value)
        self.assertEqual(len(self.model['transitions']),63)
        for p in (ROOT/'scenarios/arp-udp-transmit').glob('*.json'):run_scenario(self.model,json.loads(p.read_text()))

    def test_ten_unsupported_domains_are_atomic_in_all_three_states(self):
        self.assertEqual(len(self.oracle['model_gaps']),10)
        reply=self.oracle['cases']['resolved-mixed']['steps'][0]
        for state in ('EMPTY','PENDING','RESOLVED'):
            for name,raw in self.oracle['model_gaps'].items():
                with self.subTest(state=state,domain=name):
                    machine=Machine(self.model)
                    if state=='PENDING':machine.dispatch('app.send',{'data':[7]},0)
                    if state=='RESOLVED':machine.dispatch(reply['event'],reply['fields'],0)
                    before=machine.snapshot()
                    with self.assertRaises(Uncovered):machine.dispatch('net.frame',{'frame':list(bytes.fromhex(raw))},1)
                    self.assertEqual(machine.snapshot(),before)

    def test_all_nine_exact_fixed_input_z3_replays(self):
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):self.assertEqual(crosscheck_trace(self.model,run_scenario(self.model,scene).trace)['status'],'match')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_generated_c_all_nine_literal_scenarios(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/ipv4-udp-icmp-endpoint.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for name in self.oracle['cases']:
                with self.subTest(case=name):self.assertEqual(run(out/'source',out/'build',ROOT/'scenarios/ipv4-udp-icmp-endpoint'/(name+'.json'),out/name)['status'],'pass')

    def test_ingress_queue_clear_fault_is_caught_by_literal_wire_contract(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='UDPRX-DELIVER-PENDING')
        rule['actions'].append({'set':{'var':'pending_packet','value':{'bytes':[]}}})
        scene=self.oracle['cases']['pending-ingress-preserves-queue']
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,scene)
        machine=Machine(bad)
        for step in scene['steps']:machine.dispatch(step['event'],step['fields'],step['at_ms'])
        self.assertEqual(machine.state,'RESOLVED') # All state invariants still pass.

    def test_wrong_ethernet_reply_mac_fault_is_caught_with_valid_ip_bytes(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='ECHO-ECHO-EMPTY')
        # Replace only the final Ethernet destination expression, preserving IP/ICMP.
        expr=rule['actions'][-1]['emit']['fields']['frame']
        expr['args'][0]['args'][0]['args'][0]={'bytes':[2,0,0,0,0,1]}
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.oracle['cases']['cold-rx-echo'])

    def test_padding_in_echo_checksum_fault_fails_nonzero_padding_literal(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='ECHO-ECHO-EMPTY')
        # Fault: include the entire Ethernet payload tail in the Echo checksum.
        value=rule['actions'][0]['set']['value'];value['args'][1]={'op':'bytes_slice','args':[{'event':'frame'},38,{'op':'sub','args':[{'op':'bytes_len','args':[{'event':'frame'}]},38]}]}
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.oracle['cases']['nonzero-link-padding'])

    def test_payload_start_offset_fault_is_caught_by_literal_octets(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='UDPRX-DELIVER-EMPTY')
        rule['actions'][0]['set']['value']['args'][1]=29 # Correct raw IPv4 payload starts at28.
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.oracle['cases']['cold-rx-echo'])

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_native_padding_and_payload_offset_faults_fail_independent_literals(self):
        import subprocess
        from protocol_lab.codegen.execute import commands
        for fault,scene_name in [('padding','nonzero-link-padding'),('payload-offset','cold-rx-echo')]:
            with self.subTest(fault=fault),tempfile.TemporaryDirectory()as temporary:
                bad=copy.deepcopy(self.model)
                if fault=='padding':
                    rule=next(r for r in bad['transitions']if r['id']=='ECHO-ECHO-EMPTY')
                    rule['actions'][0]['set']['value']['args'][1]={'op':'bytes_slice','args':[{'event':'frame'},38,{'op':'sub','args':[{'op':'bytes_len','args':[{'event':'frame'}]},38]}]}
                else:
                    rule=next(r for r in bad['transitions']if r['id']=='UDPRX-DELIVER-EMPTY')
                    rule['actions'][0]['set']['value']['args'][1]=29
                out=Path(temporary);filename=out/'mutant.json';filename.write_text(json.dumps(bad))
                generate(filename,out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
                scene=self.oracle['cases'][scene_name]
                proc=subprocess.run([str(out/'build/protocol-native')],input=commands(bad,scene),capture_output=True,text=True,timeout=30)
                self.assertEqual(proc.returncode,0);self.assertEqual(proc.stderr,'')
                observed=[json.loads(line)for line in proc.stdout.splitlines()]
                self.assertFalse(any(r['status']=='error'for r in observed))
                actual=[e for r in observed if r['status']=='transition'for e in r['emitted']]
                expected=[e for step in scene['steps']for row in step['expect_trace']for e in row['emitted']]
                self.assertNotEqual(actual,expected)
