"""Offline temporary-copy controls; no new kernel execution or authentic CI claim."""
from pathlib import Path
import json
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
assert before,'Actual CI snapshot required'
rows=[]
for fault,expected in [('object','Artifact changed'),('lookup','does not match complete ordered source IR'),
    ('narrowed-domain','does not match complete ordered source IR'),('statement','Reviewed formal semantics/statement changed'),
    ('negative-source','Negative IR differs'),('scope','Generated fragment claim broadened')]:
    with tempfile.TemporaryDirectory(prefix='bytes-proof-negative-')as tmp:
        out=Path(tmp)/'copy';shutil.copytree(SOURCE,out);r=read(out/'result.json');changed=[]
        if fault=='object':
            path=out/'Proofs.vo';data=bytearray(path.read_bytes());data[-1]^=1;path.write_bytes(data)
            # Deliberately retain the original hash: this is an integrity test, not
            # a local semantic recheck of a rehashed binary object.
        elif fault in ('lookup','narrowed-domain'):
            path=out/'Compiled.v';text=path.read_text()
            text=text.replace('(BVar 2%nat)','(BVar 3%nat)',1)if fault=='lookup'else text.replace('compiled_int_fields : list nat := [1%nat]','compiled_int_fields : list nat := []')
            assert text!=path.read_text();path.write_text(text);changed=['Compiled.v','binding.json']
            r['binding']['generated_sha256']=digest(path);write(out/'binding.json',r['binding'])
        elif fault=='statement':
            path=out/'Proofs.v';text=path.read_text();modified=text.replace('    fields ints) compiled_invariants.','    fields ints) ([] : list (bexpr * bexpr)).',1)
            assert modified!=text;path.write_text(modified);changed=['Proofs.v']
        elif fault=='negative-source':
            write(out/'negative/wrong-order/model.json',read(ROOT/'model/bytes-contract.json'))
            shutil.copyfile(out/'Compiled.v',out/'negative/wrong-order/Compiled.v')
            changed=['negative/wrong-order/model.json','negative/wrong-order/Compiled.v']
        else:r['python_interpreter_proved']=True
        for name in changed:r['artifact_hashes'][name]=digest(out/name)
        write(out/'result.json',r)
        p=subprocess.run([sys.executable,str(ROOT/'formal/rocq-bytes/verify.py'),'--out',str(out)],capture_output=True,text=True,timeout=30)
        log=HERE/(fault+'-rejected.log');log.write_text(p.stdout+p.stderr)
        assert p.returncode!=0 and expected in p.stderr,(fault,p.stdout,p.stderr)
        rows.append(dict(fault=fault,status='rejected',semantic_metadata_rehashed=fault!='object',expected_failure=expected,log=log.name,log_sha256=digest(log)))
assert all(digest(SOURCE/n)==sha for n,sha in before.items()),'Original snapshot changed'
write(HERE/'negative-controls.json',dict(status='six_offline_binding_faults_rejected',tests=rows,original_evidence_unchanged=True,
    new_kernel_execution=False,source_report_sha256=digest(SOURCE/'result.json'),checker_sha256=digest(ROOT/'formal/rocq-bytes/verify.py'),
    object_rehash_requires_original_zip_provenance_or_real_kernel_recheck=True))
print('Six offline binding faults rejected; original proof snapshot unchanged; no local kernel rerun')
