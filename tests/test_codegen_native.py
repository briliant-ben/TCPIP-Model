"""Compile and execute real generated C; reference is a separate observation oracle."""
import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from protocol_lab.codegen import generate,Unsupported,sha
from protocol_lab.codegen.execute import build,run,commands,compare,write
from protocol_lab.ir import load,Machine,ModelError
ROOT=Path(__file__).resolve().parents[1]


@unittest.skipUnless(shutil.which('cc'),'C99 compiler required for actual native evidence')
class NativeCodegenTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory();self.root=Path(self.tmp.name)
        self.g=self.root/'generated';self.b=self.root/'build'
        generate(ROOT/'model/tcp.json',self.g)
        self.assertEqual(build(self.g,self.b)['status'],'pass')
    def tearDown(self):self.tmp.cleanup()
    def execute(self,data,binary=None):
        p=subprocess.run([str(binary or self.b/'protocol-native')],input=data,text=True,capture_output=True,timeout=10)
        self.assertFalse(p.stderr)
        return p,[json.loads(x)for x in p.stdout.splitlines()]

    def test_all_four_baseline_scenarios_match_exact_native_traces(self):
        paths=list((ROOT/'scenarios').glob('*.json'));self.assertEqual(len(paths),4)
        for path in paths:
            r=run(self.g,self.b,path,self.root/path.stem)
            self.assertEqual(r['status'],'pass',path.name)
            self.assertEqual(r['observation_origin'],'generated_native_execution')
            self.assertFalse(r['linux_network_evidence'])

    def test_failed_operation_rolls_back_timers_state_and_staged_emissions(self):
        p,rows=self.execute('B\nD 0 app.connect\nD 1010 net.synack 9000 9999\nD 1010 net.synack 9000 1001\n')
        self.assertEqual(p.returncode,1)
        error=next(r for r in rows if r['status']=='error')
        self.assertEqual(error['failure'],'uncovered_event')
        self.assertEqual(error['snapshot']['variables']['retries'],0)
        self.assertEqual(error['snapshot']['timers'],{'syn_rto':1000})
        self.assertEqual([r['transition']for r in rows if r['status']=='transition'],['T-ACTIVE-OPEN','T-SYN-RETRY','T-ACCEPT-SYNACK'])
        self.assertEqual(rows[-1]['snapshot']['state'],'ESTABLISHED')

    def test_timer_injection_bad_domain_and_backwards_clock_rejected(self):
        p,rows=self.execute('B\nD 0 timer.syn_rto\nD 0 net.synack -1 1001\nT 20\nT 19\n')
        self.assertEqual(p.returncode,1)
        self.assertEqual([r['failure']for r in rows if r['status']=='error'],['timer_injection','invalid_event_value','nonmonotonic_time'])
        self.assertEqual(rows[-1]['snapshot']['state'],'CLOSED')

    def test_rule_conflict_is_explicit_and_atomic(self):
        m=load(ROOT/'model/tcp.json');r=copy.deepcopy(m['transitions'][0]);r['id']='CONFLICT';m['transitions'].append(r)
        path=self.root/'conflict.json';write(path,m)
        g=self.root/'conflict-generated';b=self.root/'conflict-build';generate(path,g);build(g,b)
        p,rows=self.execute('B\nD 0 app.connect\n',b/'protocol-native')
        self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'rule_conflict')
        self.assertEqual(rows[-1]['snapshot']['state'],'CLOSED');self.assertEqual(rows[-1]['snapshot']['timers'],{})

    def test_integer_overflow_rejected_without_committing_retry(self):
        p,rows=self.execute('I 5 9223372036854775807\nB\nD 0 app.connect\nT 9223372036854775807\n')
        self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'integer_overflow')
        self.assertEqual(rows[-1]['snapshot']['variables']['retries'],0)
        self.assertEqual(rows[-1]['snapshot']['timers'],{'syn_rto':9223372036854775807})

    def test_rehashed_generated_source_change_rejected_before_build(self):
        path=self.g/'protocol.c';path.write_text(path.read_text()+'\n/* tampered */\n')
        r=json.loads((self.g/'generation.json').read_text());r['outputs']['protocol.c']=sha(path);write(self.g/'generation.json',r)
        with self.assertRaisesRegex(ValueError,'differs from actual IR lowering'):build(self.g,self.root/'tampered-build')

    def test_real_wrong_sequence_native_mutant_is_detected_by_reference_oracle(self):
        m=load(ROOT/'model/tcp.json');emit=next(a['emit']for a in m['transitions'][0]['actions']if 'emit'in a)
        emit['fields']['seq']={'op':'seq_add','args':[{'var':'iss'},1]}
        path=self.root/'mutant.json';write(path,m)
        g=self.root/'mutant-generated';b=self.root/'mutant-build';generate(path,g);build(g,b)
        scenario=json.loads((ROOT/'scenarios/handshake.json').read_text())
        p,rows=self.execute(commands(load(ROOT/'model/tcp.json'),scenario),b/'protocol-native')
        self.assertEqual(p.returncode,0)
        difference=compare(load(ROOT/'model/tcp.json'),scenario,rows)
        self.assertEqual(difference['status'],'different');self.assertEqual(difference['differences'][0]['kind'],'transition_trace')

    def test_separate_scalar_contract_uses_same_backend_and_ordered_assignments(self):
        g=self.root/'scalar-generated';b=self.root/'scalar-build'
        generate(ROOT/'model/seq32-contract.json',g);self.assertEqual(build(g,b)['status'],'pass')
        m=load(ROOT/'model/seq32-contract.json')
        for i,(left,right,offset)in enumerate([(0,1,-1),(4294967295,0,7),(1,4294967295,-4294967297)]):
            scenario={'scenario_version':'0.1','id':str(i),'steps':[{'at_ms':0,'event':'probe','fields':dict(left=left,right=right,offset=offset)}],'expect':{'state':'READY','timers':{}}}
            p,rows=self.execute(commands(m,scenario),b/'protocol-native');self.assertEqual(p.returncode,0)
            self.assertEqual(compare(m,scenario,rows)['status'],'match')


    def test_native_program_runs_with_empty_path_in_an_independent_directory(self):
        empty=self.root/'isolated';empty.mkdir()
        p=subprocess.run([str(self.b/'protocol-native')],input='B\nD 0 app.connect\nD 10 net.synack 9000 1001\n',
                         text=True,capture_output=True,cwd=empty,env={'PATH':''},timeout=10)
        self.assertEqual(p.returncode,0);self.assertFalse(p.stderr)
        self.assertEqual(json.loads(p.stdout.splitlines()[-1])['snapshot']['state'],'ESTABLISHED')

    def test_source_string_escaping_and_failure_json_are_safe(self):
        m=load(ROOT/'model/tcp.json');m['invariants'][-1]['id']='lower"bound\n%'
        emit=next(a['emit']for a in m['transitions'][0]['actions']if 'emit'in a)
        emit['fields']['flags']='S"\n%u'
        source=self.root/'quoted.json';write(source,m)
        g=self.root/'quoted-generated';b=self.root/'quoted-build';generate(source,g);build(g,b)
        p,rows=self.execute('B\nD 0 app.connect\n',b/'protocol-native')
        self.assertEqual(p.returncode,0)
        self.assertEqual(next(r for r in rows if r['status']=='transition')['emitted'][0]['fields']['flags'],'S"\n%u')
        p,rows=self.execute('I 5 0\nB\n',b/'protocol-native')
        self.assertEqual(p.returncode,2)
        self.assertEqual(rows[0]['failure'],'invariant:lower"bound\n%')

    def test_source_changed_after_compilation_cannot_be_used_as_valid_evidence(self):
        source=self.g/'protocol.c';source.write_text(source.read_text()+'\n/* changed */\n')
        with self.assertRaisesRegex(ValueError,'source changed after compilation'):
            run(self.g,self.b,ROOT/'scenarios/handshake.json',self.root/'stale-run')

    def test_bytes_and_unknown_semantics_are_rejected_without_output(self):
        out=self.root/'unsupported'
        with self.assertRaisesRegex(Unsupported,'state supported'):generate(ROOT/'model/bytes-contract.json',out)
        self.assertFalse(out.exists())
        m=load(ROOT/'model/tcp.json');m['unexpected_semantics']=True
        path=self.root/'extra.json';write(path,m)
        with self.assertRaises(Unsupported):generate(path,out)
        self.assertFalse(out.exists())

if __name__=='__main__':unittest.main()
