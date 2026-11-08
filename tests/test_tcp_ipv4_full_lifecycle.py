"""Mock entire full-mode control path, including immutable application script."""
import json
import sys
import tempfile
import time
import unittest
from contextlib import ExitStack
from pathlib import Path
from unittest.mock import Mock, patch
sys.path.insert(0, str(Path(__file__).resolve().parents[1]/'ports/linux-tcp-ipv4-peer'))
import probe


class FullLifecycle(unittest.TestCase):
    def exercise(self, corrupt=False, native_code=0, peer_code=0, missing_stats=False, app_gap=False):
        timeline = [];events = [];original_readlink = probe.os.readlink
        raw = b'\0'*12+b'\x08\x00'+bytes([0x45,0,0,40,0,0,0x40,0,64,6])+b'\0'*30
        def receipt(out, closed=False):
            names = ['listening','accepted','received','echo_sent','eof','write_shutdown']
            if closed: names += ['close_requested','closed']
            data = [dict(event=n,monotonic_ns=i) for i,n in enumerate(names)]
            data[0]['address']=['192.0.2.2',8080];data[1]['address']=['192.0.2.1',40000]
            data[2]['hex']='bad' if corrupt else '0080ff07';data[3]['hex']='0080ff07'
            (out/'server/server-events.jsonl').write_text(''.join(json.dumps(e)+'\n'for e in data))
        class Process:
            pid = 1234
            def __init__(self,name): self.name,self.returncode,self.stdin=name,None,Mock()
            def poll(self): return self.returncode
            def send_signal(self,_): timeline.append(self.name+'-stop')
            def wait(self,timeout=None):
                if self.name=='server': receipt(destination,True)
                self.returncode=peer_code if self.name=='server' else 0
                timeline.append(self.name+'-wait');return self.returncode
            def terminate(self): timeline.append(self.name+'-terminate')
            def kill(self): timeline.append(self.name+'-kill')
        capture,server=Process('capture'),Process('server');server.stdin.close.side_effect=lambda:timeline.append('server-control-close')
        class Actor:
            def __init__(self, executable, out):
                self.process,self.rows,self.out=Process('native'),[],out
                self.snapshot=dict(timers={},variables={'T.control':'CLOSED','T.rcv_buf':[],'T.rtx_buf':[],'T.snd_buf':[],'T.snd_una':1001,'T.snd_nxt':1001})
                out.mkdir();(out/'session.json').write_text(json.dumps(dict(process_starts=1,pid=self.process.pid)))
                self.ingress=0
            def operation(self,line):
                event=line.split()[2];events.append(event);v=self.snapshot['variables'];emitted=[]
                if event=='T.app.connect': v['T.control']='SYN-SENT'
                elif event=='L.net.frame':
                    self.ingress+=1
                    if self.ingress==1: v['T.control']='ESTABLISHED'
                    elif self.ingress==2:v.update({'T.rcv_buf':[0,128,255,7],'T.rtx_buf':[],'T.snd_una':1005})
                    else:v['T.control']='TIME-WAIT';receipt(destination)
                elif event=='T.app.send':v['T.snd_buf']=[0,128,255,7]
                elif event=='T.app.transmit':v.update({'T.snd_buf':[],'T.rtx_buf':[0,128,255,7],'T.snd_nxt':1005})
                elif event=='T.app.receive':
                    emitted=[dict(message='T.application_data',fields=dict(data=v['T.rcv_buf']))];v['T.rcv_buf']=[]
                elif event=='T.app.close':v['T.control']='FIN-WAIT-1'
                rows=[dict(status='transition',emitted=emitted),dict(status='ok')]
                if app_gap and event=='T.app.send':rows=[dict(status='error',failure='uncovered_event')]
                self.rows.extend(rows);return rows
            def close(self):timeline.append('native-close');return 1 if app_gap else native_code
        fields={'T.app.connect':{},'T.app.send':{'data':'bytes'},'T.app.transmit':{},'T.app.receive':{'count':'int'},'T.app.close':{}}
        model=dict(variables={},messages={'L.ethernet.tx':dict(fields={'frame':'bytes'})},events={k:dict(fields=v)for k,v in fields.items()})
        model['events']['L.net.frame']=dict(origin='network',fields={'frame':'bytes'})
        with tempfile.TemporaryDirectory()as folder:
            destination=Path(folder)/'out'
            def start_server(out): (out/'server').mkdir();receipt(out);return server
            def start_capture(out):
                (out/'capture.pcap').write_bytes(b'fixture')
                (out/'capture.log').write_text('3 packets captured\n3 packets received by filter\n'+(''if missing_stats else'0 packets dropped by kernel\n'))
                return capture,(out/'capture.log').open('a')
            def records(_):return [dict(timestamp_ns=time.time_ns()-300000000,raw=raw)for _ in range(1 if app_gap else 3)]
            with ExitStack()as stack:
                for name,value in dict(preflight=lambda _: {},load=lambda _:model,sha256_file=lambda _:'fixture-hash',configure_peer=lambda *_:[],start_server=start_server,start_capture=start_capture,Session=Actor,pcap_records=records).items():stack.enter_context(patch.object(probe,name,value))
                stack.enter_context(patch('probe.os.readlink',side_effect=lambda n:('net:[isolated]'if'/self/'in str(n)else'net:[outer]')if str(n).startswith('/proc/')else original_readlink(n)))
                for name,value in [('open',123),('read',raw),('close',None)]:stack.enter_context(patch('probe.os.'+name,return_value=value))
                stack.enter_context(patch('probe.fcntl.ioctl'));stack.enter_context(patch('probe.select.select',side_effect=lambda *_:([123],[],[])if events.count('L.net.frame')<(1 if app_gap else 3)else([],[],[])))
                stack.enter_context(patch.object(sys,'argv',['probe','--out',str(destination),'--model','fixture','--executable','fixture','--parent-netns','net:[outer]','--mode','tcp-echo']))
                code=probe.main()
            r=json.loads((destination/'report.json').read_text())
            self.assertLess(timeline.index('capture-wait'),timeline.index('native-close'))
            self.assertLess(timeline.index('capture-wait'),timeline.index('server-control-close')if'server-control-close'in timeline else timeline.index('server-terminate'))
            return code,r,events

    def test_full_script_pumps_before_capture_stop_and_closes_after(self):
        code,r,events=self.exercise();self.assertEqual(code,0);self.assertTrue(r['full_TCP_exchange_complete']);self.assertFalse(r['whole_ipv4_endpoint_complete'])
        self.assertEqual([e for e in events if e!='L.net.frame'],['T.app.connect','T.app.send','T.app.transmit','T.app.receive','T.app.close'])
        self.assertEqual(events.count('L.net.frame'),3)

    def test_corrupt_peer_or_nonzero_exit_or_missing_stats_cannot_pass(self):
        for options in [dict(corrupt=True),dict(native_code=2),dict(peer_code=3),dict(missing_stats=True)]:
            code,r,_=self.exercise(**options);self.assertEqual(code,1);self.assertFalse(r['full_TCP_exchange_complete']);self.assertIsNotNone(r['error'])

    def test_model_rejection_is_failure_with_original_primary_category(self):
        code,r,_=self.exercise(app_gap=True);self.assertEqual(code,1);self.assertEqual(r['error']['category'],'model_gap');self.assertFalse(r['full_TCP_exchange_complete'])
