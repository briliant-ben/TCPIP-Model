"""Universal equality, exact instantiation and nonvacuous query controls."""
import json
from pathlib import Path
import sys
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import modular_normalization as n

SOURCE='''(declare-const x Int)
(declare-const y Int)
(assert (not (= (mod (+ x (mod (- y x) 4294967296)) 4294967296) (mod y 4294967296))))
(check-sat)
'''


class ModularNormalizationTests(unittest.TestCase):
    def prepare(self,tmp,text=SOURCE):
        source=Path(tmp)/'original.smt2';source.write_text(text);out=Path(tmp)/'proof'
        result=n.produce(source,out);return source,out,result

    def test_cumulative_sequence_cancellation_is_unconditionally_certified(self):
        with tempfile.TemporaryDirectory()as tmp:
            source,out,r=self.prepare(tmp)
            self.assertGreater(r['rewrite_count'],0)
            verified=n.verify(out);self.assertEqual(verified['status'],'valid_exact_modular_normalization')
            self.assertEqual(n.cli(source,Path(tmp)/'original.log')['query'],'unsat')
            self.assertEqual(n.cli(out/'normalized.smt2',Path(tmp)/'normalized.log')['query'],'unsat')

    def test_different_moduli_nonlinear_atoms_and_placeholder_name_collision(self):
        cases=[
            '(declare-const x Int)(declare-const y Int)(assert (= x 18))(assert (= y 0))(assert (= (mod (+ (mod x 17) y) 19) 1))(check-sat)',
            '(declare-const x Int)(declare-const y Int)(assert (= x 3))(assert (= y 4))(assert (= (mod (+ (* x y) (mod (- y x) 17)) 17) 13))(check-sat)',
            '(declare-const atom_0 Int)(declare-const y Int)(assert (= atom_0 4294967297))(assert (= y (- 1)))(assert (= (mod (+ atom_0 (mod (- y atom_0) 4294967296)) 4294967296) 4294967295))(check-sat)']
        for text in cases:
            with self.subTest(text=text),tempfile.TemporaryDirectory()as tmp:
                source,out,_=self.prepare(tmp,text);n.verify(out)
                self.assertEqual(n.cli(source,Path(tmp)/'a.log')['query'],'sat')
                self.assertEqual(n.cli(out/'normalized.smt2',Path(tmp)/'b.log')['query'],'sat')

    def test_rehashed_false_equality_or_hidden_premise_is_rejected(self):
        for premise in (False,True):
            with self.subTest(premise=premise),tempfile.TemporaryDirectory()as tmp:
                _,out,r=self.prepare(tmp);proof=out/r['proofs'][0]['file']
                proof.write_text('(assert (not (= 0 1)))\n'+('(assert false)\n'if premise else'')+'(check-sat)\n')
                r['proofs'][0]['sha256']=n.sha(proof);n.write(out/'result.json',r)
                with self.assertRaisesRegex(ValueError,'one unconditional|independently pass'):
                    n.verify(out)

    def test_rehashed_wrong_instantiation_and_omitted_assertion_are_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            _,out,r=self.prepare(tmp)
            row=next(row for row in r['rewrites']if len(row['atom_paths'])==2)
            row['atom_paths'][0],row['atom_paths'][1]=row['atom_paths'][1],row['atom_paths'][0]
            n.write(out/'result.json',r)
            with self.assertRaisesRegex(ValueError,'instantiate to source subtree'):n.verify(out)
        with tempfile.TemporaryDirectory()as tmp:
            _,out,r=self.prepare(tmp)
            (out/'normalized.smt2').write_text('(assert false)\n(check-sat)\n')
            r['normalized_sha256']=n.sha(out/'normalized.smt2');n.write(out/'result.json',r)
            with self.assertRaisesRegex(ValueError,'omits or changes'):n.verify(out)

    def test_unsupported_moduli_and_quantifiers_are_explicitly_rejected(self):
        texts=['(declare-const x Int)(assert (= (mod x 0) 0))(check-sat)',
            '(declare-const x Int)(assert (= (mod x (- 17)) 0))(check-sat)',
            '(declare-const x Int)(declare-const m Int)(assert (= (mod x m) 0))(check-sat)',
            '(assert (forall ((x Int)) (= (mod x 17) 0)))(check-sat)']
        for text in texts:
            with self.subTest(text=text),tempfile.TemporaryDirectory()as tmp:
                with self.assertRaisesRegex(ValueError,'unsupported|Unsupported'):
                    self.prepare(tmp,text)


if __name__=='__main__':unittest.main()
