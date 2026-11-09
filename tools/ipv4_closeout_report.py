"""Read-only finite-prototype delivery accounting; never executes archived code.

Run from the repository root with its Python environment. A passing delivery is
NOT a complete-rule flow verdict or a whole-protocol/compiler proof.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import tarfile
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from protocol_lab.ir import load
from protocol_lab.pipeline.runner import verify
from protocol_lab.pipeline.coverage import summarize
from protocol_lab.pipeline.worker import compare_case
from protocol_lab.symbolic import model_hash,replay
from protocol_lab.codegen.execute import commands

ROOT=Path(__file__).resolve().parents[1]
MODEL_SHA='7d5a82541ea55cde3ff39b2e1cf883f6c9f942f5dc535a2736e69044d9e154a5'
C_SHA='19ce9855194a5d8b243648f12b710d739266f4d49ff31001e378c1815975e36b'
A_SHA='a10d6aea1ba1b8a17fe208155b856d6ec011b265495684ad1b6bb209df8277be'
DIRECTED='candidates/ipv4-control-cases-20261109-0176/'

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def read(p):return json.loads(Path(p).read_text())
def require(value,message):
    if not value:raise ValueError(message)


def report(flow,archive,manifest_path):
    model=load(ROOT/'model/ipv4-endpoint-virtual-link.json')
    require(sha(ROOT/'model/ipv4-endpoint-virtual-link.json')==MODEL_SHA,'Fixed model changed')
    flow=Path(flow);verified=verify(flow,ROOT,sha(ROOT/'flows/ipv4-prototype-closeout.json'))
    f=read(flow/'flow.json');stages=f['stages']
    require(stages['formal']['status']=='pass','Formal scope unresolved')
    require(all(v['status']=='pass'for n,v in stages.items()if n!='tests'),'Required stage failed')
    require(stages['tests']['status']in ('pass','unknown'),'Test generation failed')
    require(stages['formal']['data']['model_semantic_sha256']==model_hash(model),'Formal model differs')
    require(stages['formal']['data']['counts']['negative_answers']=={'sat':0,'unsat':563,'unknown':0},'Formal obligations differ')
    require(sha(archive)==A_SHA,'Original bundle changed')
    members=read(manifest_path)
    with tarfile.open(archive)as tar:
        entries=tar.getmembers()
        require(len(entries)==len(members)==824,'Original member set differs')
        require(len({m.name for m in entries})==len(entries),'Duplicate archived member')
        for m in entries:
            require(m.isfile()and m.name in members and not Path(m.name).is_absolute()and '..'not in Path(m.name).parts,'Unsafe original member')
            require(hashlib.sha256(tar.extractfile(m).read()).hexdigest()==members[m.name],'Original member hash differs')
        def raw(n):return tar.extractfile(DIRECTED+n).read()
        def data(n):return json.loads(raw(n))
        frozen=data('frozen-cases.json')
        require(raw('frozen-cases.json')==(ROOT/'scenarios/ipv4-closeout-directed/cases.json').read_bytes(),'Supplementary stimuli changed')
        require(data('status.json')['status']=='finite_modelderived_cases_pass_generator_review_required','Directed gate not completed')
        bindings=data('bindings.json')
        require(bindings['model_file_sha256']==MODEL_SHA and bindings['C_sha256']==C_SHA,'Directed subject changed')
        directed=data('results.json');require(len(directed)==len(frozen['cases'])==11,'Supplementary case omitted')
        for scene,row in zip(frozen['cases'],directed):
            name=scene['id'];require(row['id']==name and row['generator_purpose_met'],'Directed intent failed')
            ref=data(name+'/reference.json');observed=[json.loads(line)for line in raw(name+'/native.stdout').decode().splitlines()]
            require(hashlib.sha256(raw(name+'/native.stdout')).hexdigest()==row['stdout_sha256'],'Native stdout changed')
            require(hashlib.sha256(raw(name+'/native-input.txt')).hexdigest()==row['input_sha256'],'Native input changed')
            require(raw(name+'/native-input.txt').decode()==commands(model,scene),'Native stimulus differs from frozen data')
            negative=name in frozen['expected_rejections']
            require((ref['error']['classification']if ref['error']else None)==frozen['expected_rejections'].get(name),'Rejection scope changed')
            difference=compare_case(ref,observed,1 if negative else 0,negative)
            require(difference['status']=='pass'and difference==data(name+'/difference.json'),'Native/reference comparison failed')
            require(ref['final']['variables']['T.control']==frozen['intended_target_controls'][name],'Frozen control target failed')
            # Fixed-input report/witness remains a separate finite committed path, not rejection proof.
            require(row['fixed_Z3']['query']=='sat'and row['fixed_Z3']['status']=='match','Fixed Z3 path missing')
            proof=data(name+'/symbolic/result.json')
            require(proof['model_semantic_sha256']==model_hash(model)and proof['query']=='sat'and proof['status']=='match','Fixed Z3 model/verdict changed')
            require(hashlib.sha256(raw(name+'/symbolic/path.smt2')).hexdigest()==proof['smt2_sha256'],'Fixed query changed')
            require(replay(model,proof['witness'])==proof['replay'],'Original witness no longer strictly replays')
            require(len(proof['witness']['steps'])==len(ref['trace']),'Fixed path length differs')
            for step,observed_step in zip(proof['witness']['steps'],ref['trace']):
                require((step['at_ms'],step['transition'],step['event'],step['fields'],step['after'],step['emitted'])==
                        (observed_step['time_ms'],observed_step['transition'],observed_step['event']['name'],observed_step['event']['fields'],observed_step['after'],observed_step['emitted']),
                        'Witness is not the original observed path')

    network=ROOT/'artifacts/ipv4-prototype-final-9289';live=read(network/'readonly-audit.json')
    require(live['status']=='finite_same_process_IPv4_observation_verified','Live observation was not accepted')
    require(sha(network/'linux-peer-original.zip')==live['linux_zip_sha256'],'Live original changed')
    require(sha(network/'flow-original.tar.gz')==live['flow_tar_sha256'],'Old flow original changed')
    require(live['model_file_sha256']==MODEL_SHA and live['generated_C_sha256']==C_SHA,'Live subject differs')
    old=read(ROOT/'artifacts/ipv4-closeout-20261108/execution-coverage-with-legacy.json')
    records=old['records'][:]
    for row in directed:
        records.append(dict(key='directed-'+row['id'],origin='model_generated_rejection'if row['negative']else'model_generated',
                            initial_override=False,status='pass',transitions=row['transitions']))
    coverage=summarize([r['id']for r in model['transitions']],records)
    return dict(schema='finite-ipv4-delivery-v1',status='finite_ipv4_prototype_delivery_pass',
                model_file_sha256=MODEL_SHA,generated_C_sha256=C_SHA,
                formal=stages['formal']['data']['counts'],flow_verification=verified,
                flow_assessment=f['assessment'],old_UNKNOWN_unchanged=True,
                literal_seed_cases=66,directed_cases=len(directed),coverage=coverage,records=records,
                all_335_rule_obligations_closed=False,unobserved_rule_disposition='open execution-coverage gap; not proved unreachable',
                live=dict(source_commit=live['source_commit'],native_pid=live['native_pid'],capture=live['capture'],
                          quiet_ms=live['quiet_ms'],original_sha256=live['linux_zip_sha256'],new_execution=False),
                original_bundle_sha256=A_SHA,original_files_checked=len(members),
                archived_code_ELF_solver_executed=False,
                authenticity='Relies on original controlled execution/CI provenance; hashes establish consistency, not execution attestation',
                scope='Finite published fixed-endpoint prototype only; no deeper/all-state/wire/compiler/full-RFC proof or physical Ethernet')


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--flow',type=Path,required=True)
    p.add_argument('--originals',type=Path,required=True);p.add_argument('--members',type=Path,required=True);p.add_argument('--out',type=Path,required=True)
    a=p.parse_args();r=report(a.flow,a.originals,a.members);a.out.write_text(json.dumps(r,indent=2)+'\n')
    print(json.dumps({'status':r['status'],'flow':r['flow_assessment'],'covered':len(r['coverage']['covered_overall']),'rules':335}))

if __name__=='__main__':main()
