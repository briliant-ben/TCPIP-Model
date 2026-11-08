"""Ordinary UDP socket and iputils peers; never a subject protocol model."""
import json
import os
from pathlib import Path
import re
import socket
import subprocess
import time


def ping_summary(text):
    rows = re.findall(r'^(\d+) packets transmitted, (\d+) (?:packets )?received, [^\n]*?(\d+(?:\.\d+)?)% packet loss[^\n]*$', text, re.M)
    if len(rows) != 1 or (int(rows[0][0]), int(rows[0][1]), float(rows[0][2])) != (1, 1, 0):
        raise ValueError('Expected exactly one ping summary: 1 sent/1 received/0% loss')
    return dict(transmitted=1, received=1, loss_percent=0)


class ServicePeers:
    def __init__(self, out, config):
        self.out, self.config = Path(out), config
        self.out.mkdir(exist_ok=False)
        self.received, self.completed, self.pings, self.current = [], [], [], None
        self.udp = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        try:
            self.udp.bind((config['peer']['ip'], config['peer']['port']))
        except Exception:
            self.udp.close();raise
        self.closed = False

    def alive(self):
        if self.closed or self.udp.fileno() < 0 or any(p['process'].poll() is not None for p in self.pings):
            raise RuntimeError('UDP socket or ping peer ended before capture')

    def begin_udp(self, index):
        self.alive()
        if self.current is not None or index != len(self.completed) or not 0 <= index < len(self.config['payloads']):
            raise ValueError('Unexpected UDP trial order')
        self.current = index

    def receive_udp(self):
        self.alive()
        if self.current is None or len(self.received) != self.current:
            raise ValueError('Unexpected or duplicated UDP peer delivery')
        payload, address = self.udp.recvfrom(65535)
        row = dict(index=self.current, hex=payload.hex(), source=list(address), received_monotonic_ns=time.monotonic_ns())
        self.received.append(row)
        if address != (self.config['subject']['ip'], self.config['subject']['port']):
            raise ValueError('UDP peer source tuple mismatch')
        if payload.hex() != self.config['payloads'][self.current]['hex']:
            raise ValueError('Independent UDP peer payload mismatch')
        sent = self.udp.sendto(payload, address)
        row.update(echo_bytes=sent, echoed_monotonic_ns=time.monotonic_ns())
        if sent != len(payload): raise ValueError('Incomplete ordinary UDP echo')

    def finish_udp(self):
        if self.current is None or len(self.received) != self.current+1 or self.received[-1].get('echo_bytes') != len(bytes.fromhex(self.config['payloads'][self.current]['hex'])):
            raise ValueError('Missing independent UDP echo receipt')
        self.completed.append(self.current);self.current = None

    def start_ping(self, index):
        self.alive()
        if index != len(self.pings) or not 0 <= index < len(self.config['echoes']):
            raise ValueError('Unexpected ICMP trial order')
        case = self.config['echoes'][index]
        command = ['ping','-4','-n','-I',self.config['peer']['ip'],'-M','do','-i','3600','-W','3','-s',str(case['data_bytes']),'-p',self.config['pattern'],self.config['subject']['ip']]
        stdout = (self.out/('ping-'+str(index)+'.stdout')).open('w')
        try:
            stderr = (self.out/('ping-'+str(index)+'.stderr')).open('w')
        except Exception:
            stdout.close();raise
        try:
            process = subprocess.Popen(command, stdin=subprocess.DEVNULL, stdout=stdout, stderr=stderr, env=dict(os.environ, LC_ALL='C'))
        except Exception:
            stdout.close();stderr.close();raise
        self.pings.append(dict(process=process, stdout=stdout, stderr=stderr, receipt=dict(index=index, command=command, pid=process.pid, started_monotonic_ns=time.monotonic_ns())))

    def finish_after_capture(self, capture_exit_ns, abort=False):
        if type(capture_exit_ns) is not int or not 0 < capture_exit_ns <= time.monotonic_ns():
            raise ValueError('Confirmed prior capture exit required')
        if self.closed: raise ValueError('Peer cleanup cannot be repeated')
        errors = []
        try:
            self.alive()
        except Exception as error:
            errors.append(str(error))
        if not abort and (self.completed != [0,1,2] or len(self.pings) != 3):
            errors.append('Incomplete UDP/ICMP peer trials')
        trials = []
        for item in self.pings:
            process, receipt = item['process'], item['receipt']
            try:
                receipt['stop_request_monotonic_ns'] = time.monotonic_ns()
                if process.poll() is None: process.send_signal(15 if abort else 2)
                receipt['returncode'] = process.wait(timeout=5)
            except Exception as error:
                errors.append(str(error))
                try:
                    process.kill();receipt['returncode'] = process.wait(timeout=5)
                except Exception as cleanup_error:
                    errors.append(str(cleanup_error))
            finally:
                for handle in (item['stdout'], item['stderr']):
                    try: handle.close()
                    except Exception as close_error: errors.append(str(close_error))
            receipt['exit_monotonic_ns'] = time.monotonic_ns()
            if not abort:
                try:
                    if receipt.get('returncode') != 0: raise ValueError('Ping nonzero exit')
                    receipt['summary'] = ping_summary((self.out/('ping-'+str(receipt['index'])+'.stdout')).read_text())
                except Exception as error:
                    errors.append(str(error))
            trials.append(receipt)
        try: self.udp.close()
        except Exception as close_error: errors.append(str(close_error))
        self.closed = True
        result = dict(status='aborted' if abort else 'failed' if errors else 'finite_service_peer_pass', capture_exit_monotonic_ns=capture_exit_ns, received=self.received, completed=self.completed, trials=trials, closed_monotonic_ns=time.monotonic_ns(), errors=errors, whole_ipv4_endpoint_complete=False)
        (self.out/'result.json').write_text(json.dumps(result, indent=2)+'\n')
        if errors and not abort: raise RuntimeError('Independent service peer failed: '+str(errors))
        return result


def run_service_trials(peers, operation, pump, emitted, links, clock):
    """Finite application stimuli and observation waits, never protocol actions."""
    def checked(result):
        if result is not None and result['status'] == 'error':
            raise RuntimeError('Subject operation rejected: '+result['failure'])
    for i, case in enumerate(peers.config['payloads']):
        start = len(emitted);peers.begin_udp(i)
        checked(operation(dict(event='L.app.send', fields=dict(data=list(bytes.fromhex(case['hex']))))))
        deadline = clock()+4
        while not any(item['message']=='L.udp.rx' for item in emitted[start:]):
            if clock() >= deadline: raise TimeoutError('Independent UDP echo/subject delivery timeout')
            checked(pump(deadline))
        deliveries = [item for item in emitted[start:] if item['message']=='L.udp.rx']
        if deliveries != [dict(message='L.udp.rx', fields=dict(data=list(bytes.fromhex(case['hex']))))]:
            raise ValueError('Subject UDP delivery differs from frozen payload')
        peers.finish_udp()
    def count():
        frames = [bytes.fromhex(item['raw']) for item in links]
        return sum(len(raw)>=34 and raw[12:14]==b'\x08\x00' and raw[23]==1 for raw in frames)
    for i, case in enumerate(peers.config['echoes']):
        before = count();peers.start_ping(i);deadline = clock()+4
        while count() < before+2:
            if clock() >= deadline: raise TimeoutError('ICMP link exchange timeout')
            checked(pump(deadline))
    # Counting ICMP observations only bounds stimulation. Independent original
    # byte/checksum comparison and each ping's receipt remain mandatory later.
