"""Generic live generated-C line ABI: one stdin PIPE, raw stdout PTY, one PID.

No model/reference/network logic. PTY is solely for libc line buffering; native
source/binary is unchanged. Transcript bytes/operation boundaries are retained.
"""
import errno
import json
import os
from pathlib import Path
import select
import subprocess
import time
import tty


class Session:
    def __init__(self,executable,out):
        self.out=Path(out);self.out.mkdir(parents=True,exist_ok=False)
        master,slave=os.openpty();tty.setraw(slave)
        self.master=master;self.buffer=b'';self.rows=[];self.ops=[];self.closed=False
        self.input=(self.out/'native-input.txt').open('wb');self.output=(self.out/'native.stdout').open('wb');self.stderr=(self.out/'native.stderr').open('wb')
        try:self.process=subprocess.Popen([str(executable)],stdin=subprocess.PIPE,stdout=slave,stderr=self.stderr,env={'PATH':''})
        finally:os.close(slave)
        self.started=time.monotonic_ns();self.snapshot=None
        try:self._exchange('B','ready')
        except Exception:
            self.process.kill();self.process.wait(timeout=5);self.closed=True
            os.close(self.master);self.input.close();self.output.close();self.stderr.close();self._metadata(self.process.returncode)
            raise

    def _line(self,deadline):
        while b'\n'not in self.buffer:
            remaining=deadline-time.monotonic()
            if remaining<=0 or not select.select([self.master],[],[],remaining)[0]:raise TimeoutError('Native live reply timeout')
            try:chunk=os.read(self.master,65536)
            except OSError as error:
                if error.errno==errno.EIO:chunk=b''
                else:raise
            if not chunk:raise ValueError('Native live stream closed before reply')
            self.output.write(chunk);self.output.flush();self.buffer+=chunk
            if len(self.buffer)>2*1024*1024:raise ValueError('Native live record capacity')
        line,self.buffer=self.buffer.split(b'\n',1);return json.loads(line)

    def _exchange(self,line,terminal='ok'):
        if self.closed or '\n'in line or '\r'in line or '\0'in line:raise ValueError('Invalid live ABI operation')
        start=len(self.rows);sent=time.monotonic_ns();data=(line+'\n').encode()
        self.input.write(data);self.input.flush();self.process.stdin.write(data);self.process.stdin.flush()
        deadline=time.monotonic()+5
        while True:
            row=self._line(deadline);self.rows.append(row)
            if row.get('status')in (terminal,'error'):
                self.snapshot=row['snapshot'];break
            if row.get('status')!='transition':raise ValueError('Unexpected live ABI reply')
        self.ops.append(dict(line=line,pid=self.process.pid,row_start=start,row_end=len(self.rows),sent_monotonic_ns=sent,reply_monotonic_ns=time.monotonic_ns()))
        self._metadata(None)
        return self.rows[start:]

    def operation(self,line):
        if not(line.startswith('D ')or line.startswith('T ')):raise ValueError('Live session permits no reset/replay')
        return self._exchange(line)

    def _metadata(self,code):
        report=dict(schema='native-live-session-v1',pid=self.process.pid,process_starts=1,transport='stdin-pipe-stdout-raw-pty',started_monotonic_ns=self.started,returncode=code,operations=self.ops)
        (self.out/'session.json').write_text(json.dumps(report,indent=2)+'\n')

    def close(self):
        if self.closed:return
        self.closed=True;code=None
        try:
            self.process.stdin.close();code=self.process.wait(timeout=5)
            # Drain PTY after EOF; trailing output must not disappear at close.
            while select.select([self.master],[],[],0)[0]:
                try:chunk=os.read(self.master,65536)
                except OSError as error:
                    if error.errno==errno.EIO:break
                    raise
                if not chunk:break
                self.output.write(chunk);self.output.flush();self.buffer+=chunk
            if self.buffer:raise ValueError('Trailing unaccounted native record')
        finally:
            if self.process.poll()is None:self.process.kill();self.process.wait(timeout=5)
            os.close(self.master);self.input.close();self.output.close();self.stderr.close();self._metadata(code)
        return code
