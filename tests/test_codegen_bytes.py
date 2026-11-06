"""Real native byte execution: content, OFFSET/COUNT, rollback and TCP reuse."""
import copy
import json
import importlib.util
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch
from protocol_lab.codegen import generate,render,Unsupported,BYTE_CAP
from protocol_lab.codegen.execute import build,run,commands,compare,write
from protocol_lab.ir import load
from protocol_lab.flow import run_scenario

ROOT=Path(__file__).resolve().parents[1]


@unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
class NativeBytesTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory(prefix='native-byte-tests-');self.root=Path(self.tmp.name)
        self.model=load(ROOT/'model/bytes-contract.json')
        self.binary=self.compile(self.model,'baseline')

    def tearDown(self):self.tmp.cleanup()

    def compile(self,model,name):
        path=self.root/(name+'.json');write(path,model);g=self.root/(name+'-source');b=self.root/(name+'-build')
        generate(path,g);r=build(g,b)
        self.assertEqual(r['status'],'pass',(r,(b/'compiler.stderr').read_text()))
        return b/'protocol-native'

    def execute(self,text,binary=None):
        p=subprocess.run([str(binary or self.binary)],input=text,text=True,capture_output=True,env={'PATH':''},timeout=10)
        self.assertFalse(p.stderr);return p,[json.loads(line)for line in p.stdout.splitlines()]

    def case(self,data,offset,initial=None):
        return dict(scenario_version='0.1',id='bytes',initial=initial or {},steps=[dict(at_ms=0,event='probe',fields=dict(data=data,offset=offset))],expect=dict(state='READY',timers={}))

    def test_all_byte_values_extreme_offsets_and_initial_overrides_match_reference(self):
        for offset in (-(1<<63),-1,0,1,255,1<<40,(1<<63)-1):
            with self.subTest(offset=offset):
                case=self.case(list(range(256)),offset,{'buffer':[255,0,17]})
                p,rows=self.execute(commands(self.model,case));self.assertEqual(p.returncode,0)
                self.assertEqual(compare(self.model,case,rows)['status'],'match')
                self.assertEqual(rows[-1]['snapshot']['variables']['whole'],[255,0,17]+list(range(256)))

    def test_slice_count_is_not_end_index_and_clamps_without_integer_overflow(self):
        model=copy.deepcopy(self.model);model['events']['probe']['fields']['count']='int'
        model['transitions'][0]['actions']=[{'set':{'var':'prefix','value':{'op':'bytes_slice','args':[{'event':'data'},{'event':'offset'},{'event':'count'}]}}}]
        model['messages']={'result':{'fields':{'data':'bytes','size':'int'}}}
        model['transitions'][0]['actions'].append({'emit':{'message':'result','fields':{'data':{'var':'prefix'},'size':{'op':'bytes_len','args':[{'var':'prefix'}]}}}})
        model['invariants']=[];binary=self.compile(model,'slice')
        for offset,count,expected in ((1,2,[17,34]),(-2,2,[0,17]),(2,-1,[]),(1,(1<<63)-1,[17,34,255]),((1<<63)-1,4,[])):
            with self.subTest(offset=offset,count=count):
                case=self.case([0,17,34,255],offset);case['steps'][0]['fields']['count']=count
                p,rows=self.execute(commands(model,case),binary);self.assertEqual(p.returncode,0)
                emitted=next(r for r in rows if r['status']=='transition')['emitted'][0]['fields']
                self.assertEqual(emitted,{'data':expected,'size':len(expected)})
                self.assertEqual(compare(model,case,rows)['status'],'match')

    def test_long_hex_line_and_exact_capacity_preserve_full_content(self):
        data=[0,255,17,128]*(BYTE_CAP//4);case=self.case(data,2049)
        text=commands(self.model,case);self.assertGreater(len(text),4096)
        p,rows=self.execute(text);self.assertEqual(p.returncode,0)
        self.assertEqual(compare(self.model,case,rows)['status'],'match')
        self.assertEqual(rows[-1]['snapshot']['variables']['restored'],data)

    def test_byte_values_are_copied_across_ordered_assignments(self):
        model=copy.deepcopy(self.model);model['invariants']=[]
        model['transitions'][0]['actions']=[{'set':{'var':'whole','value':{'event':'data'}}},{'set':{'var':'buffer','value':{'var':'whole'}}},{'set':{'var':'whole','value':{'bytes':[9]}}}]
        binary=self.compile(model,'ownership');case=self.case([0,255,7],0)
        p,rows=self.execute(commands(model,case),binary);self.assertEqual(p.returncode,0)
        self.assertEqual(rows[-1]['snapshot']['variables']['buffer'],[0,255,7]);self.assertEqual(rows[-1]['snapshot']['variables']['whole'],[9])
        self.assertEqual(compare(model,case,rows)['status'],'match')

    def test_malformed_hex_and_oversized_input_leave_committed_state_unchanged(self):
        for token,reason in (('b:0','invalid_bytes_token'),('b:gg','invalid_bytes_token'),('b:'+'ff'*(BYTE_CAP+1),'byte_capacity')):
            with self.subTest(reason=reason):
                p,rows=self.execute('B\nD 0 probe '+token+' 0\n')
                self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],reason)
                self.assertEqual(rows[-1]['snapshot'],rows[0]['snapshot'])

    def test_capacity_failure_rolls_back_preceding_timers_and_staged_outputs(self):
        model=copy.deepcopy(self.model);model['variables']['ticks']={'type':'int','initial':0}
        model['events'].update({'arm':{'origin':'application','fields':{}},'expire':{'origin':'timer','fields':{}}});model['timers']={'pulse':{'event':'expire'}}
        model['transitions'] += [dict(id='ARM',**{'from':'READY','to':'READY'},event='arm',guard=True,requirements=['BYTE-CONTENT'],actions=[{'arm':{'timer':'pulse','delay_ms':5}}]),dict(id='EXPIRE',**{'from':'READY','to':'READY'},event='expire',guard=True,requirements=['BYTE-CONTENT'],actions=[{'set':{'var':'ticks','value':{'op':'add','args':[{'var':'ticks'},1]}}}])]
        binary=self.compile(model,'timers');data='b:'+'ff'*BYTE_CAP
        p,rows=self.execute('I 0 '+data+'\nB\nD 0 arm\nD 10 probe b:01 1\nD 10 probe b: 1\n',binary)
        self.assertEqual(p.returncode,1);error=next(r for r in rows if r['status']=='error')
        self.assertEqual(error['failure'],'byte_capacity');self.assertEqual(error['snapshot']['variables']['ticks'],0)
        self.assertEqual(error['snapshot']['timers'],{'pulse':5})
        self.assertEqual([r['transition']for r in rows if r['status']=='transition'],['ARM','EXPIRE','PROBE'])
        self.assertEqual(rows[-1]['snapshot']['variables']['ticks'],1)

    def test_snapshot_exhaustion_returns_valid_json_and_rolls_back(self):
        model=copy.deepcopy(self.model);model['invariants']=[]
        model['variables']={str(i):{'type':'bytes','initial':[]}for i in range(20)}
        model['transitions'][0]['actions']=[{'set':{'var':str(i),'value':{'event':'data'}}}for i in range(20)]
        binary=self.compile(model,'snapshot-capacity')
        p,rows=self.execute('B\nD 0 probe b:'+'ff'*BYTE_CAP+' 0\n',binary)
        self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'output_capacity')
        self.assertEqual(rows[-1]['snapshot'],rows[0]['snapshot'])

    def test_same_length_content_fault_is_detected_even_when_invariant_passes(self):
        from protocol_lab.codegen import HERE
        original=render
        def mutant(model,wire=None):
            return original(model,wire).replace('memcpy(out.data+a.len,b.data,b.len);','for(size_t i=0;i<b.len;i++)out.data[a.len+i]=b.data[b.len-1-i];')
        with patch('protocol_lab.codegen.render',side_effect=mutant),patch('protocol_lab.codegen.execute.render',side_effect=mutant):binary=self.compile(self.model,'content-mutant')
        case=self.case([0,1,2,255],99);p,rows=self.execute(commands(self.model,case),binary)
        self.assertEqual(p.returncode,0);self.assertEqual(len(rows[-1]['snapshot']['variables']['whole']),4)
        self.assertEqual(compare(self.model,case,rows)['status'],'different')

    def test_existing_tcp_data_scenarios_use_same_generated_backend(self):
        g=self.root/'tcp-data-source';b=self.root/'tcp-data-build';generate(ROOT/'model/tcp-data.json',g)
        r=build(g,b);self.assertEqual(r['status'],'pass',(r,(b/'compiler.stderr').read_text()))
        scenarios=list((ROOT/'scenarios/data').glob('*.json'));self.assertEqual(len(scenarios),15)
        for scenario in scenarios:
            with self.subTest(scenario=scenario.name):self.assertEqual(run(g,b,scenario,self.root/('tcp-'+scenario.stem))['status'],'pass')

    def test_fixed_input_symbolic_replay_covers_nonzero_content_and_negative_slice(self):
        if not importlib.util.find_spec('z3'):self.skipTest('Z3 required')
        from protocol_lab.symbolic import crosscheck_trace
        case=self.case([255,0,19,128],-4,{'buffer':[7]});reference=run_scenario(self.model,case)
        self.assertEqual(crosscheck_trace(self.model,reference.trace)['status'],'match')
        p,rows=self.execute(commands(self.model,case));self.assertEqual(p.returncode,0)
        self.assertEqual(compare(self.model,case,rows)['status'],'match')

    def test_closed_string_values_preserve_nul_unicode_and_content_equality(self):
        model=copy.deepcopy(self.model);model['invariants']=[]
        model['variables']['label']={'type':'string','initial':'a\0left'}
        model['messages']={'label':{'fields':{'text':'string','equal':'bool','different':'bool'}}}
        choice={'op':'ite','args':[{'op':'eq','args':[{'event':'offset'},0]},'a\0right','a🧪\n%']}
        model['transitions'][0]['actions']=[{'set':{'var':'label','value':choice}},{'emit':{'message':'label','fields':{'text':{'var':'label'},'equal':{'op':'eq','args':[{'var':'label'},'a\0right']},'different':{'op':'ne','args':[{'var':'label'},'a\0left']}}}}]
        binary=self.compile(model,'string-content')
        for offset,expected in ((0,'a\0right'),(1,'a🧪\n%')):
            with self.subTest(offset=offset):
                case=self.case([],offset,{'label':'a\0right'})
                p,rows=self.execute(commands(model,case),binary);self.assertEqual(p.returncode,0)
                self.assertEqual(rows[-1]['snapshot']['variables']['label'],expected)
                self.assertEqual(compare(model,case,rows)['status'],'match')

    def test_address_and_undefined_sanitizers_accept_extreme_slice_inputs(self):
        source=self.root/'baseline-source/protocol.c';binary=self.root/'sanitized-native'
        command=[shutil.which('cc'),'-std=c99','-fsanitize=address,undefined','-fno-omit-frame-pointer',str(source),'-o',str(binary)]
        compiled=subprocess.run(command,capture_output=True,text=True,timeout=30)
        self.assertEqual(compiled.returncode,0,compiled.stderr)
        case=self.case([0,255,1,128]*(BYTE_CAP//4),(1<<63)-1)
        p=subprocess.run([str(binary)],input=commands(self.model,case),capture_output=True,text=True,timeout=15,env={'PATH':'','ASAN_OPTIONS':'detect_leaks=0:symbolize=0:halt_on_error=1','UBSAN_OPTIONS':'halt_on_error=1:print_stacktrace=1:symbolize=0'})
        self.assertEqual(p.returncode,0,p.stderr);self.assertFalse(p.stderr)
        rows=[json.loads(line)for line in p.stdout.splitlines()]
        self.assertEqual(compare(self.model,case,rows)['status'],'match')

    def test_false_transition_return_cannot_be_promoted_to_success(self):
        original=render;model=copy.deepcopy(self.model);model['transitions'][0]['guard']=False
        def mutant(source,wire=None):
            return original(source,wire).replace('failure=count?"rule_conflict":"uncovered_event";return 0;','failure=NULL;return 0;')
        with patch('protocol_lab.codegen.render',side_effect=mutant),patch('protocol_lab.codegen.execute.render',side_effect=mutant):binary=self.compile(model,'false-return')
        p,rows=self.execute('B\nD 0 probe b:01 0\n',binary)
        self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'internal_transition_failure')
        self.assertEqual(rows[-1]['snapshot'],rows[0]['snapshot'])

    def test_unsupported_string_inputs_and_large_literals_are_explicit(self):
        model=copy.deepcopy(self.model);model['variables']['buffer']['initial']=[0]*(BYTE_CAP+1)
        path=self.root/'too-large.json';write(path,model)
        with self.assertRaises(Unsupported):generate(path,self.root/'too-large-out')
        self.assertFalse((self.root/'too-large-out').exists())
        model=copy.deepcopy(self.model);model['events']['probe']['fields']['label']='string'
        path=self.root/'string-input.json';write(path,model)
        with self.assertRaisesRegex(Unsupported,'String event fields'):generate(path,self.root/'string-input-out')


if __name__=='__main__':unittest.main()
