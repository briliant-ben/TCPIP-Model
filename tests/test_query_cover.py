"""Whole-query covers require every source-shaped proof and checked schemas."""
import contextlib,copy,io,json,sys,tarfile,tempfile,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import query_cover as cover
import query_certificates as q
import tactic_recheck as t
c=cover.c


class QueryCoverTests(unittest.TestCase):
    def prepare(self,tmp,weaken=False,vacuous=False):
        root=Path(tmp);x,y=c.z3.Ints('x y')
        clauses=[x>=0,y==x+1,c.z3.Not(c.z3.And(y>x,y>=1)),x<=100]
        if vacuous:clauses[3]=x<0
        source=root/'export.smt2';source.write_text('; RULE -> DONE\n(reset)\n'+c.script(clauses))
        original=cover.p.extract(source.read_text(),'RULE -> DONE');common=original[:2]+original[3:]
        branches=cover.p.disjuncts(original[2]);inputs=root/'input';inputs.mkdir()
        for i,branch in enumerate(branches):
            cert=inputs/f'certificate-{i}';cert.mkdir();terms=list(common)
            if weaken and i==0:terms[0]=x>0
            raw=cert/'source.smt2';raw.write_text(c.script(terms+[c.z3.Or(branch)]))
            t.produce(raw,cert/'proof')
            c.write(cert/'certificate.json',dict(format=q.FORMAT,kind='tactic',source='source.smt2',proof='proof'))
        members={}
        archive=root/'bundle.tar.gz'
        with tarfile.open(archive,'w:gz')as stream:
            for path in sorted(inputs.rglob('*')):
                if path.is_file():
                    name=str(path.relative_to(inputs));members[name]=c.sha(path);stream.add(path,arcname=name,recursive=False)
        manifest=root/'members.json';c.write(manifest,members)
        plan=dict(format=cover.FORMAT,source=dict(file=str(source),sha256=c.sha(source),label='RULE -> DONE',assertion_index=2),
            bundles={'test':dict(archive=str(archive),sha256=c.sha(archive),members=str(manifest),members_sha256=c.sha(manifest))},
            proofs=[dict(kind='certificate',bundle='test',path=f'certificate-{i}',group=i)for i in range(2)])
        return root,plan

    def test_full_cover_replays_all_originals_and_preserves_nonlast_assertion_order(self):
        with tempfile.TemporaryDirectory()as tmp:
            root,plan=self.prepare(tmp);cover.stage(plan,root/'proposal')
            with contextlib.redirect_stdout(io.StringIO()):r=cover.verify(root/'proposal',root/'verification')
            self.assertEqual(r['status'],'verified_original_query_cover')
            self.assertTrue(r['whole_named_exported_query_closed']);self.assertFalse(r['whole_protocol_proved'])
            self.assertEqual(r['context']['query'],'sat');self.assertEqual([x['group']for x in r['original_groups']],[0,1])
            self.assertEqual(len(r['local_theorems']),3)

    def test_missing_or_duplicate_partition_indices_rejected(self):
        for fault in ('missing','duplicate'):
            with self.subTest(fault=fault),tempfile.TemporaryDirectory()as tmp:
                root,plan=self.prepare(tmp)
                if fault=='missing':plan['proofs'].pop()
                else:plan['proofs'][1]['group']=0
                with self.assertRaisesRegex(ValueError,'every original group exactly once'):cover.stage(plan,root/'proposal')

    def test_narrower_source_context_cannot_supply_a_parent(self):
        with tempfile.TemporaryDirectory()as tmp:
            root,plan=self.prepare(tmp,weaken=True);cover.stage(plan,root/'proposal')
            with self.assertRaisesRegex(ValueError,'entire ordered original context'):cover.verify(root/'proposal',root/'verification')

    def test_rehashed_false_composition_and_promoted_scope_rejected(self):
        for fault in ('composition','scope'):
            with self.subTest(fault=fault),tempfile.TemporaryDirectory()as tmp:
                root,plan=self.prepare(tmp);out=root/'proposal';r=cover.stage(plan,out)
                if fault=='composition':
                    (out/'composition.smt2').write_text('(assert false)(check-sat)')
                    r['files']['composition.smt2']=c.sha(out/'composition.smt2')
                else:r['whole_protocol_proved']=True
                c.write(out/'result.json',r)
                with self.assertRaisesRegex(ValueError,'coverage or expression|Scope or budget'):cover.verify(out,root/'verification')

    def test_vacuous_context_is_reported_and_not_claimed_reachable(self):
        with tempfile.TemporaryDirectory()as tmp:
            root,plan=self.prepare(tmp,vacuous=True);cover.stage(plan,root/'proposal')
            with contextlib.redirect_stdout(io.StringIO()):r=cover.verify(root/'proposal',root/'verification')
            self.assertEqual(r['context_classification'],'vacuous_context')
            self.assertEqual(r['context']['query'],'unsat');self.assertFalse(r['whole_protocol_proved'])


if __name__=='__main__':unittest.main()
