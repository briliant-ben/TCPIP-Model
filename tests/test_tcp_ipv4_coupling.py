import copy
import json
import unittest
from pathlib import Path
from unittest.mock import patch

import tools.build_tcp_ipv4_endpoint as builder
from protocol_lab.symbolic import model_hash
from protocol_lab.ir import Machine


class TestTCPIPv4Coupling(unittest.TestCase):
    def setUp(self):
        self.committed_path = builder.OUTPUT_DEFAULT
        with open(self.committed_path, "r", encoding="utf-8") as f:
            self.committed_model = json.load(f)

    def test_build_model_matches_committed_file(self):
        generated = builder.build_model()
        self.assertEqual(generated, self.committed_model)
        self.assertEqual(model_hash(generated), builder.APPROVED_OUTPUT_SHA)

    def test_frozen_independent_seeds_keep_bytes_variables_and_timers(self):
        import hashlib

        oracle = builder.BASE_DIR / "spec/tcp-ipv4-endpoint-oracle.json"
        self.assertEqual(hashlib.sha256(oracle.read_bytes()).hexdigest(),
                         "8f66ce0af1f88072d2de8990dd55b584edad299abc9b5baf55bcf00e6bedb919")
        for case in json.loads(oracle.read_text())["cases"]:
            with self.subTest(case=case["id"]):
                scenario = json.loads((builder.BASE_DIR / "scenarios/tcp-ipv4-endpoint"
                                       / (case["id"] + ".json")).read_text())
                self.assertEqual(len(scenario["steps"]), len(case["steps"]))
                machine = Machine(self.committed_model, case.get("initial", {}))
                for actual_input, expected in zip(scenario["steps"], case["steps"]):
                    self.assertEqual(actual_input["at_ms"], expected["at_ms"])
                    self.assertEqual(actual_input["event"], expected["event"])
                    self.assertEqual(actual_input.get("fields", {}), expected.get("fields", {}))
                    machine.dispatch(expected["event"], expected.get("fields", {}), expected["at_ms"])
                    self.assertEqual(machine.trace[-1]["emitted"], expected["expected_emitted"])
                    for key, value in expected["expected_variables"].items():
                        self.assertEqual(machine.values[key], value, key)
                    if "expected_timers" in expected:
                        self.assertEqual(machine.timers, expected["expected_timers"])

    def test_component_mutation_rejected(self):
        original_ipv4 = builder._read_component("ipv4-udp-icmp")
        original_tcp = builder._read_component("tcp-wire")

        mutated = copy.deepcopy(original_ipv4)
        # Mutate a variable's initial value (numeric) if present, else requirement text.
        for var_name, decl in mutated["variables"].items():
            if "initial" in decl and isinstance(decl["initial"], int):
                decl["initial"] += 1
                break
        else:
            first_key = next(iter(mutated["requirements"]))
            mutated["requirements"][first_key]["interpretation"] += " mutated"

        def mock_read(name):
            if name == "ipv4-udp-icmp":
                return mutated
            if name == "tcp-wire":
                return original_tcp
            raise KeyError(name)

        with patch.object(builder, "_read_component", side_effect=mock_read) as mock_read:
            with self.assertRaisesRegex(ValueError, "semantic hash mismatch"):
                builder.build_model()

        self.assertEqual(builder._read_component("ipv4-udp-icmp"), original_ipv4)
        self.assertEqual(builder._read_component("tcp-wire"), original_tcp)

    def test_expression_based_t_control_rejected_directly(self):
        fake_base = {
            "transitions": [
                {
                    "id": "BAD",
                    "actions": [
                        {
                            "set": {
                                "var": "T.control",
                                "value": {"op": "ite", "args": [True, "CLOSED", "LISTEN"]}
                            }
                        }
                    ]
                }
            ]
        }
        with self.assertRaisesRegex(ValueError, "unsupported expression-based T.control"):
            builder._check_expression_based_t_control(fake_base)

    def test_write_output_file_hash_matches_approved(self):
        import tempfile
        import hashlib

        model = builder.build_model()
        text = json.dumps(model, indent=2) + "\n"
        expected_file_sha = hashlib.sha256(text.encode("utf-8")).hexdigest()
        self.assertEqual(expected_file_sha, builder.APPROVED_OUTPUT_FILE_SHA)

        with tempfile.TemporaryDirectory() as tmpdir:
            out_path = Path(tmpdir) / "model.json"
            builder.write_output(model, out_path)
            self.assertEqual(out_path.read_text(encoding="utf-8"), text)

    def test_rejected_output_preserves_existing_file(self):
        import tempfile

        changed = copy.deepcopy(self.committed_model)
        changed["protocol"] += "-unapproved"
        with tempfile.TemporaryDirectory() as temporary:
            target = Path(temporary) / "model.json"
            target.write_bytes(b"preserve-existing")
            with self.assertRaisesRegex(ValueError, "output file hash mismatch"):
                builder.write_output(changed, target)
            self.assertEqual(target.read_bytes(), b"preserve-existing")


if __name__ == "__main__":
    unittest.main()
