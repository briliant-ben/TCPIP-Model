"""Independent ordinary Linux TCP peer. No IR imports or packet encoders."""
import argparse
import json
import socket
import time
from pathlib import Path

def serve(out,ip,port,count):
    listener=None;connection=None;events=[]
    def event(kind,**fields):
        row=dict(event=kind,monotonic_ns=time.monotonic_ns(),**fields);events.append(row)
        with(out/'server-events.jsonl').open('a')as log:log.write(json.dumps(row)+'\n')
    try:
        listener=socket.socket(socket.AF_INET,socket.SOCK_STREAM);listener.bind((ip,port));listener.listen(1);listener.settimeout(20);event('listening',address=[ip,port])
        connection,address=listener.accept();connection.settimeout(20);event('accepted',address=list(address))
        received=b''
        while len(received)<count:
            data=connection.recv(count-len(received))
            if not data:raise ValueError('EOF before declared receive count')
            received+=data
        event('received',hex=received.hex());connection.sendall(received);event('echo_sent',hex=received.hex())
        extra=connection.recv(1)
        if extra:raise ValueError('Unexpected bytes after finite exchange')
        event('eof');connection.shutdown(socket.SHUT_WR);event('write_shutdown')
        # Keep both socket descriptors and process alive until driver closes the
        # control pipe, strictly after independent capture has stopped.
        import sys
        if sys.stdin.buffer.read(1):raise ValueError('Unexpected control input')
        event('close_requested')
    except Exception as error:
        event('failed',type=type(error).__name__,reason=str(error));raise
    finally:
        if connection is not None:connection.close()
        if listener is not None:listener.close()
        event('closed')

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--ip',required=True);p.add_argument('--port',type=int,required=True);p.add_argument('--count',type=int,required=True);a=p.parse_args();serve(a.out,a.ip,a.port,a.count)
