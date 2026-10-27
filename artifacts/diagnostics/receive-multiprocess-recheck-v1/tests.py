"""Standalone integration/fault tests for the event-driven independent stream channel."""
import copy
import json
from pathlib import Path
import tempfile
import unittest

import run as driver

SCENARIO=driver.PORT/'scenarios/two-segments-partial-ack.json'


class PlanTests(unittest.TestCase):
    def test_reject_unsupported_inputs(self):
        source=driver.read(SCENARIO)
        mutations=[lambda s:s['steps'][3].update(at_ms=True),
                   lambda s:s['steps'][2]['fields'].update(data=[True,0,1,2]),
                   lambda s:s['steps'][2]['fields'].update(data=[]),
                   lambda s:s['steps'][2].update(event='net.data'),
                   lambda s:s['steps'][-1].update(at_ms=201),
                   lambda s:s['steps'][-1]['fields'].update(ack=2**32),
                   lambda s:s['environment'].update(drop_outgoing=['e0001:out:0']),
                   lambda s:s['environment'].update(unknown_network_action=True),
                   lambda s:s['initial'].update(snd_nxt=123)]
        for mutation in mutations:
            with self.subTest(mutation=mutation):
                scenario=copy.deepcopy(source);mutation(scenario)
                with self.assertRaises(ValueError):driver.validate_plan(scenario)
        self.assertIn('20 SEND 0080ff0711214181',driver.validate_plan(source))

    def test_compiler_environment_failure_is_distinct(self):
        from unittest.mock import patch
        with tempfile.TemporaryDirectory() as tmp,patch.object(driver.shutil,'which',return_value=None):
            with self.assertRaisesRegex(ValueError,'C99 compiler unavailable'):driver.run(Path(tmp),SCENARIO)
            report=driver.read(Path(tmp)/'report.json')
            self.assertEqual(report['status'],'environment_failure')
            self.assertEqual(report['phase'],'compiler')



class IndependentDataTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp=tempfile.TemporaryDirectory(prefix='lwip-data-test-')
        cls.out=Path(cls.temp.name)
        cls.result=driver.run(cls.out,SCENARIO)

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def corrupt(self, name, mutation, error):
        target=self.out/name;report=self.out/'report.json'
        old=target.read_bytes();old_report=report.read_bytes()
        try:
            mutation(target)
            r=json.loads(old_report)
            r['file_hashes'][name]=driver.digest(target)
            driver.write(report,r)
            with self.assertRaisesRegex(ValueError,error):driver.verify(self.out,SCENARIO)
        finally:
            target.write_bytes(old);report.write_bytes(old_report)

    def test_c_driver_rejects_malformed_commands(self):
        import subprocess
        malformed=['0 CONNECT extra\n','-1 CONNECT\n','0 CONNECT\n1 UNKNOWN\n',
                   '0 CONNECT\n10 SYNACK 9000 1001 8 trailing\n',
                   '0 CONNECT\n10 SYNACK 9000 1001 8\n11 SEND gg\n',
                   '0 CONNECT\n10 SYNACK 9000 1001 65536\n',
                   '0 CONNECT\n10 SYNACK 9000 1001 8\n9 TRANSMIT\n',
                   '0 CONNECT\n10 SYNACK 9000 1001 8\n11 ACK 9001 4294967296 8\n']
        for i,text in enumerate(malformed):
            with self.subTest(plan=text):
                plan=self.out/f'bad-{i}.txt';plan.write_text(text)
                r=subprocess.run([str(self.out/'lwip-harness'),str(self.out/f'bad-{i}.pcap'),str(plan)],capture_output=True,timeout=5)
                self.assertEqual(r.returncode,2)

    def test_rehashed_stimulus_is_rejected(self):
        self.corrupt('stimulus.txt',lambda p:p.write_text(p.read_text().replace('1003','1004')),'Input event mapping changed')

    def test_actual_lwip_data_matches(self):
        self.assertEqual(self.result['comparison'],'match')
        packets=driver.read(self.out/'observed.json')
        payload=[p['payload'] for p in packets if p['direction']=='out' and p.get('payload')]
        self.assertEqual(payload,[[0,128,255,7],[17,33,65,129]])
        self.assertEqual(driver.verify(self.out,SCENARIO)['status'],'valid_independent_lwip_stream_evidence')

    def test_rehashed_oracle_is_rejected(self):
        def change(path):
            packets=driver.read(path)
            next(p for p in packets if p.get('payload'))['payload'][0]=1
            driver.write(path,packets)
        self.corrupt('expected.json',change,'Reference output changed')

    def test_rehashed_capture_is_rejected(self):
        def change(path):
            raw=bytearray(path.read_bytes());raw[-1]^=1;path.write_bytes(raw)
        self.corrupt('capture.pcap',change,'checksum')

    def test_rehashed_execution_summary_is_rejected(self):
        target=self.out/'execution.log';report=self.out/'report.json'
        old=target.read_bytes();old_report=report.read_bytes()
        try:
            summary=copy.deepcopy(self.result['summary']);summary['written_bytes']=0
            driver.write(target,summary)
            r=json.loads(old_report);r['summary']=summary;r['file_hashes']['execution.log']=driver.digest(target)
            driver.write(report,r)
            with self.assertRaisesRegex(ValueError,'Execution summary changed'):driver.verify(self.out,SCENARIO)
        finally:target.write_bytes(old);report.write_bytes(old_report)

    def test_rehashed_query_is_rejected(self):
        query=self.out/'symbolic/path.smt2';result=self.out/'symbolic/result.json';report=self.out/'report.json'
        old={p:p.read_bytes() for p in (query,result,report)}
        try:
            query.write_text('(assert true)\n(check-sat)\n')
            symbolic=driver.read(result);symbolic['smt2_sha256']=driver.digest(query);driver.write(result,symbolic)
            r=driver.read(report)
            for name in ('symbolic/path.smt2','symbolic/result.json'):r['file_hashes'][name]=driver.digest(self.out/name)
            driver.write(report,r)
            with self.assertRaisesRegex(ValueError,'differs from regenerated semantics'):driver.verify(self.out,SCENARIO)
        finally:
            for path,data in old.items():path.write_bytes(data)

    def test_rehashed_build_command_is_rejected(self):
        def change(path):
            build=driver.read(path);build['command'][1]='-std=c11';driver.write(path,build)
        self.corrupt('build.json',change,'Build command/log changed')

    def test_missing_required_artifact_is_rejected(self):
        target=self.out/'report.json';old=target.read_bytes()
        try:
            r=json.loads(old);del r['file_hashes']['capture.pcap'];driver.write(target,r)
            with self.assertRaisesRegex(ValueError,'file set changed'):driver.verify(self.out,SCENARIO)
        finally:target.write_bytes(old)

    def test_linux_relabelling_is_rejected(self):
        target=self.out/'report.json';old=target.read_bytes()
        try:
            r=json.loads(old);r['linux_execution']=True;driver.write(target,r)
            with self.assertRaisesRegex(ValueError,'scope relabelled'):driver.verify(self.out,SCENARIO)
        finally:target.write_bytes(old)


class ReceiverTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp=tempfile.TemporaryDirectory(prefix='lwip-receive-test-');cls.out=Path(cls.temp.name)
        cls.scenario=driver.PORT/'scenarios/receive-fin-with-payload.json'
        cls.result=driver.run(cls.out,cls.scenario)

    @classmethod
    def tearDownClass(cls):cls.temp.cleanup()

    def test_real_bytes_and_eof_verified_even_with_wire_difference(self):
        self.assertEqual(self.result['comparison'],'mismatch')
        self.assertEqual(driver.read(self.out/'receiver-difference.json')['status'],'match')
        self.assertEqual(self.result['summary']['receiver_events'],[
            {'time_ms':20,'eof':False,'data':[0,128,255,7]},
            {'time_ms':20,'eof':True,'data':[]}])
        self.assertEqual(driver.verify(self.out,self.scenario)['comparison'],'mismatch')

    def test_rehashed_receiver_byte_and_eof_order_corruption_is_rejected(self):
        report=self.out/'report.json';log=self.out/'execution.log';original={p:p.read_bytes() for p in (report,log)}
        for kind in ('byte','time','eof_order'):
            with self.subTest(corruption=kind):
                try:
                    r=json.loads(original[report]);summary=r['summary']
                    if kind=='byte':summary['receiver_events'][0]['data'][1]=129
                    elif kind=='time':
                        for event in summary['receiver_events']:event['time_ms']=21
                    else:summary['receiver_events'].reverse()
                    driver.write(log,summary);r['file_hashes']['execution.log']=driver.digest(log);driver.write(report,r)
                    with self.assertRaisesRegex(ValueError,'Receiver Difference changed'):driver.verify(self.out,self.scenario)
                finally:
                    for path,data in original.items():path.write_bytes(data)

    def test_receiver_chunk_boundaries_do_not_erase_order_or_time(self):
        trace=driver.read(self.out/'reference-trace.json');summary=copy.deepcopy(self.result['summary'])
        data=summary['receiver_events'][0]['data'];eof=summary['receiver_events'][1]
        summary['receiver_events']=[{'time_ms':20,'eof':False,'data':data[:2]},{'time_ms':20,'eof':False,'data':data[2:]},eof]
        self.assertEqual(driver.receiver_difference(trace,summary)['status'],'match')
        summary['receiver_events'][0]['time_ms']=19
        self.assertEqual(driver.receiver_difference(trace,summary)['status'],'mismatch')
        summary['receiver_events'][0]['time_ms']=20
        summary['receiver_events'][0]['data'].reverse()
        self.assertEqual(driver.receiver_difference(trace,summary)['status'],'mismatch')

    def test_new_commands_reject_malformed_payload_and_post_close_write(self):
        import subprocess
        prefix='0 CONNECT\n10 SYNACK 9000 1001 8\n'
        for body in ('20 DATA 9001 1001 8 -\n','20 FIN 9001 1001 8 gg\n',
                     '20 DATA 9001 1001 8 '+('01'*17)+'\n',
                     '20 CLOSE\n21 SEND 00\n','20 CLOSE\n21 TRANSMIT\n'):
            with self.subTest(body=body):
                plan=self.out/'bad-receiver.txt';plan.write_text(prefix+body)
                r=subprocess.run([str(self.out/'lwip-harness'),str(self.out/'bad-receiver.pcap'),str(plan)],capture_output=True,timeout=5)
                self.assertEqual(r.returncode,2)


if __name__=='__main__':unittest.main(verbosity=2)
