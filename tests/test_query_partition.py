import copy
import json
from pathlib import Path
import tempfile
import unittest

from formal.partition_queries import digest, extract, partition, verify


class QueryPartitionTests(unittest.TestCase):
    def source(self,folder,context='(assert (not a))\n(assert (not b))',extra=''):
        p=Path(folder)/'source.smt2'
        p.write_text('; RULE -> STATE\n(reset)\n(declare-fun a () Bool)\n(declare-fun b () Bool)\n'+context+'\n(assert (not (and (not a) (not b))))\n'+extra+'\n(check-sat)\n')
        return p

    def test_every_disjunct_and_every_original_constraint_are_retained(self):
        with tempfile.TemporaryDirectory()as tmp:
            p=self.source(tmp);out=Path(tmp)/'proof'
            r=partition(p,'RULE -> STATE',out,-1,1)
            self.assertEqual(r['status'],'query_partition_unsat')
            self.assertEqual([g['disjunct_indices']for g in r['groups']],[[0],[1]])
            self.assertEqual(verify(out)['status'],'valid_exact_partition_queries')

    def test_satisfiable_branch_cannot_be_hidden_by_a_passing_group(self):
        with tempfile.TemporaryDirectory()as tmp:
            p=self.source(tmp,'(assert (not a))');out=Path(tmp)/'proof'
            r=partition(p,'RULE -> STATE',out,-1,1)
            self.assertEqual(r['status'],'satisfiable_query_not_reachability_proof')
            self.assertEqual([g['query']for g in r['groups']],['unsat','sat'])
            with self.assertRaisesRegex(ValueError,'No passing'):verify(out)

    def test_rehashing_a_group_that_omits_an_assertion_is_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            p=self.source(tmp);out=Path(tmp)/'proof';r=partition(p,'RULE -> STATE',out,-1,1)
            group=out/'group-000.smt2';s=group.read_text();s=s.replace('(assert\n (not b))','')
            self.assertNotEqual(s,group.read_text());group.write_text(s)
            r['query_hashes'][group.name]=digest(group.read_bytes());(out/'result.json').write_text(json.dumps(r))
            with self.assertRaisesRegex(ValueError,'original constraint'):verify(out)

    def test_missing_group_and_relabelled_unknown_are_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            p=self.source(tmp);out=Path(tmp)/'proof';r=partition(p,'RULE -> STATE',out,-1,1)
            bad=copy.deepcopy(r);bad['groups'].pop();(out/'result.json').write_text(json.dumps(bad))
            with self.assertRaisesRegex(ValueError,'coverage'):verify(out)
            bad=copy.deepcopy(r);bad['groups'][0]['query']='unknown';(out/'result.json').write_text(json.dumps(bad))
            with self.assertRaisesRegex(ValueError,'No passing'):verify(out)

    def test_unsupported_commands_labels_and_parameters_fail_explicitly(self):
        with tempfile.TemporaryDirectory()as tmp:
            for command in ('(push 1)','(pop 1)','(exit)','(check-sat-assuming (a))','(set-option :timeout 1)'):
                with self.subTest(command=command):
                    p=self.source(tmp,extra=command)
                    with self.assertRaisesRegex(ValueError,'Unsupported'):partition(p,'RULE -> STATE',Path(tmp)/'proof',-1)
            p=self.source(tmp)
            with self.assertRaisesRegex(ValueError,'labelled'):extract(p.read_text(),'missing -> STATE')
            with self.assertRaisesRegex(ValueError,'group size'):partition(p,'RULE -> STATE',Path(tmp)/'proof',-1,0)

    def test_source_tampering_and_stale_solver_binding_are_rejected(self):
        with tempfile.TemporaryDirectory()as tmp:
            p=self.source(tmp);out=Path(tmp)/'proof';r=partition(p,'RULE -> STATE',out,-1,1)
            bad=copy.deepcopy(r);bad['solver_version']='wrong';(out/'result.json').write_text(json.dumps(bad))
            with self.assertRaisesRegex(ValueError,'solver version'):verify(out)
            (out/'result.json').write_text(json.dumps(r));p.write_text(p.read_text()+'; changed\n')
            with self.assertRaisesRegex(ValueError,'source changed'):verify(out)
