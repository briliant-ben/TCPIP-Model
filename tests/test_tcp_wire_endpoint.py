"""Finite TCP wire IR byte contracts; no all-input or real peer claim."""
import copy
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from protocol_lab.ir import load,Machine,Uncovered
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,run,commands
ROOT=Path(__file__).resolve().parents[1]


def op(n,*a):return {'op':n,'args':list(a)}
P={'event':'packet'}
def at(n):return op('bytes_at_or_zero',P,n)
def u16(n):return op('add',op('mul',at(n),256),at(n+1))
def u32(n):return op('add',op('add',op('mul',at(n),16777216),op('mul',at(n+1),65536)),op('add',op('mul',at(n+2),256),at(n+3)))
READS={'seq':op('seq_add',{'seq':0},u32(24)),'ack':op('seq_add',{'seq':0},u32(28)),'window':u16(34),'data':op('bytes_slice',P,40,op('sub',op('bytes_len',P),40))}

def restore(x):
    for name,value in READS.items():
        if x==value:return {'event':name}
    if isinstance(x,list):return [restore(v)for v in x]
    if isinstance(x,dict):return {k:restore(v)for k,v in x.items()}
    return x

def flatten(x):
    if isinstance(x,dict)and x.get('op')=='bytes_concat':return flatten(x['args'][0])+flatten(x['args'][1])
    return [x]


class TcpWireEndpointTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/tcp-wire-endpoint.json');self.old=load(ROOT/'model/tcp-data.json')
        self.oracle=json.loads((ROOT/'spec/tcp-wire-endpoint-oracle.json').read_text())

    def test_eleven_independent_frozen_packets_and_trajectories(self):
        self.assertEqual(len(self.oracle['cases']),11);self.assertEqual(len(self.model['transitions']),172)
        for name,digest in self.oracle['sources'].items():self.assertEqual(hashlib.sha256((ROOT/'spec/sources'/name).read_bytes()).hexdigest(),digest)
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):
                self.assertEqual(json.loads((ROOT/'scenarios/tcp-wire-endpoint'/(name+'.json')).read_text()),scene);run_scenario(self.model,scene)

    def test_all_117_protocol_rules_preserve_guards_actions_and_wire_field_sources(self):
        for name,spec in self.old['variables'].items():self.assertEqual(self.model['variables'][name],spec)
        for key in ('states','initial_state','timers'):self.assertEqual(self.model[key],self.old[key])
        for old,new in zip(self.old['transitions'],self.model['transitions'][:117],strict=True):
            with self.subTest(rule=old['id']):
                self.assertEqual((new['id'],new['from'],new['to']),(old['id'],old['from'],old['to']))
                network=self.old['events'][old['event']]['origin']=='network'
                self.assertEqual(new['event'],'net.packet'if network else old['event'])
                self.assertEqual(restore(new['guard']['args'][1])if network else new['guard'],old['guard'])
                actions=copy.deepcopy(new['actions'])
                if network:self.assertEqual(actions.pop(0),{'set':{'var':'wire_disposition','value':'protocol'}})
                for original in old['actions']:
                    if 'emit'not in original or original['emit']['message']not in ('tcp','tcp_data'):
                        action=actions.pop(0);self.assertEqual(restore(action)if network else action,original);continue
                    block=actions[:8];del actions[:8];fields=original['emit']['fields']
                    self.assertEqual([a['set']['var']for a in block[:7]],['wire_data','wire_flags','wire_tcp_zero','wire_pseudo','wire_tcp','wire_ip_zero','wire_packet'])
                    data=restore(block[0]['set']['value'])if network else block[0]['set']['value'];self.assertEqual(data,fields.get('payload',{'bytes':[]}))
                    flagvalue=block[1]['set']['value'];self.assertEqual(flagvalue['args'][:2],[op('ge',op('bytes_len',{'var':'wire_data'}),1),24])
                    bits=flagvalue['args'][2]
                    for label,value in [('S',2),('SA',18),('A',16),('FA',17),('R',4),('RA',20)]:
                        expr=restore(bits['args'][0]['args'][0])if network else bits['args'][0]['args'][0]
                        self.assertEqual((bits['op'],expr,bits['args'][0]['args'][1],bits['args'][1]),('ite',fields['flags'],label,value));bits=bits['args'][2]
                    self.assertEqual(bits,0)
                    leaves=flatten(block[2]['set']['value']);leaves=restore(leaves)if network else leaves
                    self.assertEqual(leaves,[{'bytes':[156,64,31,144]},op('bytes_pack32be_mod',op('seq_distance',{'seq':0},fields['seq'])),op('bytes_pack32be_mod',op('seq_distance',{'seq':0},fields['ack'])),{'bytes':[80]},op('bytes_pack8_mod',{'var':'wire_flags'}),op('bytes_pack16be_mod',fields['window']),{'bytes':[0,0,0,0]},{'var':'wire_data'}])
                    self.assertEqual(block[-1],{'emit':{'message':'ipv4.tx','fields':{'packet':{'var':'wire_packet'}}}})
                self.assertEqual(actions,[])

    def prefix(self,state):
        scene=self.oracle['cases']['bidirectional-cumulative-close']
        return []if state=='CLOSED'else scene['steps'][:1]if state=='SYN-SENT'else scene['steps'][:2]

    def test_twelve_unsupported_wire_domains_reject_atomically_in_three_states(self):
        self.assertEqual(len(self.oracle['model_gaps']),12)
        for state in ('CLOSED','SYN-SENT','ESTABLISHED'):
            for name,raw in self.oracle['model_gaps'].items():
                with self.subTest(state=state,domain=name):
                    m=Machine(self.model)
                    for s in self.prefix(state):m.dispatch(s['event'],s['fields'],s['at_ms'])
                    before=m.snapshot()
                    with self.assertRaises(Uncovered):m.dispatch('net.packet',{'packet':list(bytes.fromhex(raw))},20)
                    self.assertEqual(m.snapshot(),before)

    def test_legacy_network_descriptors_have_no_runnable_bypass(self):
        for name,spec in self.old['events'].items():
            if spec['origin']!='network':continue
            self.assertFalse(any(r['event']==name for r in self.model['transitions']))
            fields={k:[1]if t=='bytes'else 16 if t=='int'else 9000 for k,t in spec['fields'].items()};m=Machine(self.model);before=m.snapshot()
            with self.assertRaises(Uncovered):m.dispatch(name,fields,0)
            self.assertEqual(m.snapshot(),before)

    def test_all_eleven_exact_fixed_input_z3_paths(self):
        for name,scene in self.oracle['cases'].items():
            with self.subTest(case=name):self.assertEqual(crosscheck_trace(self.model,run_scenario(self.model,scene).trace)['status'],'match')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_native_eleven_literal_trajectories(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/tcp-wire-endpoint.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for name in self.oracle['cases']:
                with self.subTest(case=name):self.assertEqual(run(out/'source',out/'build',ROOT/'scenarios/tcp-wire-endpoint'/(name+'.json'),out/name)['status'],'pass')

    def test_valid_checksum_wrong_seq_packet_and_payload_offset_faults_fail_literals(self):
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='D-FLUSH-FIRST')
        # Keep checksum construction intact, but encode the wrong sequence value.
        tcpzero=next(a['set']['value']for a in rule['actions']if 'set'in a and a['set']['var']=='wire_tcp_zero')
        def replace(x):
            if x==op('bytes_pack32be_mod',op('seq_distance',{'seq':0},{'var':'snd_nxt'})):return op('bytes_pack32be_mod',op('seq_distance',{'seq':0},op('seq_add',{'var':'snd_nxt'},1)))
            if isinstance(x,list):return [replace(v)for v in x]
            if isinstance(x,dict):return {k:replace(v)for k,v in x.items()}
            return x
        for a in rule['actions']:
            if 'set'in a and a['set']['var']=='wire_tcp_zero':a['set']['value']=replace(tcpzero)
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.oracle['cases']['bidirectional-cumulative-close'])
        bad=copy.deepcopy(self.model);rule=next(r for r in bad['transitions']if r['id']=='D-RECEIVE-IN-ORDER')
        def offset(x):
            if x==READS['data']:return op('bytes_slice',P,41,op('sub',op('bytes_len',P),40))
            if isinstance(x,list):return [offset(v)for v in x]
            if isinstance(x,dict):return {k:offset(v)for k,v in x.items()}
            return x
        rule['actions']=offset(rule['actions'])
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.oracle['cases']['bidirectional-cumulative-close'])
