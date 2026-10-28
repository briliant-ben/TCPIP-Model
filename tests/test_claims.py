import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest

from protocol_lab.claims import build, verify
from protocol_lab.flow import ROOT, digest, read, write
from protocol_lab.ir import ModelError, load
from protocol_lab.profiles import run_profile


@unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
class ClaimTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.out = Path(self.temp.name)
        self.profile = read(ROOT / "profiles.json")["profiles"][0]
        self.model = load(ROOT / self.profile["model"])
        self.report = run_profile(self.profile, self.out, formal=True, depth=2)

    def test_claims_bind_actual_proposition_scope_checker_and_queries(self):
        claims = read(self.out / "claims.json")
        bounded = claims["claims"][0]
        self.assertEqual(bounded["status"], "verified_bounded")
        self.assertEqual(bounded["statement"]["depth"], 2)
        self.assertFalse(bounded["statement"]["unbounded"])
        self.assertFalse(bounded["kernel_checked_proof"])
        self.assertIn("protocol_lab/symbolic.py", bounded["checker_code_hashes"])
        self.assertIn("formal/model.smt2", bounded["evidence_hashes"])
        self.assertEqual(len(bounded["proposition_sha256"]), 64)
        self.assertFalse(claims["protocol_complete"])
        self.assertEqual(verify(self.model, self.profile, self.report, self.out)["status"], "valid_claim_bindings")

    def test_rehashing_claim_cannot_promote_it_to_kernel_checked(self):
        claims = read(self.out / "claims.json")
        claims["claims"][0]["kernel_checked_proof"] = True
        write(self.out / "claims.json", claims)
        report = copy.deepcopy(self.report)
        report["artifact_hashes"]["claims.json"] = digest(self.out / "claims.json")
        with self.assertRaisesRegex(ModelError, "claim manifest mismatch"):
            verify(self.model, self.profile, report, self.out)

    def test_query_change_or_missing_evidence_cannot_reuse_claim(self):
        path = self.out / "formal/model.smt2"
        path.write_text(path.read_text()+"; changed\n")
        with self.assertRaisesRegex(ModelError, "evidence changed"):
            verify(self.model, self.profile, self.report, self.out)
        formal = read(self.out / "formal/result.json")
        hashes = {p: h for p, h in self.report["artifact_hashes"].items() if p != "formal/model.smt2"}
        with self.assertRaisesRegex(ModelError, "Missing bounded claim evidence"):
            build(self.model, self.profile, self.report["input_hashes"], self.report["scenarios"], formal, {"status": "not_run"}, hashes)

    def test_changed_depth_or_assumptions_require_a_new_proposition_binding(self):
        formal = read(self.out / "formal/result.json")
        formal["depth"] = 1
        write(self.out / "formal/result.json", formal)
        report = copy.deepcopy(self.report)
        report["artifact_hashes"]["formal/result.json"] = digest(self.out / "formal/result.json")
        with self.assertRaisesRegex(ModelError, "claim manifest mismatch"):
            verify(self.model, self.profile, report, self.out)
        model = copy.deepcopy(self.model)
        model["scope"]["excluded"].append("changed-scope")
        with self.assertRaisesRegex(ModelError, "model mismatch"):
            verify(model, self.profile, self.report, self.out)

    def test_unknown_is_preserved_and_cannot_be_relabeled_bounded_pass(self):
        formal = read(self.out / "formal/result.json")
        formal.update(status="unknown", safety_query="unknown", overlap_query="unknown", reason="unit fixture")
        args = (self.model, self.profile, self.report["input_hashes"], self.report["scenarios"])
        artifact_hashes = {p: h for p, h in self.report["artifact_hashes"].items() if p != "claims.json"}
        claim = build(*args, formal, {"status": "not_run"}, artifact_hashes)
        self.assertEqual(claim["claims"][0]["status"], "unknown")
        formal["status"] = "bounded_pass"
        with self.assertRaisesRegex(ModelError, "Cannot promote inconclusive"):
            build(*args, formal, {"status": "not_run"}, artifact_hashes)

    def test_induction_claim_cannot_omit_a_declared_target(self):
        from protocol_lab.inductive import prove
        induction=prove(self.model,out=self.out/'inductive')
        self.assertEqual(induction['status'],'inductive_invariants_pass')
        formal=read(self.out/'formal/result.json')
        artifacts=dict(self.report['artifact_hashes'])
        for name in [*induction['query_hashes'],'result.json']:
            artifacts['inductive/'+name]=digest(self.out/'inductive'/name)
        result=build(self.model,self.profile,self.report['input_hashes'],self.report['scenarios'],formal,induction,artifacts)
        self.assertEqual(result['claims'][1]['statement']['target_coverage'],'all_declared_destinations')
        induction['preservation'][0]['targets']=[]
        with self.assertRaisesRegex(ModelError,'target obligation'):
            build(self.model,self.profile,self.report['input_hashes'],self.report['scenarios'],formal,induction,artifacts)
