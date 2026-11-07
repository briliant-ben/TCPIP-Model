"""No paid calls: reject source capabilities and missing fixture billing."""
import importlib.util
import json
from pathlib import Path
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT/'agents'))
def module(name,file):
    s=importlib.util.spec_from_file_location(name,ROOT/'agents'/file);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
gate=module('namespace_gate','validate_namespace_proposal.py')
driver=module('composition_driver','run_composition_proposal.py')

class NamespaceSourceGateTests(unittest.TestCase):
    def test_io_introspection_dynamic_calls_and_optional_validator_are_rejected(self):
        sources=['def f():\n return open("private")\n','import os\n','def f(x):\n return x.__class__\n','def f(x):\n return x[0]()\n','try:\n from protocol_lab.ir import validate\nexcept:\n pass\n','def f(x):\n return "{0.__class__}".format(x)\n','def f(open):\n return open("private")\n']
        with tempfile.TemporaryDirectory()as temporary:
            p=Path(temporary)/'proposal.py'
            for source in sources:
                with self.subTest(source=source):
                    p.write_text(source)
                    with self.assertRaises(ValueError):gate.source_gate(p)
    def test_pure_copy_and_typed_validation_subset_is_admitted(self):
        with tempfile.TemporaryDirectory()as temporary:
            p=Path(temporary)/'proposal.py';p.write_text('import copy\nfrom protocol_lab.ir import validate\ndef f(x):\n y=copy.deepcopy(x)\n validate(y)\n return y\n')
            self.assertIsNotNone(gate.source_gate(p))
    def test_missing_frozen_fixtures_stop_before_any_provider_call(self):
        with tempfile.TemporaryDirectory()as temporary:
            root=Path(temporary);workspace=root/'workspace';workspace.mkdir();task=root/'task.json';task.write_text(json.dumps(dict(required_fixture_counts={'word32-contract':10})))
            args=SimpleNamespace(out=str(root/'out'),workspace=str(workspace),task=str(task),ledger=str(root/'ledger'),credential_file='/never/read',validation_script=None)
            with patch.object(driver,'request')as paid:
                with self.assertRaises(FileNotFoundError):driver.run(args)
            paid.assert_not_called()
