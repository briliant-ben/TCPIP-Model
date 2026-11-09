"""Controller counterexamples and evidence-boundary tests for the qualified backend."""
import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import z3
from protocol_lab.ir import load
from protocol_lab.initial_step import check, verify, PASS, UNRESOLVED

ROOT = Path(__file__).resolve().parents[1]

class InitialStepEvidence(unittest.TestCase):
    def model(self): return load(ROOT/'model/word32-contract.json')
    def store(self, out, r): (out/'result.json').write_text(json.dumps(r))
    def receipt(self, out, r, row):
        (out/('receipt_'+row['id']+'.json')).write_text(json.dumps(row)); self.store(out,r)

    def test_interruption_keeps_all_queries_and_no_completed_report(self):
        with tempfile.TemporaryDirectory() as d:
            out=Path(d)/'run'
            with patch.object(z3.Solver, 'check', side_effect=KeyboardInterrupt):
                with self.assertRaises(KeyboardInterrupt): check(self.model(),out)
            self.assertEqual(len(list((out/'queries').glob('*.smt2'))),7)
            self.assertFalse((out/'result.json').exists())
            with self.assertRaises(ValueError): check(self.model(),out)

    def test_unknown_cannot_be_promoted_even_with_consistent_counts_and_receipts(self):
        with tempfile.TemporaryDirectory() as d:
            out=Path(d);r=check(self.model(),out);row=r['queries'][0]
            row.update(answer='unknown',reason='forced controller test')
            r['counts']['negative_answers']['unsat']-=1;r['counts']['negative_answers']['unknown']+=1
            self.receipt(out,r,row)
            self.assertEqual(verify(self.model(),out,False)['status'],'verification_failed')
            r['status']=UNRESOLVED;self.store(out,r)
            self.assertEqual(verify(self.model(),out,False)['status'],'verified_unresolved')
            self.assertEqual(verify(self.model(),out)['status'],'verification_failed')

    def test_strict_replay_recomputed_after_coherent_witness_edit(self):
        with tempfile.TemporaryDirectory() as d:
            out=Path(d);r=check(self.model(),out);row=r['queries'][-1]
            row['witness']['steps'][0]['after']['variables']['packed']=[0]
            self.receipt(out,r,row)
            self.assertEqual(verify(self.model(),out)['status'],'verification_failed')

    def test_missing_derivation_root_or_changed_policy_rejected(self):
        for mutate in ('root','policy','duplicate','depth','budget'):
            with self.subTest(mutate=mutate),tempfile.TemporaryDirectory() as d:
                out=Path(d);r=check(self.model(),out)
                if mutate=='root':(out/'queries/original_safety.smt2').write_text('(assert true)')
                elif mutate=='policy':
                    row=r['queries'][1];row['solver_policy']='plain';self.receipt(out,r,row)
                elif mutate=='duplicate':r['queries'].append(copy.deepcopy(r['queries'][0]));self.store(out,r)
                elif mutate=='depth':r['depth']=True;self.store(out,r)
                elif mutate=='budget':r['queries'][0]['timeout_ms']=101;self.receipt(out,r,r['queries'][0])
                self.assertEqual(verify(self.model(),out)['status'],'verification_failed')

    def test_unknown_from_actual_solver_exception_is_retained_not_passed(self):
        with tempfile.TemporaryDirectory() as d:
            with patch.object(z3.Solver,'check',side_effect=z3.Z3Exception('forced')):
                r=check(self.model(),Path(d))
            self.assertEqual(r['status'],UNRESOLVED)
            self.assertTrue(all(row['answer']=='unknown' for row in r['queries']))
            self.assertEqual(verify(self.model(),d,False)['status'],'verified_unresolved')

    def test_false_initial_invariant_with_normal_next_state_is_not_masked(self):
        m=self.model();m['variables']['packed']['initial']=[0]
        with tempfile.TemporaryDirectory() as d:
            r=check(m,d)
            self.assertNotEqual(r['status'],PASS)
            self.assertGreater(r['counts']['negative_answers']['sat'],0)

    def test_symlink_receipt_rejected_without_following_it(self):
        with tempfile.TemporaryDirectory() as d:
            out=Path(d)/'run';r=check(self.model(),out)
            p=out/('receipt_'+r['queries'][0]['id']+'.json');raw=p.read_text();p.unlink()
            external=Path(d)/'external';external.write_text(raw);p.symlink_to(external)
            self.assertEqual(verify(self.model(),out)['status'],'verification_failed')

if __name__=='__main__':unittest.main()
