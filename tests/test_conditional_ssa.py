"""Finite exact-query certificates: missing branches and false lemmas fail closed."""
import json
from pathlib import Path
import sys
import tempfile
import unittest

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import conditional_ssa as c

SOURCE='''(declare-const a Int)(declare-const b Bool)(declare-const next Int)
(assert (= next (ite b (+ a 1) a)))
(assert (not (= next (ite b (+ a 1) a))))
(check-sat)
'''


class ConditionalSSATests(unittest.TestCase):
    def prepare(self, tmp, text=SOURCE):
        source=Path(tmp)/'source.smt2';source.write_text(text)
        recipe=c.recipe_for(source,['next'],['next'])
        out=Path(tmp)/'evidence'
        return source,out,c.produce(source,out,recipe)

    def rehash(self,out,result):
        result['files']={str(p.relative_to(out)):c.sha(p) for p in sorted(out.rglob('*'))
                         if p.is_file() and p.name!='result.json' and not p.name.endswith('.independent.log')}
        c.write(out/'result.json',result)

    def test_all_cases_and_nonvacuous_context_independently_pass(self):
        with tempfile.TemporaryDirectory()as tmp:
            source,out,r=self.prepare(tmp)
            self.assertEqual(r['status'],'exact_query_unsat_nonvacuous')
            self.assertEqual(c.verify(out,source)['fresh_status'],r['status'])
            self.assertEqual(len(r['cases']),2)

    def test_real_wrong_update_is_sat_not_reachability_claim(self):
        wrong=SOURCE.replace('(ite b (+ a 1) a)', '(ite b (+ a 2) a)',1)
        with tempfile.TemporaryDirectory()as tmp:
            source,out,r=self.prepare(tmp,wrong)
            self.assertEqual(r['status'],'sat_not_reachability_proof')
            self.assertEqual(len(c.read_query(out/'case-01/query.smt2')),4)
            self.assertTrue(c.z3.is_true(c.read_query(out/'case-01/query.smt2')[-1]))
            self.assertEqual(c.verify(out,source)['fresh_status'],r['status'])

    def test_missing_or_duplicated_case_is_rejected_after_rehash(self):
        for duplicate in (False,True):
            with self.subTest(duplicate=duplicate),tempfile.TemporaryDirectory()as tmp:
                _,out,r=self.prepare(tmp)
                if duplicate:r['cases'][1]['bits']=r['cases'][0]['bits']
                else:r['cases'].pop()
                c.write(out/'result.json',r)
                with self.assertRaisesRegex(ValueError,'Boolean case'):c.verify(out)

    def test_omitted_original_assertion_and_hidden_premise_rejected_after_rehash(self):
        for file in ('query.smt2','equivalence.smt2'):
            with self.subTest(file=file),tempfile.TemporaryDirectory()as tmp:
                _,out,r=self.prepare(tmp)
                p=out/'case-00'/file
                terms=c.read_query(p)
                p.write_text(c.script(terms[1:] if file=='query.smt2' else terms+[c.z3.BoolVal(False)]))
                self.rehash(out,r)
                with self.assertRaisesRegex(ValueError,'coverage or expression'):c.verify(out)

    def test_false_derived_leaf_with_matching_rehashed_local_query_is_not_proved(self):
        wrong=SOURCE.replace('(ite b (+ a 1) a)', '(ite b (+ a 2) a)',1)
        with tempfile.TemporaryDirectory()as tmp:
            _,out,r=self.prepare(tmp,wrong)
            terms=c.read_query(out/'source.smt2')
            target,defs,conditions=c.source_parts(terms,r['recipe'])
            bits,facts=list(c.cases(conditions))[1]
            directory=out/'case-01';false=c.z3.BoolVal(False)
            (directory/'query.smt2').write_text(c.script(terms+facts+[false]))
            (directory/'equivalence.smt2').write_text(c.script(defs+facts+[c.z3.Xor(terms[target],false)]))
            # Forge every producer claim, including a passing leaf log. The
            # independently rebuilt local theorem still finds the false lemma.
            (directory/'query.log').write_text('unsat\n')
            (directory/'equivalence.log').write_text('unsat\n')
            r['cases'][1]['query']['query']='unsat'
            r['cases'][1]['equivalence']['query']='unsat'
            r['status']='exact_query_unsat_nonvacuous'
            self.rehash(out,r)
            with self.assertRaisesRegex(ValueError,'UNSAT not reproduced'):c.verify(out)

    def test_nonconjunctive_definition_and_quantifier_explicitly_rejected(self):
        texts=[SOURCE.replace('(assert (= next (ite b (+ a 1) a)))','(assert (or b (= next (ite b (+ a 1) a))))'),
               SOURCE.replace('(assert (not', '(assert (forall ((q Int)) (= q q)))(assert (not')]
        for text in texts:
            with self.subTest(text=text),tempfile.TemporaryDirectory()as tmp:
                with self.assertRaisesRegex(ValueError,'definition not in source|Quantifiers'):
                    self.prepare(tmp,text)

    def test_inconsistent_context_is_explicitly_vacuous_and_expected_source_bound(self):
        with tempfile.TemporaryDirectory()as tmp:
            source,out,r=self.prepare(tmp,SOURCE.replace('(check-sat)','(assert false)(check-sat)'))
            self.assertEqual(r['status'],'exact_query_unsat_vacuous_context')
            c.verify(out,source)
            source.write_text(SOURCE)
            with self.assertRaisesRegex(ValueError,'expected original'):c.verify(out,source)


if __name__=='__main__':unittest.main()
