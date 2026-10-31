"""Untrusted raw candidates still need complete fixed-checker evidence."""
import contextlib,hashlib,importlib.util,io,json,shutil,sys,tarfile,tempfile,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import query_certificates as q
import tactic_recheck as t
spec=importlib.util.spec_from_file_location('finite_proposer',ROOT/'tools/propose_finite_certificate.py')
proposer=importlib.util.module_from_spec(spec);spec.loader.exec_module(proposer)
c=q.c
SOURCE='(declare-const x Int)(declare-const y Int)(assert (<= 0 x))(assert (< x 2))(assert (= y (+ x 1)))(assert (not (> y x)))(check-sat)'
RECIPE=dict(variable='x',values=[0,1],bounds=[dict(assertion=0,path=[]),dict(assertion=1,path=[])],target=3)


class FiniteProposalTests(unittest.TestCase):
    def prepare(self,tmp,text=SOURCE):
        root=Path(tmp);source=root/'source.smt2';source.write_text(text)
        with contextlib.redirect_stdout(io.StringIO()):report=proposer.produce(source,root/'certificate',RECIPE)
        return root/'certificate',report

    def test_raw_routes_are_candidates_until_fixed_independent_acceptance(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert,report=self.prepare(tmp)
            self.assertEqual(report['status'],'native_routes_complete_unverified')
            self.assertFalse(report['independent_certificate_verification_run'])
            finite=cert/'proof/finite';old=json.loads((finite/'result.json').read_text())
            self.assertEqual(old['status'],'local_equivalence_unknown')
            self.assertTrue(all(row['equivalence']['reason'].startswith('default strategy not run')for row in old['cases']))
            checked=q.verify(cert,c.sha(cert/'source.smt2'))
            self.assertEqual(checked['status'],'verified_standalone_query_unsat')
            self.assertEqual(len(checked['details']['alternatives']),4)
            self.assertEqual(json.loads((finite/'result.json').read_text()),old)

    def test_rehashed_wrong_candidate_and_forged_positive_route_are_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert,_=self.prepare(tmp);proof=cert/'proof';finite=proof/'finite';case=finite/'case-00'
            terms=c.read_query(finite/'source.smt2');guard=c.z3.Int('x')==0;wrong=c.z3.Int('y')==17
            (case/'query.smt2').write_text(c.script(terms+[guard,wrong]))
            (case/'equivalence.smt2').write_text(c.script([guard,c.z3.Xor(c.z3.And(*terms),wrong)]))
            methods=json.loads((proof/'proof-methods.json').read_text())
            for kind,key,file in [('equivalence','equivalence_method','equivalence.smt2'),('query','method','query.smt2')]:
                directory=proof/f'{kind}-tactic-00';shutil.rmtree(directory)
                result=t.produce(case/file,directory)
                if kind=='equivalence':
                    self.assertEqual(result['query'],'sat')
                    result['query']='unsat';result['status']='exact_query_tactic_unsat';c.write(directory/'result.json',result)
                methods[0][key+'_source_sha256']=c.sha(case/file)
            c.write(proof/'proof-methods.json',methods)
            record=json.loads((finite/'result.json').read_text())
            record['files']={str(p.relative_to(finite)):c.sha(p)for p in finite.rglob('*')if p.is_file()and p.name!='result.json'and not p.name.endswith('.independent.log')}
            c.write(finite/'result.json',record)
            with self.assertRaisesRegex(ValueError,'Fresh CLI did not prove'):
                q.verify(cert,c.sha(cert/'source.smt2'))

    def test_shared_real_query_serialization_is_accepted_by_fixed_shape_checks(self):
        # This real shared conjunction exposed a mismatch between the pre-export
        # proposal AST and the object read by the existing independent checker.
        archive=ROOT/'artifacts/sent-ledger-single-target-unknown'
        manifest=json.loads((archive/'members.json').read_text())
        with tarfile.open(archive/'exact-single-disjunct-attempt.tar.gz')as stream:
            data=stream.extractfile('group-295.smt2').read()
        self.assertEqual(hashlib.sha256(data).hexdigest(),manifest['group-295.smt2'])
        with tempfile.TemporaryDirectory()as tmp:
            source=Path(tmp)/'source.smt2';source.write_bytes(data);terms=c.read_query(source)
            out=Path(tmp)/'case';variable=c.z3.Int('v_0_cb_head')
            proposer.write_case(terms,variable,0,out)
            proposal=c.read_query(out/'query.smt2')[-1]
            c.check_terms(out/'query.smt2',terms+[variable==0,proposal])
            c.check_terms(out/'equivalence.smt2',[variable==0,c.z3.Xor(c.z3.And(*terms),proposal)])

    def test_satisfiable_source_cannot_be_promoted_by_generator_report(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert,report=self.prepare(tmp,SOURCE.replace('(not (> y x))','(> y 1)'))
            self.assertEqual(report['status'],'native_routes_incomplete')
            report['status']='native_routes_complete_unverified';c.write(cert/'proposal-result.json',report)
            with self.assertRaisesRegex(ValueError,'No passing exact tactic result'):
                q.verify(cert,c.sha(cert/'source.smt2'))


if __name__=='__main__':unittest.main()
