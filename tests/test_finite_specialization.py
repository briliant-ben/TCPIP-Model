"""Source-domain coverage and unconstrained local specialization controls."""
from pathlib import Path
import sys,tempfile,unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import finite_specialization as f

SOURCE='''(declare-const x Int)(declare-const next Int)
(assert (<= 0 x))(assert (< x 3))
(assert (= next (+ x 1)))(assert (not (>= next x)))(check-sat)'''
RECIPE=dict(variable='x',values=[0,1,2],target=3,
            bounds=[dict(assertion=0,path=[]),dict(assertion=1,path=[])])


class FiniteSpecializationTests(unittest.TestCase):
    def prepare(self,tmp,text=SOURCE,recipe=None):
        source=Path(tmp)/'source.smt2';source.write_text(text);out=Path(tmp)/'proof'
        return source,out,f.produce(source,out,recipe or RECIPE)

    def test_complete_source_domain_and_wrong_update(self):
        for wrong in (False,True):
            with self.subTest(wrong=wrong),tempfile.TemporaryDirectory()as tmp:
                text=SOURCE.replace('(+ x 1)','(- x 1)')if wrong else SOURCE
                source,out,r=self.prepare(tmp,text)
                expected='sat_not_reachability_proof'if wrong else'exact_finite_query_unsat_nonvacuous'
                self.assertEqual(r['status'],expected)
                self.assertEqual(f.verify(out,source)['fresh_status'],expected)

    def test_incomplete_domain_rejected_without_violating_target_as_premise(self):
        with tempfile.TemporaryDirectory()as tmp:
            with self.assertRaisesRegex(ValueError,'coverage not established: sat'):
                self.prepare(tmp,recipe=dict(RECIPE,values=[0,1]))
        with tempfile.TemporaryDirectory()as tmp:
            with self.assertRaisesRegex(ValueError,'must not use violation'):
                self.prepare(tmp,recipe=dict(RECIPE,bounds=[dict(assertion=3,path=[])]))

    def test_rehashed_missing_case_or_omitted_assertion_rejected(self):
        for missing in (False,True):
            with self.subTest(missing=missing),tempfile.TemporaryDirectory()as tmp:
                _,out,r=self.prepare(tmp)
                if missing:r['cases'].pop()
                else:
                    q=out/'case-00/query.smt2';q.write_text('(assert false)(check-sat)')
                    r['files']['case-00/query.smt2']=f.c.sha(q)
                f.c.write(out/'result.json',r)
                with self.assertRaisesRegex(ValueError,'Missing/duplicated|coverage or expression'):
                    f.verify(out)

    def test_forged_false_leaf_and_matching_rehashed_local_claim_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            _,out,r=self.prepare(tmp,SOURCE.replace('(+ x 1)','(- x 1)'))
            terms=f.c.read_query(out/'source.smt2');variable,values,bounds,target=f.parts(terms,r['recipe'])
            directory=out/'case-00';guard=variable==0;false=f.z3.BoolVal(False)
            (directory/'query.smt2').write_text(f.c.script(terms+[guard,false]))
            (directory/'equivalence.smt2').write_text(f.c.script([guard,f.z3.Xor(f.z3.And(*terms),false)]))
            for name in ('query.log','equivalence.log'):(directory/name).write_text('unsat\n')
            for name in ('query','equivalence'):r['cases'][0][name]['query']='unsat'
            r['files']={str(p.relative_to(out)):f.c.sha(p)for p in sorted(out.rglob('*'))if p.is_file()and p.name!='result.json'}
            f.c.write(out/'result.json',r)
            with self.assertRaisesRegex(ValueError,'UNSAT not independently reproduced'):f.verify(out)

    def test_nonconjunctive_bounds_and_noninteger_selector_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            text=SOURCE.replace('(assert (<= 0 x))','(assert (or (<= 0 x) (> x 100)))')
            recipe=dict(RECIPE,bounds=[dict(assertion=0,path=[0]),dict(assertion=1,path=[])])
            with self.assertRaisesRegex(ValueError,'positive source conjunct'):self.prepare(tmp,text,recipe)
        with tempfile.TemporaryDirectory()as tmp:
            with self.assertRaisesRegex(ValueError,'source integer'):
                self.prepare(tmp,recipe=dict(RECIPE,variable='missing'))


if __name__=='__main__':unittest.main()
