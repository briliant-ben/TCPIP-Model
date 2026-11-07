import hashlib,os,runpy,subprocess,sys,tempfile,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
PORT=ROOT/"ports/linux-tcp-wire-peer"
class PreflightTests(unittest.TestCase):
 def cli(self,*args):return subprocess.run([sys.executable,str(PORT/"run.py"),*args],cwd=ROOT,capture_output=True,text=True,timeout=15)
 def snapshot(self,out):return {str(p.relative_to(out)):p.read_bytes()for p in out.rglob("*")if p.is_file()}if out.exists()else None
 def test_actual_module_and_complete_inputs_bind_original_peer_bytes(self):
  mod=runpy.run_path(str(PORT/"run.py"),run_name="source_test")
  self.assertTrue(callable(mod["inside"]));self.assertEqual(mod["PEER_SOURCE"],(PORT/"server.py").read_bytes())
  pins=mod["inputs"]();self.assertEqual(pins["ports/linux-tcp-wire-peer/server.py"],hashlib.sha256((PORT/"server.py").read_bytes()).hexdigest())
  self.assertIn("requirements-formal.txt",pins)
 def test_verify_missing_does_not_create_output(self):
  with tempfile.TemporaryDirectory()as tmp:
   out=Path(tmp)/"missing";r=self.cli("--verify","--out",str(out));self.assertNotEqual(r.returncode,0);self.assertFalse(out.exists())
 def test_verify_invalid_existing_tree_is_readonly(self):
  with tempfile.TemporaryDirectory()as tmp:
   out=Path(tmp);(out/"report.json").write_text("{}");(out/"marker").write_bytes(b"original\x00data")
   before=self.snapshot(out);r=self.cli("--verify","--out",str(out));self.assertNotEqual(r.returncode,0);self.assertEqual(self.snapshot(out),before)
 def test_inside_stale_output_rejected_before_namespace_actions(self):
  with tempfile.TemporaryDirectory()as tmp:
   out=Path(tmp);(out/"marker").write_bytes(b"original");before=self.snapshot(out)
   r=self.cli("--inside","invalid-parent","--out",str(out));self.assertNotEqual(r.returncode,0);self.assertIn("refusing nonempty inside output",r.stdout+r.stderr);self.assertEqual(self.snapshot(out),before)
