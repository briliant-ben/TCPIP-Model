"""Offline source/object/log bindings only; original CI provenance is separate."""
import argparse
import copy
import importlib.util
import json
from pathlib import Path
import re

ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent

def module(name,path):
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
base=module('bytes_offline_utilities',ROOT/'formal/rocq/check.py')
generator=module('bytes_offline_binding',HERE/'compile.py')


def verify(out):
    out=Path(out).resolve();r=json.loads((out/'result.json').read_text())
    if r['status']!='kernel_checked_generated_bytes_ir_execution'or not r['kernel_checked_proof']or not r['source_binding_checked']:
        raise ValueError('No successful generated-execution kernel evidence')
    if r['image']!=base.IMAGE or r['checker_package_version']!='9.2.0'or not re.search(r'version 9\.2(?:\.0)?(?:\s|$)',r['checker_version']):
        raise ValueError('Pinned toolchain changed')
    if r['axiom_allowlist']!=[]or r['theorems']!=['checked_generated_initial','checked_generated_step']:
        raise ValueError('Claimed statement or axiom scope changed')
    mandatory={'formal/rocq-bytes/'+n for n in ('compile.py','check.py','Semantics.v','Proofs.v','README.md')}
    mandatory|={'model/bytes-contract.json','formal/rocq/check.py','protocol_lab/ir.py','protocol_lab/symbolic.py','docs/semantics.md','.github/workflows/rocq-bytes.yml'}
    if not mandatory<=set(r['input_hashes'])or set(r['input_hashes'])-mandatory-{'formal/rocq-bytes/verify.py'}:
        raise ValueError('Source coverage changed')
    for name,sha in r['input_hashes'].items():
        p=(ROOT/name).resolve()
        if not p.is_relative_to(ROOT)or base.digest(p)!=sha:raise ValueError('Source changed: '+name)
    required={'Compiled.v','Semantics.v','Proofs.v','Compiled.vo','Semantics.vo','Proofs.vo','binding.json',
        'positive-Proofs.log','independent-kernel.log','reject-axiom.log'}
    if not required<=set(r['artifact_hashes']):raise ValueError('Missing generated proof evidence')
    for name,sha in r['artifact_hashes'].items():
        p=(out/name).resolve()
        if not p.is_relative_to(out)or base.digest(p)!=sha:raise ValueError('Artifact changed: '+name)
    for name in ('Semantics.v','Proofs.v'):
        if (out/name).read_bytes()!=(HERE/name).read_bytes():raise ValueError('Reviewed formal semantics/statement changed')
    model_file=ROOT/'model/bytes-contract.json';model=json.loads(model_file.read_text())
    if base.digest(model_file)!=r['binding']['source_sha256']or generator.sha(HERE/'compile.py')!=r['binding']['checker_sha256']:
        raise ValueError('Source binding changed')
    binding=generator.verify_text(model,(out/'Compiled.v').read_text())
    for name in ('variables','fields','actions','invariants','model_semantic_sha256'):
        if binding[name]!=r['binding'][name]:raise ValueError('Generated binding relabelled')
    if base.digest(out/'Compiled.v')!=r['binding']['generated_sha256']:raise ValueError('Generated module changed')
    commands={c['log']:c for c in r['commands']}
    if len(commands)!=len(r['commands']):raise ValueError('Duplicate command/log evidence')
    if json.loads((out/'binding.json').read_text())!=r['binding']:raise ValueError('Standalone source binding differs')
    for log in ('version.log','package-version.log','positive-Semantics.log','positive-Compiled.log','positive-Proofs.log','independent-kernel.log'):
        if log not in commands or commands[log]['returncode']!=0:raise ValueError('Compilation/kernel stage incomplete')
    if not base.closed((out/'positive-Proofs.log').read_text(),2):raise ValueError('Execution statement has axioms or missing audit')
    if commands['independent-kernel.log']['command']!=['rocq','check','-Q','.','ByteIR','ByteIR.Semantics','ByteIR.Compiled','ByteIR.Proofs']:
        raise ValueError('Independent kernel command changed')
    for name in ('wrong-count','wrong-order'):
        neg=r['negative_controls'][name]
        if neg['status']!='generated_module_compiles_but_execution_proof_rejected':raise ValueError('Source-model negative not checked')
        for unit in ('Semantics','Compiled'):
            if commands[name+'-'+unit+'.log']['returncode']!=0:raise ValueError('Negative rejected before generated data compilation')
        if commands[name+'-Proofs.log']['returncode']==0:raise ValueError('False model proof was accepted')
        changed=json.loads((out/'negative'/name/'model.json').read_text())
        expected=copy.deepcopy(model);actions=expected['transitions'][0]['actions']
        if name=='wrong-count':actions[2]['set']['value']['args'][2]=0
        else:actions[0],actions[1]=actions[1],actions[0]
        if changed!=expected:raise ValueError('Negative IR differs from the declared source mutation')
        generator.verify_text(changed,(out/'negative'/name/'Compiled.v').read_text())
        if neg['fields']!=dict(data=[0,255],offset=1)or'Invariant failed'not in neg['reference_rejection']:
            raise ValueError('Missing legal source fault witness')
        from protocol_lab.ir import Machine,ModelError
        try:Machine(changed).dispatch('probe',neg['fields'],0)
        except ModelError as error:
            if str(error)!=neg['reference_rejection']:raise ValueError('Source fault witness changed')
        else:raise ValueError('Claimed source mutation has no invariant failure')
    if r['axiom_injection']!='rejected_by_audit'or'Axioms:'not in (out/'reject-axiom.log').read_text():
        raise ValueError('Axiom negative not checked')
    if any(r[key]for key in ('source_binding_is_kernel_proof','python_interpreter_proved','z3_translator_proved','tcp_protocol_proved','liveness_proved','linux_execution','full_protocol_complete')):
        raise ValueError('Generated fragment claim broadened')
    result=dict(status='valid_retained_generated_bytes_execution_bindings',source_model_sha256=base.digest(model_file),
        original_report_sha256=base.digest(out/'result.json'),checker_sha256=base.digest(Path(__file__)),
        source_constructor_binding=binding,kernel_rechecked_locally=False,new_kernel_execution=False,
        provenance_and_original_zip_required=True,integrity_is_not_authenticity=True,
        source_binding_is_kernel_proof=False,python_interpreter_proved=False,z3_translator_proved=False,tcp_protocol_proved=False,
        scope='source/constructor, reviewed statements, existing compiler/kernel/audit logs and immutable object hash bindings')
    (out/'offline-verification.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    args=parser.parse_args();print(verify(args.out)['status'])
