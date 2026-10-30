"""Accept original CI provenance/bytes and the separately reconstructed bindings."""
from pathlib import Path
import json
import sys
import zipfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest
out=HERE/'download';prov=read(HERE/'provenance.json');artifact=prov['artifact']
assert prov['run']==41033653538 and prov['job']==123989120324 and prov['conclusion']=='success'
assert prov['source_head']=='e08d3fdb5df54f0c6950f072bd565aeb4ce9349a'
assert prov['merge_snapshot']=='7b4ebb610b870ac6d88bca6d7caca4afd08c85d5'
assert artifact['id']==12966748523 and artifact['workflow_run']['head_sha']==prov['source_head']
assert artifact['workflow_run']['head_branch']=='codex/tcp-modular'
assert artifact['name']=='rocq-generated-scalar-'+prov['merge_snapshot']
expected_zip='781b0065359e7f817d73928eaf92a246da020f4f9b16833b93df4493cb9cb1e6'
assert artifact['digest']=='sha256:'+expected_zip and digest(HERE/'workflow-artifact.zip')==expected_zip
with zipfile.ZipFile(HERE/'workflow-artifact.zip')as z:
    for name in z.namelist():
        if name.endswith('/'):continue
        p=Path(name);assert not p.is_absolute()and '..'not in p.parts
        assert z.read(name)==(out/p).read_bytes(),'Original CI entry changed: '+name
r=read(out/'result.json');offline=read(out/'offline-verification.json');negative=read(HERE/'negative-controls.json')
assert r['status']=='kernel_checked_generated_scalar_ir_execution'and r['kernel_checked_proof']and r['source_binding_checked']
assert offline['status']=='valid_retained_generated_scalar_execution_bindings'
assert offline['original_report_sha256']==digest(out/'result.json')
assert offline['checker_sha256']==digest(ROOT/'formal/rocq-scalar/verify.py')
assert not offline['kernel_rechecked_locally']and not offline['new_kernel_execution']
assert r['binding']['actions']==7 and r['binding']['invariants']==2
assert r['binding']['variables']==['left','right','offset','distance','roundtrip','advanced','restored']
assert r['binding']['fields']==['left','right','offset']
for name,sha in r['input_hashes'].items():assert digest(ROOT/name)==sha,name
for name,sha in r['artifact_hashes'].items():assert digest(out/name)==sha,name
assert (out/'positive-Proofs.log').read_text().count('Closed under the global context')==2
assert 'Axioms:'not in (out/'positive-Proofs.log').read_text()
kernel=(out/'independent-kernel.log').read_text()
assert 'Modules were successfully checked'in kernel
for name in ('checked_generated_initial','checked_generated_step'):assert name in kernel
for name in ('wrong-inverse','wrong-order'):
    text=(out/(name+'-Proofs.log')).read_text()
    assert 'File "./Proofs.v"'in text and 'Error: Not convertible.'in text
assert negative['status']=='six_offline_binding_faults_rejected'and negative['original_evidence_unchanged']
assert negative['source_report_sha256']==digest(out/'result.json')and not negative['new_kernel_execution']
assert negative['checker_sha256']==digest(ROOT/'formal/rocq-scalar/verify.py')
assert {x['fault']for x in negative['tests']}=={'object','lookup','narrowed-domain','statement','negative-source','scope'}
for row in negative['tests']:assert digest(HERE/row['log'])==row['log_sha256']
proof_files=['Semantics.v','Compiled.v','Proofs.v','Semantics.vo','Compiled.vo','Proofs.vo']
write(HERE/'acceptance.json',dict(status='retained_kernel_checked_generated_scalar_execution_accepted',
    source_head=prov['source_head'],merge_snapshot=prov['merge_snapshot'],ci_run=prov['run'],job=prov['job'],
    source_model_sha256=r['binding']['source_sha256'],model_semantic_sha256=r['binding']['model_semantic_sha256'],
    source_ordered_assignments=7,generated_equality_invariants=2,
    statements=['generated initial environment satisfies generated equalities',
        'forall initial environments and event values in declared seq32 domains, executing generated ordered assignments satisfies generated equalities'],
    integer_displacement_domain='unbounded Z; offset is not added to the seq32 field-domain list',
    original_ci_kernel_checked=True,empty_axiom_audits=2,local_kernel_recheck=False,new_kernel_execution=False,
    source_binding_is_kernel_proof=False,python_interpreter_proved=False,z3_translator_proved=False,
    tcp_protocol_proved=False,bytes_time_output_liveness_proved=False,linux_tcp_execution=False,full_protocol_complete=False,
    source_fault_controls=r['negative_controls'],axiom_control=r['axiom_injection'],
    proof_hashes={n:digest(out/n)for n in proof_files},negative_controls_sha256=digest(HERE/'negative-controls.json'),
    offline_verification_sha256=digest(out/'offline-verification.json'),original_report_sha256=digest(out/'result.json'),
    original_ci_zip_sha256=expected_zip,integrity_is_not_authenticity=True,
    trusted_components=r['trusted_components']+['GitHub runner/job/artifact provenance and original ZIP integrity'],
    scope='restricted generated scalar IR formal execution; source-to-constructor equality checked by trusted inverse Python parser, not a universal compiler/interpreter proof'))
print('Accepted actual generated scalar IR execution kernel evidence with reviewed statements, original CI bytes and six binding controls')
