import copy,json,unittest
from pathlib import Path
import z3
from protocol_lab.initial_plan import render_plan
class IndependentPlannerContract(unittest.TestCase):
 def plan(self):return render_plan(json.loads((Path(__file__).resolve().parents[1]/'model/word32-contract.json').read_text()))
 def test_complete_actual_choice_cover(self):
  p=self.plan();c=p['choice_cover'];text=c if isinstance(c,str)else c.get('smt2');self.assertIsInstance(text,str);self.assertTrue(text.strip());self.assertGreater(len(z3.parse_smt2_string(text)),0)
 def test_all_rules_plus_idle_and_clock(self):
  p=self.plan();rows=p['safety'] if 'safety' in p else p.get('choice_cover',{}).get('reduced_safety',[]);self.assertEqual({r['choice']for r in rows},{-2,-1,0});self.assertEqual(len(rows),3)
 def test_original_query_has_base_and_no_mutation(self):
  m=json.loads((Path(__file__).resolve().parents[1]/'model/word32-contract.json').read_text());original=copy.deepcopy(m);p=render_plan(m);self.assertEqual(m,original);text=p['original_safety'];text=text if isinstance(text,str)else text['smt2'];self.assertGreater(len(z3.parse_smt2_string(text)),1)
 def test_explicit_initial_bindings_retained_in_every_branch(self):
  from protocol_lab.symbolic import Encoding
  from protocol_lab.initial_units import reduce_initial_constants
  m=json.loads((Path(__file__).resolve().parents[1]/'model/word32-contract.json').read_text());enc=Encoding(m,1,[]);inv=[enc.expr(x['assert'],fr)for fr in enc.frames for x in m['invariants']];original=list(enc.solver.assertions())+[z3.Or(z3.Not(z3.And(*inv)),*enc.action_faults)];bindings=reduce_initial_constants(original)['bindings'];p=render_plan(m);rows=p['safety'] if 'safety' in p else p.get('choice_cover',{}).get('reduced_safety',[]);self.assertTrue(rows)
  for row in rows:
   actual=list(z3.parse_smt2_string(row['smt2']))
   for binding in bindings:self.assertTrue(any(z3.eq(z3.simplify(a),z3.simplify(binding))for a in actual),'Missing explicit initial binding')
 def test_plan_never_solves_or_uses_reference(self):
  from unittest.mock import patch
  with patch.object(z3.Solver,'check',side_effect=AssertionError('solve')),patch.object(z3.Solver,'model',side_effect=AssertionError('model')),patch('protocol_lab.ir.Machine.dispatch',side_effect=AssertionError('reference')):self.plan()
