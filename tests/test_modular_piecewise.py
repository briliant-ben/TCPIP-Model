"""Actual modulo boundaries, unbounded fallback and rehashed certificate faults."""
import json
from pathlib import Path
import sys
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import modular_piecewise as p


class ModularPiecewiseTests(unittest.TestCase):
    def prepare(self,tmp,text):
        source=Path(tmp)/'original.smt2';source.write_text(text)
        out=Path(tmp)/'proof';result=p.produce(source,out)
        return source,out,result

    def test_boundaries_and_arbitrarily_large_offsets_keep_exact_remainder(self):
        modulus=17
        for number in (-2**80,-35,-18,-17,-16,-1,0,16,17,33,34,2**80):
            for correct in (False,True):
                with self.subTest(number=number,correct=correct),tempfile.TemporaryDirectory()as tmp:
                    text=f'(declare-const x Int)(assert (= x {number}))(assert (= (mod x 17) {number%17+(0 if correct else 1)}))(assert true)(check-sat)'
                    source,out,r=self.prepare(tmp,text)
                    self.assertFalse(r['integer_domain_restricted'])
                    self.assertEqual(len(p.n.read_query(out/'normalized.smt2')),3)
                    p.verify(out,source)
                    expected='sat'if correct else'unsat'
                    self.assertEqual(p.n.cli(source,Path(tmp)/'a.log')['query'],expected)
                    self.assertEqual(p.n.cli(out/'normalized.smt2',Path(tmp)/'b.log')['query'],expected)

    def test_nested_moduli_and_placeholder_name_collision(self):
        with tempfile.TemporaryDirectory()as tmp:
            source,out,r=self.prepare(tmp,'(declare-const remainder_argument Int)(assert (= (mod (+ remainder_argument (mod remainder_argument 17)) 19) 3))(check-sat)')
            self.assertEqual(len(r['proofs']),2)
            p.verify(out,source)
            self.assertEqual(p.n.cli(out/'normalized.smt2',Path(tmp)/'answer.log')['query'],'sat')

    def test_rehashed_hidden_bound_or_false_local_identity_is_rejected(self):
        for hidden in (False,True):
            with self.subTest(hidden=hidden),tempfile.TemporaryDirectory()as tmp:
                _,out,r=self.prepare(tmp,'(declare-const x Int)(assert (= (mod x 17) 3))(check-sat)')
                row=r['proofs'][0];certificate=out/row['file']
                certificate.write_text('(assert (not (= 0 1)))'+('(assert false)'if hidden else'')+'(check-sat)')
                row['sha256']=p.n.sha(certificate);p.n.write(out/'result.json',r)
                with self.assertRaisesRegex(ValueError,'coverage or expression'):p.verify(out)

    def test_rehashed_missing_assertion_or_wrong_modulus_mapping_is_rejected(self):
        for wrong_mapping in (False,True):
            with self.subTest(wrong_mapping=wrong_mapping),tempfile.TemporaryDirectory()as tmp:
                _,out,r=self.prepare(tmp,'(declare-const x Int)(assert (= (mod x 17) 3))(assert (= (mod x 19) 5))(check-sat)')
                if wrong_mapping:
                    first,second=r['rewrites'];first['proof']=second['proof']
                else:
                    q=out/'normalized.smt2';q.write_text('(assert false)(check-sat)');r['normalized_sha256']=p.n.sha(q)
                p.n.write(out/'result.json',r)
                with self.assertRaisesRegex(ValueError,'instantiate|coverage or expression'):p.verify(out)

    def test_symbolic_nonpositive_moduli_and_quantifiers_rejected(self):
        for body in ('(= (mod x 0) 0)','(= (mod x (- 17)) 0)',
                     '(= (mod x m) 0)','(forall ((y Int)) (= (mod y 17) 0))'):
            with self.subTest(body=body),tempfile.TemporaryDirectory()as tmp:
                with self.assertRaisesRegex(ValueError,'unsupported|Unsupported'):
                    self.prepare(tmp,f'(declare-const x Int)(declare-const m Int)(assert {body})(check-sat)')

    def test_rehashed_narrowed_scope_claim_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            _,out,r=self.prepare(tmp,'(declare-const x Int)(assert (= (mod x 17) 3))(check-sat)')
            r['integer_domain_restricted']=True;p.n.write(out/'result.json',r)
            with self.assertRaisesRegex(ValueError,'domain'):p.verify(out)


if __name__=='__main__':unittest.main()
