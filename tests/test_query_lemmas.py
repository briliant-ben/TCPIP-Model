"""Dependency replay, exact context and cut direction must all be checked."""
import contextlib,io,json
from unittest import mock
from pathlib import Path
import shutil,sys,tempfile,unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import query_lemmas as g
import query_certificates as q
import tactic_recheck as t

CONTEXT='(declare-const x Int)(declare-const y Int)(assert (>= x 0))(assert (= y (+ x 1)))'
DEPENDENCY=CONTEXT+'(assert (not (>= y 1)))(check-sat)'
TARGET=CONTEXT+'(assert (not (> y x)))(check-sat)'


class QueryLemmaTests(unittest.TestCase):
    def certificate(self,root,text=DEPENDENCY):
        root.mkdir();source=root/'source.smt2';source.write_text(text)
        t.produce(source,root/'proof')
        g.c.write(root/'certificate.json',dict(format=q.FORMAT,kind='tactic',source='source.smt2',proof='proof'))
        return root

    def prepare(self,tmp,text=DEPENDENCY,target_text=TARGET):
        root=Path(tmp);cert=self.certificate(root/'input',text);target=root/'target.smt2';target.write_text(target_text)
        out=root/'graph'
        with contextlib.redirect_stdout(io.StringIO()):result=g.produce({'target':target},{'parent':cert},out)
        return out,result

    def rehash(self,out,result):
        result['files']={str(p.relative_to(out)):g.c.sha(p)for p in sorted(out.rglob('*'))if p.is_file()and p!=out/'result.json'}
        g.c.write(out/'result.json',result)

    def test_checked_parent_and_target_keep_original_evidence_immutable(self):
        with tempfile.TemporaryDirectory()as tmp:
            out,r=self.prepare(tmp);before=dict(r['files'])
            self.assertEqual(r['status'],'original_queries_unsat_nonvacuous')
            with contextlib.redirect_stdout(io.StringIO()):v=g.verify(out,Path(tmp)/'verification')
            self.assertEqual(v['targets'][0]['query']['query'],'unsat')
            self.assertEqual(before,{str(p.relative_to(out)):g.c.sha(p)for p in out.rglob('*')if p.is_file()and p!=out/'result.json'})

    def test_inconsistent_shared_context_is_explicitly_vacuous(self):
        with tempfile.TemporaryDirectory()as tmp:
            bad_context=CONTEXT+'(assert false)'
            out,r=self.prepare(tmp,bad_context+'(assert (not (>= y 1)))(check-sat)',bad_context+'(assert (not (> y x)))(check-sat)')
            self.assertEqual(r['status'],'original_queries_unsat_vacuous_context')
            with contextlib.redirect_stdout(io.StringIO()):verified=g.verify(out,Path(tmp)/'verification')
            self.assertEqual(verified['context']['query'],'unsat')

    def test_changed_context_or_self_conclusion_is_not_admitted(self):
        for text,error in ((DEPENDENCY.replace('(>= x 0)','(> x 0)'),'entire exact source context'),
                           (TARGET,'Circular/self dependency conclusion')):
            with self.subTest(text=text),tempfile.TemporaryDirectory()as tmp:
                with self.assertRaisesRegex(ValueError,error):self.prepare(tmp,text)

    def test_satisfiable_dependency_cannot_be_promoted_by_metadata(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);cert=self.certificate(root/'input',CONTEXT+'(assert (> y 1))(check-sat)')
            r=json.loads((cert/'proof/result.json').read_text());r['status']='exact_query_tactic_unsat';r['query']='unsat'
            g.c.write(cert/'proof/result.json',r)
            with self.assertRaisesRegex(ValueError,'Fresh CLI did not prove'):
                q.verify(cert,g.c.sha(cert/'source.smt2'))

    def test_rehashed_wrong_lemma_direction_or_omitted_original_rejected(self):
        for wrong_direction in (False,True):
            with self.subTest(wrong_direction=wrong_direction),tempfile.TemporaryDirectory()as tmp:
                out,r=self.prepare(tmp);path=out/'targets/target/augmented.smt2';terms=g.c.read_query(path)
                if wrong_direction:terms[-1]=g.c.z3.Not(terms[-1])
                else:terms.pop(0)
                path.write_text(g.c.script(terms));self.rehash(out,r)
                with contextlib.redirect_stdout(io.StringIO()),self.assertRaisesRegex(ValueError,'coverage or expression'):
                    g.verify(out,Path(tmp)/'verify')

    def test_rehashed_changed_composition_schema_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            out,r=self.prepare(tmp);(out/'composition.smt2').write_text('(assert false)(check-sat)');self.rehash(out,r)
            with contextlib.redirect_stdout(io.StringIO()),self.assertRaisesRegex(ValueError,'coverage or expression'):
                g.verify(out,Path(tmp)/'verify')

    def test_no_certificate_supplied_code_and_expected_source_binding(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert=self.certificate(Path(tmp)/'input')
            with self.assertRaisesRegex(ValueError,'expected original query'):q.verify(cert,'0'*64)
            r=json.loads((cert/'certificate.json').read_text());r['kind']='python-checker'
            g.c.write(cert/'certificate.json',r)
            with self.assertRaisesRegex(ValueError,'no custom checker execution'):q.verify(cert,g.c.sha(cert/'source.smt2'))

    def test_scoped_claims_and_separate_verification_directory_enforced(self):
        with tempfile.TemporaryDirectory()as tmp:
            out,r=self.prepare(tmp)
            with self.assertRaisesRegex(ValueError,'cannot modify original'):g.verify(out,out/'new-verification')
            r['whole_protocol_proved']=True;g.c.write(out/'result.json',r)
            with self.assertRaisesRegex(ValueError,'Scope'):g.verify(out,Path(tmp)/'verification')

    def reused(self,root,out):
        root.mkdir();shutil.copytree(out,root/'proof')
        (root/'source.smt2').write_bytes((out/'targets/target/original.smt2').read_bytes())
        g.c.write(root/'certificate.json',dict(format=q.FORMAT,kind='reuse',source='source.smt2',proof='proof',target='target'))
        return root

    def test_verified_proof_can_be_reused_at_the_next_acyclic_level(self):
        with tempfile.TemporaryDirectory()as tmp:
            out,_=self.prepare(tmp);cert=self.reused(Path(tmp)/'reused',out)
            next_target=Path(tmp)/'next.smt2';next_target.write_text(CONTEXT+'(assert (not (>= y x)))(check-sat)')
            with contextlib.redirect_stdout(io.StringIO()):
                r=g.produce({'next':next_target},{'proved_target':cert},Path(tmp)/'second-level')
                v=g.verify(Path(tmp)/'second-level',Path(tmp)/'fresh-second-level')
            self.assertEqual(r['status'],'original_queries_unsat_nonvacuous')
            self.assertEqual(v['targets'][0]['query']['query'],'unsat')
            second=Path(tmp)/'second-level'
            self.assertEqual(r['files'],{str(path.relative_to(second)):g.c.sha(path)for path in second.rglob('*')if path.is_file()and path!=second/'result.json'})

    def test_recursive_query_dependency_cycle_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            out,_=self.prepare(tmp);cert=self.reused(Path(tmp)/'reused',out)
            prior=Path(tmp)/'prior.smt2';prior.write_text(DEPENDENCY+'\n; changed serialization must not conceal a cycle\n')
            with contextlib.redirect_stdout(io.StringIO()),self.assertRaisesRegex(ValueError,'Cyclic/circular'):
                g.produce({'prior':prior},{'reused_target':cert},Path(tmp)/'cyclic')

    def test_session_reuses_only_actual_verified_results_and_new_session_rechecks(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert=self.certificate(Path(tmp)/'input');sha=g.c.sha(cert/'source.smt2')
            session=q.VerificationSession()
            with mock.patch.object(t,'verify',wraps=t.verify)as checker:
                first=q.verify(cert,sha,_session=session)
                second=q.verify(cert,sha,_session=session)
                fresh=q.verify(cert,sha,_session=q.VerificationSession())
            self.assertEqual(checker.call_count,2)
            self.assertFalse(first['cached_verification']);self.assertTrue(second['cached_verification'])
            self.assertFalse(fresh['cached_verification'])
            self.assertNotEqual(first['verification_session_id'],fresh['verification_session_id'])
            second['proof_query_fingerprints'].clear()
            self.assertTrue(q.verify(cert,sha,_session=session)['proof_query_fingerprints'])

    def test_warm_cache_does_not_hide_rehashed_false_proof_with_same_source(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert=self.certificate(Path(tmp)/'input');sha=g.c.sha(cert/'source.smt2')
            session=q.VerificationSession();q.verify(cert,sha,_session=session)
            (cert/'proof/query.smt2').write_text('(assert false)(check-sat)')
            r=json.loads((cert/'proof/result.json').read_text())
            # Rehash every existing SHA reference to the modified file: a file
            # integrity label alone must not turn this different proof into a hit.
            r['script_sha256']=g.c.sha(cert/'proof/query.smt2')
            old=r['files'] if 'files'in r else {}
            for name in old:
                if (cert/'proof'/name).is_file():old[name]=g.c.sha(cert/'proof'/name)
            g.c.write(cert/'proof/result.json',r)
            with self.assertRaises(ValueError):q.verify(cert,sha,_session=session)
            self.assertEqual(session.hits,0)

    def test_checker_epoch_change_forces_fresh_verification(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert=self.certificate(Path(tmp)/'input');sha=g.c.sha(cert/'source.smt2')
            session=q.VerificationSession();q.verify(cert,sha,_session=session)
            with mock.patch.object(q,'checker_epoch',return_value='new-checker-epoch'),mock.patch.object(t,'verify',wraps=t.verify)as checker:
                result=q.verify(cert,sha,_session=session)
            self.assertEqual(checker.call_count,1);self.assertFalse(result['cached_verification'])
            self.assertEqual(session.fresh,2)

    def test_certificate_cannot_inject_persisted_cache_metadata(self):
        with tempfile.TemporaryDirectory()as tmp:
            cert=self.certificate(Path(tmp)/'input');sha=g.c.sha(cert/'source.smt2')
            session=q.VerificationSession();q.verify(cert,sha,_session=session)
            record=json.loads((cert/'certificate.json').read_text())
            record['cached_verification']=True;g.c.write(cert/'certificate.json',record)
            with self.assertRaisesRegex(ValueError,'schema'):q.verify(cert,sha,_session=session)
            self.assertEqual(session.hits,0)

    def test_dag_duplicate_parent_reuses_session_but_independent_replay_starts_empty(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);cert=self.certificate(root/'input');target=root/'target.smt2';target.write_text(TARGET)
            q.verify(cert,g.c.sha(cert/'source.smt2'))  # identical complete trees, including prior logs
            with contextlib.redirect_stdout(io.StringIO()):
                r=g.produce({'target':target},{'one':cert,'two':cert},root/'graph')
                v=g.verify(root/'graph',root/'verification')
            for result in (r,v):
                self.assertEqual(result['proof_cache']['fresh_certificates'],1)
                self.assertEqual(result['proof_cache']['cache_hits'],1)
                self.assertFalse(result['proof_cache']['loaded_from_artifacts'])
            self.assertNotEqual(r['proof_cache']['session_id'],v['proof_cache']['session_id'])

    def test_warm_nested_cache_cannot_hide_transitive_canonical_cycle(self):
        with tempfile.TemporaryDirectory()as tmp:
            out,_=self.prepare(tmp);cert=self.reused(Path(tmp)/'reused',out)
            session=q.VerificationSession();sha=g.c.sha(cert/'source.smt2')
            with contextlib.redirect_stdout(io.StringIO()):q.verify(cert,sha,_session=session)
            prior=Path(tmp)/'prior.smt2';prior.write_text(DEPENDENCY+'\n; same query with different bytes\n')
            with self.assertRaisesRegex(ValueError,'cached proof dependency'):
                q.verify(cert,sha,active={q.fingerprint(prior)},_session=session)
            self.assertEqual(session.hits,0)

    def test_finite_certificate_requires_both_equivalence_and_leaf_route(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp)/'certificate';root.mkdir();source=root/'source.smt2'
            source.write_text('(declare-const x Int)(declare-const y Int)(assert (<= 0 x))(assert (< x 2))(assert (= y (+ x 1)))(assert (not (> y x)))(check-sat)')
            proof=root/'proof';proof.mkdir();(proof/'original.smt2').write_bytes(source.read_bytes())
            g.p.produce(source,proof/'modulo')
            recipe=dict(variable='x',values=[0,1],target=3,bounds=[dict(assertion=0,path=[]),dict(assertion=1,path=[])])
            with contextlib.redirect_stdout(io.StringIO()):q.f.produce(proof/'modulo/normalized.smt2',proof/'finite',recipe)
            methods=[dict(value=i,method='finite_default',equivalence_method='finite_default')for i in (0,1)]
            g.c.write(proof/'proof-methods.json',methods)
            g.c.write(root/'certificate.json',dict(format=q.FORMAT,kind='finite',source='source.smt2',proof='proof'))
            self.assertEqual(q.verify(root,g.c.sha(source))['status'],'verified_standalone_query_unsat')
            methods[1]['equivalence_method']='unproved';g.c.write(proof/'proof-methods.json',methods)
            with self.assertRaisesRegex(ValueError,'local-equivalence or leaf'):q.verify(root,g.c.sha(source))


if __name__=='__main__':unittest.main()
