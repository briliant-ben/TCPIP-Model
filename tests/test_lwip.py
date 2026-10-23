"""Run actual pinned upstream C code; no Linux privileges or external network used."""
from pathlib import Path
import shutil
import tempfile
import unittest

from protocol_lab.flow import ROOT, build, read
from protocol_lab.ir import ModelError
from protocol_lab.lwip import run_lwip, sources, verify_lwip


@unittest.skipUnless(shutil.which("cc") and (ROOT/"third_party/lwip/src/core/tcp.c").exists(), "optional pinned lwIP sources and C compiler required")
class LwipTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory()
        cls.addClassCleanup(cls.temp.cleanup)
        cls.artifacts = Path(cls.temp.name)/"artifacts"
        build(cls.artifacts)
        cls.report = run_lwip(cls.artifacts)

    def test_upstream_inputs_are_pinned(self):
        manifest, base = sources()
        self.assertEqual(manifest["commit"], "77dcd25a72509eb83f72b033d219b1d40cd8eb95")
        self.assertIn("COPYING",manifest["files"])
        self.assertGreater(len(manifest["files"]),100)

    def test_real_handshake_matches_projection(self):
        row = next(r for r in self.report["scenarios"] if r["scenario"] == "handshake")
        self.assertEqual(row["execution"], "pass")
        self.assertEqual(row["summary"]["connected"],1)
        self.assertEqual(row["comparison"],"match")
        packets = read(self.artifacts/"lwip/handshake/packets.json")
        self.assertEqual([p["flags"] for p in packets],["S","SA","A"])
        self.assertEqual([p["time_ms"] for p in packets],[0,10,10])

    def test_real_loss_run_preserves_rto_profile_difference(self):
        row = next(r for r in self.report["scenarios"] if r["scenario"] == "syn-loss")
        self.assertEqual(row["execution"],"pass")
        self.assertEqual(row["summary"]["connected"],1)
        self.assertEqual(row["summary"]["syn_count"],2)
        self.assertGreater(row["summary"]["first_retransmit_ms"],1000)
        self.assertEqual(row["comparison"],"mismatch")
        differences = read(self.artifacts/"lwip/syn-loss/difference.json")["differences"]
        self.assertTrue(any(d.get("field")=="time_ms" for d in differences))
        self.assertFalse(self.report["full_stack_validated"])

    def test_execution_evidence_verifies_and_rejects_tampering(self):
        self.assertEqual(verify_lwip(self.artifacts)["status"],"valid_execution_evidence")
        path = self.artifacts/"lwip/handshake/capture.pcap"
        original = path.read_bytes()
        try:
            path.write_bytes(original[:-1])
            with self.assertRaisesRegex(ModelError,"evidence changed"):
                verify_lwip(self.artifacts)
        finally:
            path.write_bytes(original)
