"""Independent adversarial tests for initial-step contract execution.

These tests use only the documented public API (check and verify) and the
EXACT valid toy model provided by the contract (deep copied for mutations).
They do not depend on implementation details beyond the contract, and all
tests run without skipping.

Limitations:
- No deeper states, induction, wire/compiler/English spec, or complete protocol proof.
- Scope is flat-efsm-atomic-ordered-v1, depth 1, default fixed initialization.
- Tests may use tempfile/pathlib/hashlib/json/copy/unittest.mock; no network/credentials/C.
- The test suite is authored as JSON files only; it will be executed by the harness.
"""

import copy
import hashlib
import json
import os
import shutil
import tempfile
import unittest
from pathlib import Path
from unittest import mock

# Public API imported from the module under test.
from protocol_lab.initial_step import check, verify


class InitialStepContractTests(unittest.TestCase):
    """Tests for the initial-step contract's public check/verify functions."""

    def setUp(self):
        # Create a fresh temporary directory for each test.
        self.tempdir = tempfile.TemporaryDirectory()
        self.outdir = Path(self.tempdir.name) / "out"
        self.outdir.mkdir()

        # Deep copy the exact valid toy model provided by the contract.
        self.base_model = copy.deepcopy(VALID_TOY_MODEL)

    def tearDown(self):
        self.tempdir.cleanup()

    def _write_model(self, model, name="model.json"):
        """Write a model JSON to temp dir and return its path."""
        path = Path(self.tempdir.name) / name
        with open(path, "w") as f:
            json.dump(model, f)
        return model

    def _load_result_json(self):
        """Load result.json from the output directory."""
        with open(self.outdir / "result.json", "r") as f:
            return json.load(f)

    def _compute_sha256(self, data):
        """Compute SHA-256 of JSON-serialized data (canonical)."""
        canonical = json.dumps(data, sort_keys=True, separators=(",", ":"))
        return hashlib.sha256(canonical.encode("utf-8")).hexdigest()

    def _compute_file_sha256(self, path):
        """Compute SHA-256 of file bytes."""
        h = hashlib.sha256()
        with open(path, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                h.update(chunk)
        return h.hexdigest()

    def _verify_rejects(self, model_path, outdir):
        """Helper to assert that verify rejects the current state.

        Rejection can be a verification_failed status or a raised ValueError.
        """
        try:
            result = verify(model_path, outdir, require_pass=True)
        except ValueError:
            # A raised ValueError is also a rejection.
            return
        self.assertEqual(result["status"], "verification_failed",
                         "verify did not reject tampered evidence")

    def test_normal_toy_check_and_verify_pass(self):
        """Valid toy model should pass check and verify."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        self.assertEqual(report["status"], "initial_step_contracts_pass")
        # Load result.json and verify.
        result = self._load_result_json()
        self.assertEqual(result["status"], "initial_step_contracts_pass")
        # Verify must succeed.
        ver = verify(model_path, self.outdir, require_pass=True)
        self.assertEqual(ver["status"], "verified_pass")

    def test_false_initial_invariant_never_pass(self):
        """Model with false initial invariant must not pass check."""
        model = copy.deepcopy(self.base_model)
        # Make initial packed length 1, invariant asserts length 4.
        model["variables"]["packed"]["initial"] = [0]
        model_path = self._write_model(model)
        report = check(model_path, self.outdir)
        self.assertNotEqual(report["status"], "initial_step_contracts_pass")
        # Additionally, verify should reject the result (if result exists).
        # Since check likely failed, it may not produce a valid result.json.
        # If it did, still reject.
        if (self.outdir / "result.json").exists():
            self._verify_rejects(model_path, self.outdir)

    def test_existing_nonempty_dir_rejected_by_check(self):
        """check must refuse to write into a non-empty output directory."""
        # Create a stray file in outdir.
        (self.outdir / "stray.txt").write_text("stray")
        model_path = self._write_model(self.base_model)
        with self.assertRaises(ValueError):
            check(model_path, self.outdir)

    def test_timeout_bool_rejected(self):
        """check must reject bool timeout."""
        model_path = self._write_model(self.base_model)
        with self.assertRaises(ValueError):
            check(model_path, self.outdir, solver_timeout_ms=True)

    def test_timeout_out_of_range_rejected(self):
        """check must reject timeout outside 100..60000."""
        model_path = self._write_model(self.base_model)
        for bad in [99, 60001]:
            with self.assertRaises(ValueError):
                check(model_path, self.outdir, solver_timeout_ms=bad)

    def test_timeout_string_rejected(self):
        """check must reject non-int timeout."""
        model_path = self._write_model(self.base_model)
        with self.assertRaises(ValueError):
            check(model_path, self.outdir, solver_timeout_ms="1000")

    def test_omit_query_report_row_rejected_by_verify(self):
        """Removing a query row from result.json must cause verification failure."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        self.assertEqual(report["status"], "initial_step_contracts_pass")
        result = self._load_result_json()
        # Remove one query row, preserving counts may be inconsistent.
        result["queries"] = result["queries"][:-1]
        with open(self.outdir / "result.json", "w") as f:
            json.dump(result, f)
        self._verify_rejects(model_path, self.outdir)

    def test_mutate_query_raw_and_rehash_receipt_rejected(self):
        """Altering raw SMT2 file and updating receipt hash must be caught by canonical rerender."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        # Find a query with a file path that exists.
        for q in result["queries"]:
            if "file" in q:
                qfile = self.outdir / q["file"]
                if qfile.exists():
                    # Read original content.
                    orig_content = qfile.read_text(encoding="utf-8")
                    # Replace with trivial SMT2 containing only (check-sat) with assert true.
                    new_content = "(assert true)\n(check-sat)\n"
                    qfile.write_text(new_content, encoding="utf-8")
                    # Update both the query row hash and any receipt file if present.
                    new_sha = self._compute_file_sha256(qfile)
                    q["sha256"] = new_sha
                    # If there is a separate receipt file, update it too.
                    for rfile in self.outdir.glob("*.receipt"):
                        try:
                            receipt = json.loads(rfile.read_text(encoding="utf-8"))
                        except json.JSONDecodeError:
                            continue
                        if receipt.get("id") == q["id"]:
                            receipt["sha256"] = new_sha
                            rfile.write_text(json.dumps(receipt), encoding="utf-8")
                    break
        with open(self.outdir / "result.json", "w") as f:
            json.dump(result, f)
        # Verify should reject because canonical rerender produces different query content.
        self._verify_rejects(model_path, self.outdir)

    def test_wrong_model_hash_rejected(self):
        """Wrong model_semantic_sha256 in result.json must be rejected by verify."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        result["model_semantic_sha256"] = "0" * 64
        with open(self.outdir / "result.json", "w") as f:
            json.dump(result, f)
        self._verify_rejects(model_path, self.outdir)

    def test_wrong_source_hash_rejected(self):
        """Wrong source_sha256 in result.json must be rejected by verify."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        result["source_sha256"] = "0" * 64
        with open(self.outdir / "result.json", "w") as f:
            json.dump(result, f)
        self._verify_rejects(model_path, self.outdir)

    def test_unknown_negative_row_and_receipt_rejected(self):
        """Changing a negative (UNSAT) query to UNKNOWN must cause verify failure."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        # Find a negative query (answer unsat) and set to unknown.
        for q in result["queries"]:
            if q["answer"] == "unsat":
                q["answer"] = "unknown"
                q["reason"] = "solver returned unknown"
                # Update receipt if exists.
                for rfile in self.outdir.glob("*.receipt"):
                    try:
                        receipt = json.loads(rfile.read_text(encoding="utf-8"))
                    except json.JSONDecodeError:
                        continue
                    if receipt.get("id") == q["id"]:
                        receipt["answer"] = "unknown"
                        receipt["reason"] = "solver returned unknown"
                        rfile.write_text(json.dumps(receipt), encoding="utf-8")
                break
        with open(self.outdir / "result.json", "w") as f:
            json.dump(result, f)
        self._verify_rejects(model_path, self.outdir)

    def test_path_traversal_rejected_by_verify(self):
        """Query file path pointing outside output directory must be rejected by verify."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        # Change first query file path to outside.
        for q in result["queries"]:
            if "file" in q:
                q["file"] = "../../outside/query.smt2"
                break
        with open(self.outdir / "result.json", "w") as f:
            json.dump(result, f)
        self._verify_rejects(model_path, self.outdir)

    def test_absolute_filename_rejected_by_verify(self):
        """Query file path that is absolute must be rejected."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        # Change first query file path to absolute.
        for q in result["queries"]:
            if "file" in q:
                q["file"] = "/tmp/absolute_query.smt2"
                break
        with open(self.outdir / "result.json", "w") as f:
            json.dump(result, f)
        self._verify_rejects(model_path, self.outdir)

    def test_monkeypatch_solver_check_raise_during_verify(self):
        """Verify must not use Solver.check; monkeypatch it to raise and verify still succeeds."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        self.assertEqual(report["status"], "initial_step_contracts_pass")
        # Now monkeypatch z3.Solver.check to raise an exception.
        # If verify (or its subprocess) attempts to call solver.check, it will fail.
        # Since verify is required to not use solver, this should not affect it.
        # We patch in this process; verify is expected to be a pure Python function
        # that does not invoke solver (it runs a fresh renderer in a subprocess).
        # Patch anyway to ensure no direct call.
        import z3
        original_check = z3.Solver.check
        def raise_check(self, *args, **kwargs):
            raise RuntimeError("Solver.check called during verify!")
        z3.Solver.check = raise_check
        try:
            ver = verify(model_path, self.outdir, require_pass=True)
            self.assertEqual(ver["status"], "verified_pass")
        finally:
            z3.Solver.check = original_check

    def test_modified_sample_witness_with_stale_match_rejected(self):
        """If nonvac witness replay match is altered, verify must reject."""
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        # Find nonvac witness if present.
        nonvac = result.get("nonvac_witness")
        if nonvac and "query_id" in nonvac:
            qid = nonvac["query_id"]
            # Find matching query and change its answer to sat? Actually we want to keep SAT but modify witness.
            # Modify replay entry for that query to have status mismatch.
            replay = result.get("replay", {})
            if qid in replay:
                replay[qid]["status"] = "mismatch"
            else:
                # If no replay, add one with mismatch.
                replay[qid] = {"status": "mismatch"}
            result["replay"] = replay
            with open(self.outdir / "result.json", "w") as f:
                json.dump(result, f)
            self._verify_rejects(model_path, self.outdir)

    def test_result_query_fields_contract(self):
        """All query rows in result.json must contain required keys."""
        required_keys = {"id", "role", "file", "sha256", "answer", "reason", "timeout_ms", "solver_policy"}
        model_path = self._write_model(self.base_model)
        report = check(model_path, self.outdir)
        result = self._load_result_json()
        for q in result.get("queries", []):
            self.assertTrue(required_keys.issubset(q.keys()),
                            f"Query missing required keys: {q.keys()}")

# The exact valid toy model from the contract.
VALID_TOY_MODEL = {
    "ir_version": "0.6",
    "semantics": "flat-efsm-atomic-ordered-v1",
    "protocol": "word32-packing-contract",
    "scope": {
        "terminal_states": [],
        "excluded": [
            "Protocol field admission, TCP/IP state and wire layout",
            "Network/PCAP observations",
            "Unbounded compiler or protocol proof"
        ]
    },
    "states": ["READY"],
    "initial_state": "READY",
    "variables": {
        "packed": {"type": "bytes", "initial": [0, 0, 0, 0]}
    },
    "events": {
        "pack": {"origin": "application", "fields": {"value": "int"}}
    },
    "timers": {},
    "messages": {
        "word32.result": {"fields": {"packed": "bytes"}}
    },
    "requirements": {
        "WORD32-PACK": {
            "source": "docs/word32-packing.md",
            "kind": "modeling_choice",
            "strength": "exact total value",
            "interpretation": "Four big-endian octets of value modulo 2^32. This pure arithmetic is not uint32 field admission."
        }
    },
    "transitions": [
        {
            "id": "PACK",
            "from": "READY",
            "to": "READY",
            "event": "pack",
            "guard": True,
            "requirements": ["WORD32-PACK"],
            "actions": [
                {
                    "set": {
                        "var": "packed",
                        "value": {
                            "op": "bytes_pack32be_mod",
                            "args": [{"event": "value"}]
                        }
                    }
                },
                {
                    "emit": {
                        "message": "word32.result",
                        "fields": {"packed": {"var": "packed"}}
                    }
                }
            ]
        }
    ],
    "invariants": [
        {
            "id": "PACKED-FOUR",
            "requirements": ["WORD32-PACK"],
            "assert": {
                "op": "eq",
                "args": [
                    {"op": "bytes_len", "args": [{"var": "packed"}]},
                    4
                ]
            }
        }
    ]
}


if __name__ == "__main__":
    unittest.main()
