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
            script=driver.execution_script(base,out,driver.quiet_after_protocol_ms(packets))
            self.assertEqual(machine.state,'ESTABLISHED')
            self.assertEqual([p['flags']for p in packets],['S','SA','A'])
            prepared_base=base.replace('0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3',
                '+0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3',1)
            additions=[line for line in script.splitlines() if line not in prepared_base.splitlines()]
            self.assertEqual(len(additions),4)
            for line in prepared_base.splitlines():self.assertIn(line,script.splitlines())
            self.assertIn('+0 bind(3, ..., ...) = 0',additions)
            self.assertTrue(any('ethtool -K tun0 tx off' in line for line in additions))
            self.assertIn('+5.000 getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0',additions)
            self.assertTrue(any('quiet-complete' in line and 'capture-stopped' in line for line in additions))

    def test_shared_or_malformed_namespace_cannot_change_network(self):
        for parent,child in [('net:[1]','net:[1]'),('','net:[2]'),('net:[1]','')]:
            with self.assertRaises(ValueError):driver.require_isolation(parent,child)
        driver.require_isolation('net:[1]','net:[2]')

    def test_uncovered_protocol_invalid_capture_and_environment_are_distinct(self):
        self.assertEqual(driver.failure_kind('observation',ValueError('TCP control flags outside this active-open slice')),
            'model_uncovered_capture_shape')
        self.assertEqual(driver.failure_kind('observation',ValueError('Invalid TCP checksum')),'invalid_capture_evidence')
        self.assertEqual(driver.failure_kind('capture_validation',ValueError('packet drops')),'invalid_capture_evidence')
        self.assertEqual(driver.failure_kind('packetdrill_execution',ValueError('contract failed')),'linux_execution_attempt_failed')
        self.assertEqual(driver.failure_kind('namespace_setup',ValueError('permission denied')),'environment_or_setup_failure')


if __name__=='__main__':unittest.main(verbosity=2)
