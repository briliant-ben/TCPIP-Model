import copy,hashlib,json,unittest
from pathlib import Path
from unittest.mock import patch
import z3
from protocol_lab.ir import load,ModelError
from protocol_lab.symbolic import Encoding
from candidate_rule_probe import render_probe
ROOT=Path('/Users/xubenling/Documents/ChatGPT/Protocol_Form/TCPIP-Model')
class ProbeQualification(unittest.TestCase):
 def setUp(self):self.m=load(ROOT/'model/word32-contract.json')
 def answers(self,m):
  r=render_probe(m,['PACK']);a={}
  for q in r['queries']:
   self.assertEqual(hashlib.sha256(q['smt2'].encode()).hexdigest(),q['sha256']);s=z3.Solver();s.from_string(q['smt2']);a[q['role']]=str(s.check())
  return a
 def test_good(self):self.assertEqual(self.answers(self.m),dict(preservation='unsat',nonvacuity='sat'))
 def test_bad_assignment(self):
  self.m['transitions'][0]['actions'][0]['set']['value']={'bytes':[1,2,3]}
  self.assertEqual(self.answers(self.m),dict(preservation='sat',nonvacuity='sat'))
 def test_disabled(self):
  self.m['transitions'][0]['guard']=False
  self.assertEqual(self.answers(self.m)['nonvacuity'],'unsat')
 def test_pure_no_solve_no_mutation(self):
  old=copy.deepcopy(self.m)
  with patch.object(z3.Solver,'check',side_effect=AssertionError('No solve in builder')):r=render_probe(self.m,['PACK'])
  self.assertEqual(old,self.m);self.assertFalse(r['solver_executed'])
 def test_noninitial_prestate(self):
  r=render_probe(self.m,['PACK']);q=next(q for q in r['queries']if q['role']=='nonvacuity');s=z3.Solver();s.from_string(q['smt2']);e=Encoding(self.m,1,tuple(self.m['variables']),arbitrary_state=True,fixed_choices=[0]);s.add(e.frames[0]['values']['packed']!=e.literal([0,0,0,0],'bytes'));self.assertEqual(s.check(),z3.sat)
 def test_reject_inputs(self):
  for ids in [[],['PACK','PACK'],['unknown']]:
   with self.assertRaises(ModelError):render_probe(self.m,ids)
  self.m['ir_version']='0.3'
  with self.assertRaises(ModelError):render_probe(self.m,['PACK'])
 def test_reject_event_clock_invariant(self):
  for v in [{'event':'value'},{'clock_ms':True}]:
   m=copy.deepcopy(self.m);m['invariants'][0]['assert']={'op':'eq','args':[v,0]}
   with self.assertRaises(ModelError):render_probe(m,['PACK'])
