"""Preparation/isolation negatives; unit fixtures are never Linux evidence."""
import tempfile
from pathlib import Path
import unittest
import run as driver


class LinuxPlanTests(unittest.TestCase):
    def test_model_generated_expectations_are_preserved_exactly(self):
        with tempfile.TemporaryDirectory() as tmp:
            out=Path(tmp)
            _,machine,packets,base,_=driver.reference(out)
            script=driver.execution_script(base,out)
            self.assertEqual(machine.state,'ESTABLISHED')
            self.assertEqual([p['flags']for p in packets],['S','SA','A'])
            additions=[line for line in script.splitlines() if line not in base.splitlines()]
            self.assertEqual(len(additions),2)
            for line in base.splitlines():self.assertIn(line,script.splitlines())
            self.assertIn('+0 bind(3, ..., ...) = 0',additions)
            self.assertTrue(any('ethtool -K tun0 tx off' in line for line in additions))

    def test_shared_or_malformed_namespace_cannot_change_network(self):
        for parent,child in [('net:[1]','net:[1]'),('','net:[2]'),('net:[1]','')]:
            with self.assertRaises(ValueError):driver.require_isolation(parent,child)
        driver.require_isolation('net:[1]','net:[2]')


if __name__=='__main__':unittest.main(verbosity=2)
