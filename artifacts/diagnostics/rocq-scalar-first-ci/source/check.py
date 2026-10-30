"""Compile generated IR execution statements; structural source bridge remains trusted."""
import argparse
import copy
import importlib.util
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))

def module(name,path):
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
base=module('scalar_checker_base',ROOT/'formal/rocq/check.py')
generator=module('scalar_constructor_binding',HERE/'compile.py')
from protocol_lab.ir import Machine,ModelError


def check(out,model_file,docker=False):
    out=Path(out).resolve();out.mkdir(parents=True,exist_ok=True)
    if (out/'result.json').exists():raise ValueError('Use a fresh evidence directory')
    paths=[p for p in HERE.iterdir()if p.is_file()and p.suffix in ('.py','.v','.md')]
    paths +=[model_file,ROOT/'formal/rocq/check.py',ROOT/'protocol_lab/ir.py',ROOT/'protocol_lab/symbolic.py',ROOT/'docs/semantics.md',ROOT/'.github/workflows/rocq-scalar.yml']
    r=dict(status='incomplete',kernel_checked_proof=False,source_binding_checked=False,commands=[],
        image=base.IMAGE if docker else None,axiom_allowlist=[],theorems=['checked_generated_initial','checked_generated_step'],
        input_hashes={str(p.relative_to(ROOT)):base.digest(p)for p in paths},
        scope='actual generated single-state ordered scalar IR execution and equality invariants; current contract proof body',
        trusted_components=['Rocq kernel/standard library and pinned toolchain','formal scalar-fragment denotation',
            'Python source type/fragment validation and inverse constructor binding checker','orchestration and assumption audit'],
        source_binding_is_kernel_proof=False,python_interpreter_proved=False,z3_translator_proved=False,
        tcp_protocol_proved=False,liveness_proved=False,linux_execution=False,full_protocol_complete=False)
    def save(): (out/'result.json').write_text(json.dumps(r,indent=2)+'\n')
    save()
    try:
        r['binding']=generator.generate(model_file,out)
        source=json.loads(model_file.read_text());generator.verify_text(source,(out/'Compiled.v').read_text())
        r['source_binding_checked']=True
    except ValueError as error:
        r.update(status='unsupported_source_or_binding_failure',reason=str(error));save();return 1
    if not shutil.which('docker'if docker else'rocq'):
        r.update(status='not_run',reason='docker executable unavailable'if docker else'rocq executable unavailable');save();return 2
    def workspace(label,model):
        work=Path(tempfile.mkdtemp(prefix=label+'-',dir=out));work.chmod(0o777)
        for name in ('Semantics.v','Proofs.v'):shutil.copyfile(HERE/name,work/name)
        (work/'Compiled.v').write_text(generator.render(model))
        generator.verify_text(model,(work/'Compiled.v').read_text())
        return work
    def run(work,name,args,required=True):
        prefix=['docker','run','--rm','--network','none','--volume',str(work)+':/proof','--workdir','/proof',base.IMAGE]if docker else[]
        result=subprocess.run(prefix+args,cwd=work,capture_output=True,text=True,timeout=180)
        text=result.stdout+result.stderr;(out/(name+'.log')).write_text(text)
        r['commands'].append(dict(command=args,container_prefix=prefix,returncode=result.returncode,log=name+'.log'))
        if required and result.returncode:raise RuntimeError(name+' failed: '+text)
        return result.returncode,text
    work=None;all_work=[]
    try:
        work=workspace('positive',source);all_work.append(work)
        _,version=run(work,'version',['rocq','compile','--version']);r['checker_version']=version.strip()
        if not re.search(r'version 9\.2(?:\.0)?(?:\s|$)',version):raise RuntimeError('Expected Rocq9.2')
        if docker:
            _,version=run(work,'package-version',['opam','var','rocq-runtime:version']);r['checker_package_version']=version.strip()
            if version.strip()!='9.2.0':raise RuntimeError('Expected locked runtime9.2.0')
        for name in ('Semantics','Compiled'):run(work,'positive-'+name,['rocq','compile','-Q','.','ScalarIR',name+'.v'])
        _,audit=run(work,'positive-Proofs',['rocq','compile','-Q','.','ScalarIR','Proofs.v'])
        if not base.closed(audit,2):raise RuntimeError('Missing closed theorem audit or unapproved axiom')
        run(work,'independent-kernel',['rocq','check','-Q','.','ScalarIR','ScalarIR.Semantics','ScalarIR.Compiled','ScalarIR.Proofs'])
        negatives={}
        for name in ('wrong-inverse','wrong-order'):
            variant=copy.deepcopy(source);actions=variant['transitions'][0]['actions']
            if name=='wrong-inverse':actions[-1]['set']['value']['args'][1]={'var':'offset'}
            else:actions[3],actions[4]=actions[4],actions[3]
            try:Machine(variant).dispatch('probe',dict(left=0,right=1,offset=1),0)
            except ModelError as error:
                if 'Invariant failed'not in str(error):raise
                witness=dict(fields=dict(left=0,right=1,offset=1),reference_rejection=str(error))
            else:raise RuntimeError('Expected source IR mutation did not violate invariant')
            bad=workspace(name,variant);all_work.append(bad)
            for unit in ('Semantics','Compiled'):run(bad,name+'-'+unit,['rocq','compile','-Q','.','ScalarIR',unit+'.v'])
            code,_=run(bad,name+'-Proofs',['rocq','compile','-Q','.','ScalarIR','Proofs.v'],False)
            if code==0 or (bad/'Proofs.vo').exists():raise RuntimeError('False source-model execution theorem accepted')
            target=out/'negative'/name;target.mkdir(parents=True)
            (target/'model.json').write_text(json.dumps(variant,indent=2)+'\n')
            shutil.copyfile(bad/'Compiled.v',target/'Compiled.v')
            negatives[name]=dict(status='generated_module_compiles_but_execution_proof_rejected',**witness)
        (work/'AxiomProbe.v').write_text('Axiom injected : False. Print Assumptions injected.\n')
        _,audit=run(work,'reject-axiom',['rocq','compile','AxiomProbe.v'])
        if base.closed(audit,1)or'Axioms:'not in audit:raise RuntimeError('Axiom injection audit failed')
        for name in ('Semantics.v','Proofs.v','Semantics.vo','Compiled.vo','Proofs.vo'):shutil.copyfile(work/name,out/name)
        if generator.render(source)!=(out/'Compiled.v').read_text():raise RuntimeError('Generated source changed')
        r.update(status='kernel_checked_generated_scalar_ir_execution',kernel_checked_proof=True,negative_controls=negatives,
            axiom_injection='rejected_by_audit',proof_statement='forall initial environments and typed scalar event fields, executing generated ordered assignments satisfies generated equalities; generated initial state also satisfies them')
    except (OSError,RuntimeError,subprocess.TimeoutExpired,ValueError)as error:r.update(status='failed',reason=str(error))
    finally:
        for folder in all_work:shutil.rmtree(folder)
    if any(base.digest(ROOT/p)!=h for p,h in r['input_hashes'].items()):r.update(status='source_changed',kernel_checked_proof=False)
    r['artifact_hashes']={str(p.relative_to(out)):base.digest(p)for p in sorted(out.rglob('*'))if p.is_file()and p.name!='result.json'}
    save();print(r['status']);return 0 if r['kernel_checked_proof']and r['status']=='kernel_checked_generated_scalar_ir_execution'else 1


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--docker',action='store_true')
    parser.add_argument('--model',type=Path,default=ROOT/'model/seq32-contract.json')
    parser.add_argument('--out',type=Path,default=ROOT/'artifacts/rocq-scalar')
    args=parser.parse_args();raise SystemExit(check(args.out.resolve(),args.model.resolve(),args.docker))
