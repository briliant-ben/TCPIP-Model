"""Offline temporary copies only; not additional kernel executions."""
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest
rows=[]
for scenario in ('handshake','syn-loss'):
    source=HERE/scenario/'download'
    before={str(p.relative_to(source)):digest(p)for p in source.rglob('*')if p.is_file()}
    for fault,expected in [('reference','Rehashed reference evidence changed'),('checksum','Invalid TCP checksum'),
        ('short_window','Quiet observation window shortened'),('packet_cap','Capture was silently packet-count limited'),
        ('scenario','Execution/isolation incomplete')]:
        with tempfile.TemporaryDirectory(prefix='linux-two-case-fault-')as tmp:
            out=Path(tmp)/'copy';shutil.copytree(source,out);report=read(out/'report.json')
            if fault=='reference':
                value=read(out/'expected.json');value[1]['time_ms']=read(out/'observed.json')[1]['time_ms']
                write(out/'expected.json',value);changed=['expected.json']
            elif fault=='checksum':
                data=bytearray((out/'capture.pcap').read_bytes());data[-1]^=1
                (out/'capture.pcap').write_bytes(data);changed=['capture.pcap']
            else:
                value=read(out/'namespace.json')
                if fault=='short_window':
                    value['quiet_barrier_epoch_ns']=read(out/'metadata.json')['time_origin_ns']+10000000
                    report['observed_window_ms']=10
                elif fault=='packet_cap':value['capture_command'][1:1]=['-c','3']
                else:
                    other='syn-loss'if scenario=='handshake'else'handshake'
                    report['scenario_id']=other
                    report['loss_mechanism']='no peer response to first SYN; observed at egress'if other=='syn-loss'else'none'
                write(out/'namespace.json',value);changed=['namespace.json']
            for filename in changed:report['file_hashes'][filename]=digest(out/filename)
            write(out/'report.json',report)
            saved=read(out/'runtime-verification.json');saved['report_sha256']=digest(out/'report.json')
            write(out/'runtime-verification.json',saved)
            process=subprocess.run([sys.executable,str(ROOT/'ports/linux-netns/verify.py'),'--out',str(out),'--offline'],
                capture_output=True,text=True,timeout=30)
            log=HERE/scenario/(fault+'-rejected.log');log.write_text(process.stdout+process.stderr)
            assert process.returncode!=0 and expected in process.stderr,(scenario,fault,process.stderr)
            rows.append(dict(scenario=scenario,fault=fault,status='rejected_after_rehash',expected_failure=expected,
                log=str(log.relative_to(HERE)),log_sha256=digest(log)))
    assert all(digest(source/name)==sha for name,sha in before.items()),'Original evidence mutated'
write(HERE/'negative-controls.json',dict(status='ten_offline_faults_rejected',tests=rows,new_linux_execution=False,
    original_evidence_unchanged=True,checker_sha256=digest(ROOT/'ports/linux-netns/verify.py')))
print('Ten rehashed faults rejected; both original Linux evidence directories unchanged')
