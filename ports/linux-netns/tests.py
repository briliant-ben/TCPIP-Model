"""Preparation/isolation negatives; unit fixtures are never Linux evidence."""
import tempfile
import copy
from pathlib import Path
import unittest
from unittest.mock import patch
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

    def test_syn_loss_keeps_both_egress_syns_and_exact_source_timing(self):
        with tempfile.TemporaryDirectory() as tmp:
            out=Path(tmp)
            _,machine,packets,base,mapping=driver.reference(out,'syn-loss')
            self.assertEqual(machine.state,'ESTABLISHED')
            self.assertEqual(machine.values['retries'],1)
            self.assertEqual([p['flags']for p in packets],['S','S','SA','A'])
            self.assertEqual([p['time_ms']for p in packets],[0,1000,1010,1010])
            self.assertEqual([p['dropped_after_egress']for p in packets],[True,False,False,False])
            self.assertEqual(packets[0]['seq'],packets[1]['seq'])
            self.assertIn('+1.000 > S 0:0(0) <...>',base)
            script=driver.execution_script(base,out,driver.quiet_after_protocol_ms(packets,'syn-loss'))
            self.assertIn('+5.000 getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0',script)
            mapped=driver.execution_mapping(base,script,mapping)
            self.assertEqual(len(mapped),4)
            for row in mapped:
                self.assertEqual(base.splitlines()[row['base_line']-1],script.splitlines()[row['execution_line']-1])

    def test_loss_marker_cannot_silently_select_another_packet(self):
        scene=driver.scenario_config('syn-loss')
        scene['environment']['drop_outgoing']=['e0002:out:0']
        with patch.object(driver,'scenario_config',return_value=scene):
            with self.assertRaisesRegex(ValueError,'Unsupported loss setup'):
                driver.reference(Path('/unused'),'syn-loss')

    def test_unknown_scenario_is_rejected_before_reading_any_path(self):
        for name in ('../scenarios/handshake.json','tcp-data','',None):
            with self.assertRaisesRegex(ValueError,'Unsupported Linux scenario'):
                driver.scenario_config(name)

    def test_quiet_window_uses_selected_source_settle(self):
        for name,settle in [('handshake',5010),('syn-loss',6010)]:
            _,_,packets,_,_=driver.reference(Path('/unused'),name)
            self.assertEqual(packets[-1]['time_ms']+driver.quiet_after_protocol_ms(packets,name),settle)
            with self.assertRaisesRegex(ValueError,'Quiet interval outside'):
                driver.quiet_after_protocol_ms([{'time_ms':settle+1}],name)

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


class LinuxReceivePlanTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.scene=driver.scenario_config(driver.receive.CASE)
        cls.model,cls.machine,cls.packets,cls.base,cls.mapping=driver.reference(Path('/unused'),driver.receive.CASE)

    def test_complete_oracle_retains_both_acks_window_payload_and_timer_time(self):
        self.assertEqual([p['time_ms']for p in self.packets],[0,10,10,20,60])
        self.assertEqual(self.packets[3]['payload'],[0,0,0,0])
        self.assertEqual(self.machine.values['rcv_buf'],[0,0,0,0])
        self.assertEqual(driver.projection(driver.receive.CASE),'tcp-connection-v1')
        self.assertEqual(len(self.packets),5)
        self.assertIn('window',self.packets[-1])
        self.assertEqual(self.packets[-1]['ack'],9005)

    def test_driver_observes_acks_without_imposing_model_ack_timing(self):
        roles=driver.driver_policy(self.packets,driver.receive.CASE)
        self.assertEqual([i for i,r in enumerate(roles)if r['role']=='independent_observation_only'],[2,4])
        self.assertEqual(len(self.mapping),3)
        self.assertIn('+0.010 < . 1:5(4) ack 1 win 8',self.base)
        self.assertEqual(driver.quiet_after_protocol_ms(self.packets,driver.receive.CASE),5000)
        script=driver.execution_script(self.base,Path('/review/receive'),5000)
        self.assertEqual(len(driver.execution_mapping(self.base,script,self.mapping)),3)
        self.assertNotIn('> .',script)
        self.assertIn('+5.000 getsockopt',script)

    def test_arbitrary_octets_or_other_stimuli_are_explicitly_rejected(self):
        for field,value in [('data',[0,128,255,7]),('seq',9002)]:
            scene=copy.deepcopy(self.scene);scene['steps'][-1]['fields'][field]=value
            with self.assertRaisesRegex(ValueError,'declared zero-octet receive stimulus'):
                driver.receive.render(scene,self.packets)
        packets=copy.deepcopy(self.packets);packets[3]['payload']=[1,0,0,0]
        with self.assertRaisesRegex(ValueError,'cannot represent arbitrary'):
            driver.receive.render(self.scene,packets)

    def test_missing_output_ack_is_difference_not_incomplete_capture(self):
        observed=copy.deepcopy(self.packets[:-1])
        driver.validate_observation(self.packets,observed,driver.receive.CASE)
        self.assertEqual(driver.compare(self.packets,observed,tolerance_ms=0,projection=driver.projection(driver.receive.CASE))['differences'][0]['kind'],'packet_count')
        with self.assertRaisesRegex(ValueError,'Captured receive stimuli differ'):
            driver.validate_observation(self.packets,observed[:3],driver.receive.CASE)

    def test_observation_only_does_not_remove_strict_oracle_fields(self):
        for index,field,value in [(3,'payload',[0,0,0,1]),(4,'window',12345),(4,'time_ms',61)]:
            observed=copy.deepcopy(self.packets);observed[index][field]=value
            result=driver.compare(self.packets,observed,tolerance_ms=0,projection=driver.projection(driver.receive.CASE))
            self.assertEqual(result['status'],'mismatch')
            self.assertEqual(result['differences'][0]['field'],field)


if __name__=='__main__':unittest.main(verbosity=2)
