"""Bound unoptimized rule frames while retaining atomic full-guard dispatch."""
import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,commands,compare,write
from protocol_lab.ir import load

ROOT=Path(__file__).resolve().parents[1]
def op(name,*args):return dict(op=name,args=list(args))
def assign(name,value):return dict(set=dict(var=name,value=value))
def rule(name,event,guard,actions):return dict(id=name,**{'from':'READY','to':'READY'},event=event,guard=guard,actions=actions,requirements=['BYTE-CONTENT'])

def many_rules():
    m=load(ROOT/'model/bytes-contract.json');m['variables']={'saved':dict(type='bytes',initial=[]),'count':dict(type='int',initial=0)}
    m['events']={'choose':dict(origin='application',fields=dict(pick='int',data='bytes'))};m['timers']={};m['messages']={'result':dict(fields=dict(data='bytes',count='int'))};m['invariants']=[];m['transitions']=[]
    for i in range(64):
        # Each branch needs many separate Bytes values at -O0. The dispatcher
        # must not reserve these temporaries for all 64 unchosen actions.
        part=op('bytes_concat',op('bytes_slice',{'event':'data'},0,64),op('bytes_concat',{'bytes':[i]},op('bytes_slice',{'event':'data'},1,63)))
        guard=op('and',op('eq',{'event':'pick'},i),op('eq',copy.deepcopy(part),copy.deepcopy(part)))
        actions=[assign('saved',copy.deepcopy(part))for _ in range(8)]+[assign('count',op('add',{'var':'count'},1)),{'emit':dict(message='result',fields=dict(data={'var':'saved'},count={'var':'count'}))}]
        m['transitions'].append(rule('CASE-'+str(i),'choose',guard,actions))
    return m


@unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
class NativeRuleHelpersTests(unittest.TestCase):
    def setUp(self):self.temporary=tempfile.TemporaryDirectory(prefix='native-rule-helpers-');self.root=Path(self.temporary.name)
    def tearDown(self):self.temporary.cleanup()
    def compile(self,m,name):
        path=self.root/(name+'.json');write(path,m);generate(path,self.root/(name+'-source'));r=build(self.root/(name+'-source'),self.root/(name+'-build'));self.assertEqual(r['status'],'pass',(self.root/(name+'-build/compiler.stderr')).read_text());return self.root/(name+'-build/protocol-native')
    def execute(self,binary,data):
        p=subprocess.run([str(binary)],input=data,text=True,capture_output=True,env={'PATH':''},timeout=10);self.assertFalse(p.stderr);return p,[json.loads(r)for r in p.stdout.splitlines()]
    def scenario(self,pick,data):return dict(scenario_version='0.2',id='generic-rule-dispatch',initial={},steps=[dict(at_ms=0,event='choose',fields=dict(pick=pick,data=data))],expect=dict(state='READY',timers={}))

    def test_sixty_four_byte_heavy_rules_have_bounded_unoptimized_frames_and_exact_outputs(self):
        m=many_rules();binary=self.compile(m,'many');source=self.root/'many-source/protocol.c'
        # Fail at compile time if a single static frame exceeds 1 MiB. No
        # optimization, extra stack, altered runtime capacity or protocol input
        # restriction is used. This model's full 64-rule dispatcher used to
        # aggregate megabytes of temporaries in its one fire() frame.
        p=subprocess.run([shutil.which('cc'),'-std=c99','-O0','-Wall','-Wextra','-Werror','-Wframe-larger-than=1048576',str(source),'-o',str(self.root/'bounded')],capture_output=True,text=True,timeout=60);self.assertEqual(p.returncode,0,p.stderr)
        for pick in (0,31,63):
            scene=self.scenario(pick,list(range(128)));p,rows=self.execute(binary,commands(m,scene));self.assertEqual(p.returncode,0);self.assertEqual(compare(m,scene,rows)['status'],'match');self.assertEqual(rows[-1]['snapshot']['variables']['count'],1)
        p,rows=self.execute(binary,commands(m,self.scenario(64,[])));self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'uncovered_event');self.assertEqual(rows[-1]['snapshot'],rows[0]['snapshot'])

    def test_all_guards_are_checked_before_actions_and_conflict_is_atomic(self):
        m=many_rules();extra=copy.deepcopy(m['transitions'][0]);extra['id']='LATE-CONFLICT';m['transitions'].append(extra);binary=self.compile(m,'conflict');p,rows=self.execute(binary,commands(m,self.scenario(0,[1,2,3])));self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'rule_conflict');self.assertEqual(rows[-1]['snapshot'],rows[0]['snapshot']);self.assertFalse(any(r['status']=='transition'for r in rows))
        # Even after one matching guard, a later eligible guard's checked
        # capacity failure must abort before an earlier action is dispatched.
        m['transitions'][-1]['guard']=op('eq',op('bytes_len',op('bytes_concat',{'event':'data'},{'bytes':[0]})),0);binary=self.compile(m,'guard-error');p,rows=self.execute(binary,commands(m,self.scenario(0,[17]*4096)));self.assertEqual(p.returncode,1);self.assertEqual(rows[-1]['failure'],'byte_capacity');self.assertEqual(rows[-1]['snapshot'],rows[0]['snapshot'])

    def test_boolean_short_circuit_and_ordered_assignments_are_preserved(self):
        m=many_rules();danger=op('eq',op('bytes_len',op('bytes_concat',{'event':'data'},{'bytes':[0]})),0)
        m['transitions'][0]['guard']=op('and',op('eq',{'event':'pick'},0),op('or',True,copy.deepcopy(danger)))
        m['transitions'].append(rule('DEAD-GUARD','choose',op('and',False,danger),[]));m['transitions'][0]['actions']=[assign('count',1),assign('count',op('add',{'var':'count'},9)),assign('saved',op('bytes_slice',{'event':'data'},0,3))]
        binary=self.compile(m,'short-circuit');scene=self.scenario(0,[17]*4096);p,rows=self.execute(binary,commands(m,scene));self.assertEqual(p.returncode,0);self.assertEqual(compare(m,scene,rows)['status'],'match');self.assertEqual(rows[-1]['snapshot']['variables'],dict(saved=[17]*3,count=10))

    def test_action_failure_rolls_back_assignments_emissions_and_earlier_timer_expiry(self):
        m=many_rules();m['events']['arm']=dict(origin='application',fields={});m['events']['expire']=dict(origin='timer',fields={});m['timers']={'pulse':dict(event='expire')}
        m['transitions'] += [rule('ARM','arm',True,[{'arm':dict(timer='pulse',delay_ms=5)}]),rule('EXPIRE','expire',{'timer_active':'pulse'},[assign('count',op('add',{'var':'count'},1))])]
        m['transitions'][0]['actions']=[assign('saved',{'event':'data'}),{'emit':dict(message='result',fields=dict(data={'var':'saved'},count={'var':'count'}))},assign('count',op('add',(1<<63)-1,1))]
        binary=self.compile(m,'action-error');p,rows=self.execute(binary,'B\nD 0 arm\nD 10 choose 0 b:0102\nT 5\n');self.assertEqual(p.returncode,1);error=next(r for r in rows if r['status']=='error');self.assertEqual(error['failure'],'integer_overflow');self.assertEqual(error['snapshot']['timers'],{'pulse':5});self.assertEqual(error['snapshot']['variables'],dict(saved=[],count=0));self.assertEqual([r['transition']for r in rows if r['status']=='transition'],['ARM','EXPIRE']);self.assertEqual(rows[-1]['snapshot']['variables']['count'],1);self.assertEqual(rows[-1]['snapshot']['timers'],{})

    def test_timer_guard_observes_active_timer_before_expiring_cancel_and_action_can_rearm(self):
        m=many_rules();m['events']={'arm':dict(origin='application',fields={}), 'expire':dict(origin='timer',fields={})};m['timers']={'pulse':dict(event='expire')};m['messages']={'active':dict(fields=dict(value='bool'))};m['transitions']=[rule('ARM','arm',True,[{'arm':dict(timer='pulse',delay_ms=5)}]),rule('EXPIRE','expire',{'timer_active':'pulse'},[{'emit':dict(message='active',fields=dict(value={'timer_active':'pulse'}))},assign('count',op('add',{'var':'count'},1)),{'arm':dict(timer='pulse',delay_ms=5)}])]
        binary=self.compile(m,'timer');scene=dict(scenario_version='0.2',id='timer-order',steps=[dict(at_ms=0,event='arm',fields={}),dict(at_ms=5,tick=True)],expect=dict(state='READY',timers={'pulse':10}));p,rows=self.execute(binary,commands(m,scene));self.assertEqual(p.returncode,0);self.assertEqual(compare(m,scene,rows)['status'],'match');self.assertEqual(rows[-1]['snapshot']['timers'],{'pulse':10});transition=[r for r in rows if r['status']=='transition'][-1];self.assertEqual(transition['emitted'],[dict(message='active',fields=dict(value=False))])

if __name__=='__main__':unittest.main(verbosity=2)
