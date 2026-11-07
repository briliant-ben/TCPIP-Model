"""TAP profile retains raw interface extents; finite local tests, no live evidence."""
import copy
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from protocol_lab.ir import load,Machine,Uncovered
from protocol_lab.flow import run_scenario
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,run,commands

ROOT=Path(__file__).resolve().parents[1]
N={'op':'bytes_len','args':[{'event':'frame'}]}


class Ipv4UdpIcmpTapTests(unittest.TestCase):
    def setUp(self):
        self.base=load(ROOT/'model/ipv4-udp-icmp-endpoint.json');self.model=load(ROOT/'model/ipv4-udp-icmp-tap.json')
        self.oracle=json.loads((ROOT/'spec/ipv4-udp-icmp-tap-oracle.json').read_text())

    def test_pinned_source_and_eleven_independent_literal_scenarios(self):
        self.assertEqual(len(self.oracle['cases']),11)
        for name,digest in self.oracle['sources'].items():self.assertEqual(hashlib.sha256((ROOT/'spec/sources'/name).read_bytes()).hexdigest(),digest)
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):
                self.assertEqual(json.loads((ROOT/'scenarios/ipv4-udp-icmp-tap'/(name+'.json')).read_text()),scene);run_scenario(self.model,scene)

    def test_exact_guard_envelope_delta_and_all_other_component_semantics_unchanged(self):
        self.assertEqual(len(self.model['transitions']),63)
        for key in ('variables','states','initial_state','events','messages','timers','invariants','semantics','ir_version'):self.assertEqual(self.model[key],self.base[key])
        changed=[]
        for old,new in zip(self.base['transitions'],self.model['transitions'],strict=True):
            before=copy.deepcopy(new)
            if old==new:continue
            changed.append(new['id']);self.assertEqual(new['event'],'net.frame');counts=[0,0]
            def undo(node):
                if isinstance(node,list):return [undo(x)for x in node]
                if not isinstance(node,dict):return node
                if node=={'op':'ge','args':[N,42]}:counts[0]+=1;return {'op':'ge','args':[copy.deepcopy(N),60]}
                if node.get('op')=='or':
                    a,b=node['args']
                    if isinstance(b,dict)and b.get('op')=='eq'and b['args'][0]==N and isinstance(b['args'][1],dict)and b['args'][1].get('op')=='ite':
                        self.assertEqual(a,{'op':'eq','args':[N,b['args'][1]['args'][1]]});counts[1]+=1;return b
                return {k:undo(v)for k,v in node.items()}
            before['guard']=undo(before['guard']);self.assertEqual(before['requirements'][-2:],['TAP-INTERFACE','TAP-EXTENT']);before['requirements']=before['requirements'][:-2]
            self.assertEqual(before,old);self.assertEqual(counts,[1,0 if '-FRAME-IP-LENGTH-'in old['id']else 1])
        self.assertEqual(len(changed),30)

    def test_unpadded_inputs_remain_gaps_in_original_canonical_model(self):
        self.assertEqual(len(self.oracle['canonical_model_gaps']),4)
        for raw in self.oracle['canonical_model_gaps']:
            fields={'frame':list(bytes.fromhex(raw))};machine=Machine(self.base);before=machine.snapshot()
            with self.assertRaises(Uncovered):machine.dispatch('net.frame',fields,0)
            self.assertEqual(machine.snapshot(),before);Machine(self.model).dispatch('net.frame',fields,0)
        old=json.loads((ROOT/'spec/ipv4-udp-icmp-endpoint-oracle.json').read_text())
        for scene in old['cases'].values():run_scenario(self.model,scene)

    def probes(self,state):
        if state=='EMPTY':return []
        if state=='PENDING':return [dict(at_ms=0,event='app.send',fields=dict(data=[7]))]
        reply=json.loads((ROOT/'spec/ipv4-udp-icmp-endpoint-oracle.json').read_text())['cases']['resolved-mixed']['steps'][0]
        return [dict(at_ms=0,event=reply['event'],fields=reply['fields'])]

    def test_partial_padding_and_other_six_domains_are_atomic_in_three_states(self):
        self.assertEqual(len(self.oracle['model_gaps']),6)
        for state in ('EMPTY','PENDING','RESOLVED'):
            for name,raw in self.oracle['model_gaps'].items():
                with self.subTest(state=state,domain=name):
                    machine=Machine(self.model)
                    for step in self.probes(state):machine.dispatch(step['event'],step['fields'],step['at_ms'])
                    before=machine.snapshot()
                    with self.assertRaises(Uncovered):machine.dispatch('net.frame',{'frame':list(bytes.fromhex(raw))},1)
                    self.assertEqual(machine.snapshot(),before)

    def test_all_eleven_fixed_input_independent_z3_paths(self):
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):self.assertEqual(crosscheck_trace(self.model,run_scenario(self.model,scene).trace)['status'],'match')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_native_eleven_literals_and_eighteen_atomic_domain_rejections(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/ipv4-udp-icmp-tap.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for name in self.oracle['cases']:
                with self.subTest(case=name):self.assertEqual(run(out/'source',out/'build',ROOT/'scenarios/ipv4-udp-icmp-tap'/(name+'.json'),out/name)['status'],'pass')
            for state in ('EMPTY','PENDING','RESOLVED'):
                for name,raw in self.oracle['model_gaps'].items():
                    with self.subTest(state=state,domain=name):
                        scene={'steps':self.probes(state)+[dict(at_ms=1,event='net.frame',fields=dict(frame=list(bytes.fromhex(raw))))]}
                        p=subprocess.run([str(out/'build/protocol-native')],input=commands(self.model,scene),capture_output=True,text=True,timeout=30)
                        self.assertEqual(p.returncode,1);self.assertEqual(p.stderr,'');rows=[json.loads(line)for line in p.stdout.splitlines()]
                        self.assertEqual(rows[-1]['status'],'error');self.assertEqual(rows[-1]['failure'],'uncovered_event')
                        self.assertEqual(rows[-1]['snapshot'],rows[-2]['snapshot'])
