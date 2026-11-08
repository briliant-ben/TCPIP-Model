"""Independent peer host APIs are mocked, never live-network evidence."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import time
import unittest
from unittest.mock import Mock, patch
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'ports/linux-tcp-ipv4-peer'))
import services
ROOT=Path(__file__).resolve().parents[1]
CONFIG=json.loads((ROOT/'ports/linux-tcp-ipv4-peer/services.json').read_text())


class ServiceContracts(unittest.TestCase):
    def test_strict_summary_requires_one_exact_numeric_success(self):
        for loss in ['0','0.0']:
            self.assertEqual(services.ping_summary('1 packets transmitted, 1 received, '+loss+'% packet loss, time 0ms')['received'],1)
        for value in ['', '1 packets transmitted, 0 received, 100% packet loss', '2 packets transmitted, 2 received, 0% packet loss', '1 packets transmitted, 1 received, 0% packet loss\n1 packets transmitted, 1 received, 0% packet loss']:
            with self.assertRaises(ValueError):services.ping_summary(value)

    def exercise(self, defect=None):
        sock=Mock();sock.fileno.return_value=12;processes=[]
        with tempfile.TemporaryDirectory()as folder,patch.object(services.socket,'socket',return_value=sock):
            peer=services.ServicePeers(Path(folder)/'peers',CONFIG)
            for i,case in enumerate(CONFIG['payloads']):
                payload=bytes.fromhex(case['hex']);sock.recvfrom.return_value=(payload,('192.0.2.1',40000));sock.sendto.return_value=len(payload)
                peer.begin_udp(i);peer.receive_udp();peer.finish_udp()
                self.assertEqual(sock.sendto.call_args.args,(payload,('192.0.2.1',40000)))
            def launch(command,**kwargs):
                process=Mock();process.pid=100+len(processes);process.poll.return_value=None
                process.wait.return_value=0
                stdout=kwargs['stdout'];index=len(processes)
                def wait(timeout=None):
                    if defect=='timeout'and index==0 and not process.kill.called:raise subprocess.TimeoutExpired(command,timeout)
                    if not (defect=='missing-summary'and index==1):stdout.write('1 packets transmitted, 1 received, 0% packet loss, time 0ms\n');stdout.flush()
                    process.poll.return_value=0
                    return 4 if defect=='nonzero'and index==1 else 0
                process.wait.side_effect=wait;processes.append(process)
                self.assertEqual(command,['ping','-4','-n','-I','192.0.2.2','-M','do','-i','3600','-W','3','-s',str(CONFIG['echoes'][index]['data_bytes']),'-p','0080ff0700','192.0.2.1'])
                self.assertEqual(kwargs['env']['LC_ALL'],'C')
                return process
            with patch.object(services.subprocess,'Popen',side_effect=launch):
                for i in range(3):peer.start_ping(i)
            with self.assertRaises(ValueError):peer.finish_after_capture(time.monotonic_ns()+10**12)
            sock.close.assert_not_called()
            for process in processes:process.send_signal.assert_not_called()
            stamp=time.monotonic_ns()
            if defect:
                with self.assertRaises(RuntimeError):peer.finish_after_capture(stamp)
            else:
                result=peer.finish_after_capture(stamp);self.assertEqual(result['status'],'finite_service_peer_pass')
            sock.close.assert_called_once()
            for process in processes:process.send_signal.assert_called_once_with(2);self.assertTrue(process.wait.called)
            result=json.loads((Path(folder)/'peers/result.json').read_text())
            self.assertTrue(all(x['stop_request_monotonic_ns']>=stamp for x in result['trials']))
            self.assertGreaterEqual(result['closed_monotonic_ns'],stamp)
            self.assertFalse(result['whole_ipv4_endpoint_complete'])
            return result

    def test_original_empty_odd_and_mtu_echo_and_all_ping_receipts(self):self.exercise()

    def test_one_bad_ping_still_closes_all_peers_and_fails(self):
        for defect in ['timeout','missing-summary','nonzero']:
            self.assertEqual(self.exercise(defect)['status'],'failed')

    def test_udp_wrong_source_payload_partial_duplicate_and_missing_are_rejected(self):
        for defect in ['source','payload','partial','duplicate','missing']:
            sock=Mock();sock.fileno.return_value=12
            with tempfile.TemporaryDirectory()as folder,patch.object(services.socket,'socket',return_value=sock):
                peer=services.ServicePeers(Path(folder)/'peers',CONFIG)
                # Skip the empty case using a valid exchange; exercise odd bytes next.
                peer.begin_udp(0);sock.recvfrom.return_value=(b'',('192.0.2.1',40000));sock.sendto.return_value=0;peer.receive_udp();peer.finish_udp()
                peer.begin_udp(1);payload=bytes.fromhex(CONFIG['payloads'][1]['hex']);sock.recvfrom.return_value=(b'corrupt'if defect=='payload'else payload,('192.0.2.2',8080)if defect=='source'else('192.0.2.1',40000));sock.sendto.return_value=1 if defect=='partial'else len(payload)
                with self.assertRaises(ValueError):
                    if defect=='missing':peer.finish_udp()
                    else:
                        peer.receive_udp()
                        if defect=='duplicate':peer.receive_udp()
                result=peer.finish_after_capture(time.monotonic_ns(),abort=True)
                self.assertEqual(result['status'],'aborted');sock.close.assert_called_once()

    def test_bind_or_ping_start_failure_releases_partial_resources(self):
        sock=Mock();sock.bind.side_effect=OSError('bind failed')
        with tempfile.TemporaryDirectory()as folder,patch.object(services.socket,'socket',return_value=sock):
            with self.assertRaises(OSError):services.ServicePeers(Path(folder)/'peers',CONFIG)
            sock.close.assert_called_once()
        sock=Mock();sock.fileno.return_value=12
        with tempfile.TemporaryDirectory()as folder,patch.object(services.socket,'socket',return_value=sock):
            peer=services.ServicePeers(Path(folder)/'peers',CONFIG)
            with patch.object(services.subprocess,'Popen',side_effect=OSError('launch failed')):
                with self.assertRaises(OSError):peer.start_ping(0)
            self.assertEqual(peer.pings,[])
            peer.finish_after_capture(time.monotonic_ns(),abort=True)


class ServiceClientContracts(unittest.TestCase):
    def exercise(self, bad=False, timeout=False, model_error=False):
        emitted,links,operations=[],[],[];now=[0];events=[]
        class Peers:
            config=CONFIG
            def begin_udp(self,index):self.index=index;events.append(('udp',index))
            def finish_udp(self):events.append(('udp_done',self.index))
            def start_ping(self,index):events.append(('ping',index))
        peers=Peers()
        def operation(step):operations.append(step);return dict(status='error',failure='uncovered_event')if model_error else dict(status='ok')
        def pump(deadline):
            now[0]+=5 if timeout else 0.1
            if timeout:return None
            if len(operations)<4 and len(emitted)<len(operations):
                payload=list(bytes.fromhex(CONFIG['payloads'][peers.index]['hex']))
                emitted.append(dict(message='L.udp.rx',fields=dict(data=[9]if bad else payload)))
            else:
                raw=b'\0'*12+b'\x08\x00'+b'\x45'+b'\0'*8+b'\x01'+b'\0'*10
                links.extend([dict(raw=raw.hex()),dict(raw=raw.hex())])
            return dict(status='ok')
        if bad or timeout or model_error:
            with self.assertRaises((RuntimeError,ValueError,TimeoutError)):services.run_service_trials(peers,operation,pump,emitted,links,lambda:now[0])
        else:
            services.run_service_trials(peers,operation,pump,emitted,links,lambda:now[0])
            self.assertEqual(operations,[dict(event='L.app.send',fields=dict(data=list(bytes.fromhex(case['hex']))))for case in CONFIG['payloads']])
            self.assertEqual(events,[('udp',0),('udp_done',0),('udp',1),('udp_done',1),('udp',2),('udp_done',2),('ping',0),('ping',1),('ping',2)])
            self.assertEqual(len(links),6)
    def test_finite_client_sequence(self):self.exercise()
    def test_wrong_delivery_timeout_or_model_error_is_never_success(self):
        self.exercise(bad=True);self.exercise(timeout=True);self.exercise(model_error=True)
