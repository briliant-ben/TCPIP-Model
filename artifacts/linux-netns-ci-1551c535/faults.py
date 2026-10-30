"""Offline fault copies only; never count them as new Linux executions."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
SOURCE=HERE/'download'
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest
before={str(p.relative_to(SOURCE)):digest(p)for p in SOURCE.rglob('*')if p.is_file()}
results=[]
for name,expected in [('reference','Rehashed reference evidence changed'),('checksum','Invalid TCP checksum'),
                      ('short_window','Quiet observation window shortened'),('packet_cap','Capture was silently packet-count limited')]:
    with tempfile.TemporaryDirectory(prefix='linux-evidence-negative-')as tmp:
        out=Path(tmp)/'copy';shutil.copytree(SOURCE,out)
        report=read(out/'report.json')
        if name=='reference':
            value=read(out/'expected.json');value[1]['time_ms']=read(out/'observed.json')[1]['time_ms']
            write(out/'expected.json',value);changed=['expected.json']
        elif name=='checksum':
            data=bytearray((out/'capture.pcap').read_bytes());data[-1]^=1
            (out/'capture.pcap').write_bytes(data);changed=['capture.pcap']
        else:
            value=read(out/'namespace.json')
            if name=='short_window':
                value['quiet_barrier_epoch_ns']=read(out/'metadata.json')['time_origin_ns']+10000000
                report['observed_window_ms']=10
            else:value['capture_command'][1:1]=['-c','3']
            write(out/'namespace.json',value);changed=['namespace.json']
        for filename in changed:report['file_hashes'][filename]=digest(out/filename)
        write(out/'report.json',report)
        # Deliberately rebind the saved marker as well: semantic checks, not only hashes,
        # must reject. Authentic CI ZIP provenance is a separate external requirement.
        runtime=read(out/'runtime-verification.json');runtime['report_sha256']=digest(out/'report.json')
        write(out/'runtime-verification.json',runtime)
        command=[sys.executable,str(ROOT/'ports/linux-netns/verify.py'),'--out',str(out),'--offline']
        process=subprocess.run(command,capture_output=True,text=True,timeout=30)
        log=HERE/(name+'-rejected.log');log.write_text(process.stdout+process.stderr)
        assert process.returncode!=0 and expected in process.stderr,(name,process.stdout,process.stderr)
        results.append(dict(fault=name,status='rejected_even_after_rehash',expected_failure=expected,log_sha256=digest(log)))
assert all(digest(SOURCE/name)==sha for name,sha in before.items()),'Original evidence mutated'
write(HERE/'negative-controls.json',dict(status='four_offline_semantic_faults_rejected',
    tests=results,new_linux_execution=False,original_evidence_unchanged=True,
    report_sha256=digest(SOURCE/'report.json'),checker_sha256=digest(ROOT/'ports/linux-netns/verify.py'),
    trusted_CI_origin_checked_separately=True))
print('Four rehashed offline faults rejected; original Linux evidence unchanged')
