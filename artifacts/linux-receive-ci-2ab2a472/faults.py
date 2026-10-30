"""Offline mutations of temporary copies only; never additional Linux evidence."""
from pathlib import Path
import shutil
import struct
import subprocess
import sys
import tempfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
SOURCE=HERE/'download'
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest


def valid_payload_fault(path):
    data=bytearray(path.read_bytes())
    endian={b'\xd4\xc3\xb2\xa1':'<',b'\x4d\x3c\xb2\xa1':'<',b'\xa1\xb2\xc3\xd4':'>',b'\xa1\xb2\x3c\x4d':'>'}[bytes(data[:4])]
    assert struct.unpack_from(endian+'I',data,20)[0]==113
    offset=24
    while offset<len(data):
        _,_,size,_=struct.unpack_from(endian+'IIII',data,offset)
        ip=offset+16+16;ihl=(data[ip]&15)*4;tcp=ip+ihl
        total=int.from_bytes(data[ip+2:ip+4],'big');tcp_size=total-ihl;header=(data[tcp+12]>>4)*4
        if tcp_size-header==4:
            assert data[tcp+header:tcp+tcp_size]==bytes(4)
            data[tcp+header]=1;data[tcp+16:tcp+18]=bytes(2)
            wire=bytes(data[ip+12:ip+20])+bytes([0,6])+tcp_size.to_bytes(2,'big')+bytes(data[tcp:tcp+tcp_size])
            if len(wire)%2:wire+=b'\0'
            summed=sum(int.from_bytes(wire[i:i+2],'big')for i in range(0,len(wire),2))
            while summed>>16:summed=(summed&65535)+(summed>>16)
            data[tcp+16:tcp+18]=((~summed)&65535).to_bytes(2,'big')
            path.write_bytes(data);return
        offset+=16+size
    raise ValueError('No four-octet frame to mutate')


before={str(p.relative_to(SOURCE)):digest(p)for p in SOURCE.rglob('*')if p.is_file()}
assert before,'Original CI evidence required'
rows=[]
for fault,expected in [('payload','Captured receive stimuli differ'),('reference','Rehashed reference evidence changed'),
    ('policy','Driver/observation policy changed'),('checksum','Invalid TCP checksum'),('quiet','Quiet observation window shortened')]:
    with tempfile.TemporaryDirectory(prefix='linux-receive-fault-')as tmp:
        out=Path(tmp)/'copy';shutil.copytree(SOURCE,out);report=read(out/'report.json')
        if fault=='payload':
            valid_payload_fault(out/'capture.pcap');changed=['capture.pcap']
        elif fault=='checksum':
            data=bytearray((out/'capture.pcap').read_bytes());data[-1]^=1
            (out/'capture.pcap').write_bytes(data);changed=['capture.pcap']
        elif fault=='reference':
            value=read(out/'expected.json');value[3]['payload'][0]=1
            write(out/'expected.json',value);changed=['expected.json']
        elif fault=='policy':
            value=read(out/'driver-policy.json');value[2]['role']='omitted_from_oracle'
            write(out/'driver-policy.json',value);changed=['driver-policy.json']
        else:
            value=read(out/'namespace.json')
            value['quiet_barrier_epoch_ns']=read(out/'metadata.json')['time_origin_ns']+10000000
            report['observed_window_ms']=10;write(out/'namespace.json',value);changed=['namespace.json']
        for name in changed:report['file_hashes'][name]=digest(out/name)
        write(out/'report.json',report)
        saved=read(out/'runtime-verification.json');saved['report_sha256']=digest(out/'report.json')
        write(out/'runtime-verification.json',saved)
        p=subprocess.run([sys.executable,str(ROOT/'ports/linux-netns/verify.py'),'--out',str(out),'--offline'],capture_output=True,text=True,timeout=60)
        log=HERE/(fault+'-rejected.log');log.write_text(p.stdout+p.stderr)
        assert p.returncode!=0 and expected in p.stderr,(fault,p.stdout,p.stderr)
        rows.append(dict(fault=fault,status='rejected_after_rehash',expected_failure=expected,log=log.name,log_sha256=digest(log)))
assert all(digest(SOURCE/n)==h for n,h in before.items()),'Original evidence changed'
write(HERE/'negative-controls.json',dict(status='five_receive_faults_rejected',tests=rows,
    checksum_valid_payload_fault=True,original_evidence_unchanged=True,new_linux_execution=False,
    checker_sha256=digest(ROOT/'ports/linux-netns/verify.py'),report_sha256=digest(SOURCE/'report.json')))
print('Five rehashed receive faults rejected, including a valid-checksum wrong payload; original capture unchanged')
