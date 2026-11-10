import copy,json,unittest,z3
from pathlib import Path
from protocol_lab.initial_plan import render_plan
class SemanticPlannerTests(unittest.TestCase):
 def model(self):return json.loads((Path(__file__).resolve().parents[1]/'model/word32-contract.json').read_text())
 def test_cover_is_complement_not_membership(self):
  p=render_plan(self.model());q=p['choice_cover'];q=q if isinstance(q,str)else q['smt2'];a=list(z3.parse_smt2_string(q))[-1];self.assertTrue(z3.is_not(a),'Coverage remainder must be F AND NOT(domain)');domain=a.arg(0);self.assertTrue(z3.is_or(domain));values=set()
  for term in domain.children():
   self.assertTrue(z3.is_eq(term));left,right=[z3.simplify(x)for x in term.children()];value=right if z3.is_int_value(right)else left;self.assertTrue(z3.is_int_value(value));values.add(value.as_long())
  self.assertEqual(values,{-2,-1,0})
 def test_conflict_leaf_is_standalone_stronger_obligation(self):
  m=self.model();duplicate=copy.deepcopy(m['transitions'][0]);duplicate['id']='DUPLICATE-GUARD-UNIT-PROBE';m['transitions'].append(duplicate);p=render_plan(m);rows=p['overlap'];rows=rows['queries']if isinstance(rows,dict)else rows;self.assertTrue(rows)
  for row in rows:self.assertEqual(len(z3.parse_smt2_string(row['smt2'])),1,'Standalone conflict leaf must not reintroduce original step relation')
