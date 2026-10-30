"""Exact assertion correspondence and fresh CLI rejection controls."""
import json
from pathlib import Path
import sys
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import tactic_recheck as checker


class TacticRecheckTests(unittest.TestCase):
    def fixture(self,tmp,sat=False):
        path=Path(tmp)/'source.smt2'
        path.write_text('(declare-const x Int)\n(assert (= x 1))\n(assert '+('(>= x 0)'if sat else'(= x 2)')+')\n(check-sat)\n')
        return path

    def test_original_conjunction_passes_in_two_fresh_cli_runs(self):
        with tempfile.TemporaryDirectory()as tmp:
            source=self.fixture(tmp);out=Path(tmp)/'out';r=checker.produce(source,out)
            self.assertEqual(r['status'],'exact_query_tactic_unsat')
            self.assertEqual(checker.verify(out)['assertions'],2)

    def test_rehashed_omitted_premise_and_changed_budget_are_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            source=self.fixture(tmp);out=Path(tmp)/'out';checker.produce(source,out)
            query=out/'query.smt2';original=query.read_text()
            query.write_text(original.replace('(assert\n (= x 2))\n',''))
            self.assertNotEqual(query.read_text(),original)
            r=json.loads((out/'result.json').read_text());r['script_sha256']=checker.digest(query)
            (out/'result.json').write_text(json.dumps(r))
            with self.assertRaisesRegex(ValueError,'Original assertion changed or omitted'):checker.verify(out)
            query.write_text(original.replace('10000','10001'))
            with self.assertRaisesRegex(ValueError,'Strategy or budget changed'):checker.check_script(source,query)

    def test_rehashed_false_unsat_claim_requires_fresh_cli(self):
        with tempfile.TemporaryDirectory()as tmp:
            source=self.fixture(tmp,sat=True);out=Path(tmp)/'out';r=checker.produce(source,out)
            self.assertEqual(r['query'],'sat');r['query']='unsat';r['status']='exact_query_tactic_unsat'
            (out/'result.json').write_text(json.dumps(r))
            with self.assertRaisesRegex(ValueError,'Fresh CLI did not prove'):checker.verify(out)

    def test_incremental_options_and_multiple_checks_are_explicitly_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            p=Path(tmp)/'bad.smt2'
            for extra in ('(push 1)','(set-option :timeout 999999)','(check-sat)'):
                p.write_text('(declare-const x Int)\n(assert (= x 1))\n'+extra+'\n(check-sat)\n')
                with self.assertRaisesRegex(ValueError,'Unsupported'):checker.read_query(p)


if __name__=='__main__':unittest.main()
