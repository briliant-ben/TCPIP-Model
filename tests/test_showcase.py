"""Exercise the case-study entry points without changing protocol/evidence inputs."""
from pathlib import Path
import hashlib
import importlib.util
import json
import subprocess
import sys
import tempfile
import unittest
from html.parser import HTMLParser

ROOT=Path(__file__).resolve().parents[1]


class ShowcaseTests(unittest.TestCase):
    def test_stage_catalog_and_pinned_snapshot_are_consistent(self):
        case=json.loads((ROOT/'case-study.json').read_text())
        self.assertEqual([r['id']for r in case['stages']],['spec','model','formal','code','tests','demo'])
        for row in case['stages']:self.assertTrue((ROOT/row['path']).is_file())
        manifest=json.loads((ROOT/case['code_manifest']).read_text())
        for path,key in [(case['model'],'model_sha256'),(case['generated_code'],'C_sha256')]:self.assertEqual(hashlib.sha256((ROOT/path).read_bytes()).hexdigest(),manifest[key])
        self.assertEqual(manifest['C_sha256'],'19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b')
        self.assertEqual(manifest['framework_commit'],json.loads((ROOT/'framework.lock.json').read_text())['commit'])

    def test_actual_regenerated_C_build_and_example_match_committed_snapshot(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'actual'
            p=subprocess.run([sys.executable,str(ROOT/'code/build.py'),'--out',str(out),'--run-example'],capture_output=True,text=True)
            self.assertEqual(p.returncode,0,p.stderr+p.stdout[-3000:])
            result=json.loads(p.stdout);self.assertEqual(result['status'],'pass');self.assertEqual(result['reference_native_example'],'pass');self.assertFalse(result['new_network_execution'])
            self.assertEqual((out/'generation/protocol.c').read_bytes(),(ROOT/'code/generated/protocol.c').read_bytes())
            native=subprocess.run([str(out/'build/protocol-native')],input='B\nD 0 T.app.connect\n',text=True,capture_output=True)
            self.assertEqual(native.returncode,0,native.stderr)
            rows=[json.loads(line)for line in native.stdout.splitlines()]
            self.assertTrue(any(row.get('status')=='transition' and row['emitted']for row in rows))

    def test_English_recorded_demo_rebuilds_exactly_and_bad_archive_hash_rejects(self):
        spec=importlib.util.spec_from_file_location('showcase_demo',ROOT/'demo/build_review.py');view=importlib.util.module_from_spec(spec);spec.loader.exec_module(view)
        archive=ROOT/'artifacts/ipv4-prototype-final-9289/linux-peer-original.zip';model=ROOT/'model/ipv4-endpoint-virtual-link.json'
        digest='b47bf2a2a0f7b92c23632e2eff5c7a17cfc1d681ed5f8de84b9de02f0bfea5d6'
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'view.html';r=view.render(model,archive,digest,out)
            self.assertEqual((r['transitions'],r['packets']),(19,25));self.assertEqual(out.read_bytes(),(ROOT/'demo/review.html').read_bytes())
            text=out.read_text();self.assertIn('lang="en"',text);self.assertIn('not a new network run',text)
            class PreBlocks(HTMLParser):
                def __init__(self):super().__init__(convert_charrefs=True);self.blocks=[];self.active=False
                def handle_starttag(self,tag,attrs):
                    if tag=='pre':self.active=True;self.blocks.append('')
                def handle_endtag(self,tag):
                    if tag=='pre':self.active=False
                def handle_data(self,data):
                    if self.active:self.blocks[-1]+=data
            before,after=PreBlocks(),PreBlocks()
            before.feed((ROOT/'artifacts/ipv4-prototype-final-9289/review.html').read_text());after.feed(text)
            self.assertEqual(len(after.blocks),44)  # 19 exact IR detail blocks + 25 raw packets.
            self.assertEqual(before.blocks,after.blocks)
            with self.assertRaisesRegex(ValueError,'digest'):view.render(model,archive,'0'*64,Path(tmp)/'bad.html')
            self.assertFalse((Path(tmp)/'bad.html').exists())


if __name__=='__main__':unittest.main()
