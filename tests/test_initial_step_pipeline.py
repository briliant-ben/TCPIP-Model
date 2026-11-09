"""Explicit v5 admission, real ten-stage execution and rehashed-verifier attacks."""
import contextlib
import copy
import io
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch
from protocol_lab.pipeline import runner
from protocol_lab.pipeline.task import load_task,sha,write,read
from protocol_lab.initial_step import PASS
ROOT=Path(__file__).resolve().parents[1]

class InitialStepPipeline(unittest.TestCase):
    def fixture(self, root):
        task=read(ROOT/'flows/word32-contract.json')
        names={task['model'],task['exploration'],*task['seeds'],*(s['path']for s in task['sources'])}
        for n in names:
            p=root/n;p.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/n,p)
        task['schema']='spec-flow-task-v5';task['formal']={'strategy':'initial-step-contracts','solver_timeout_ms':10000}
        path=root/'task.json';write(path,task);return path,task

    def test_explicit_admission_and_legacy_unchanged(self):
        for name in ('word32-contract','arp-udp-transmit'):
            old=load_task(ROOT/('flows/'+name+'.json'),ROOT)
            self.assertNotEqual(old['schema'],'spec-flow-task-v5')
        with tempfile.TemporaryDirectory()as d:
            root=Path(d);path,t=self.fixture(root)
            self.assertEqual(load_task(path,root),t)
            for config in ({'strategy':'wrong'},{'strategy':'initial-step-contracts','depth':1},
                           {'strategy':'initial-step-contracts','symbolic_initials':[]},
                           {'strategy':'initial-step-contracts','solver_preprocess':'none'},
                           {'strategy':'initial-step-contracts','solver_timeout_ms':True}):
                bad=copy.deepcopy(t);bad['formal']=config;write(path,bad)
                with self.assertRaises(ValueError):load_task(path,root)

    def test_real_ten_stage_flow_and_rehashed_formal_attack(self):
        with tempfile.TemporaryDirectory()as d:
            root=Path(d)/'workspace';root.mkdir();path,t=self.fixture(root);out=Path(d)/'run'
            with contextlib.redirect_stdout(io.StringIO()):r=runner.run(path,root,out,sha(path))
            self.assertEqual(r['assessment'],'verified_event_slice')
            self.assertEqual(r['stages']['formal']['data']['status'],PASS)
            self.assertEqual(runner.verify(out,root,sha(path))['assessment'],'verified_event_slice')
            # Outer flow hashes may all be recomputed; current checker must still reject changed query.
            formal=out/'stages/formal/queries';report=read(formal/'result.json');q=report['queries'][0]
            (formal/q['file']).write_text('(assert true)\n');q['sha256']=sha(formal/q['file'])
            write(formal/('receipt_'+q['id']+'.json'),q);write(formal/'result.json',report)
            stage=read(out/'stages/formal/result.json');stage['data']=report;write(out/'stages/formal/result.json',stage)
            r['stages']['formal']=stage
            r['outputs']={p.relative_to(out).as_posix():sha(p)for p in out.rglob('*')if p.is_file()and p!=out/'flow.json'}
            write(out/'flow.json',r)
            with self.assertRaisesRegex(ValueError,'Initialized formal evidence rejected'):runner.verify(out,root,sha(path))

if __name__=='__main__':unittest.main()
