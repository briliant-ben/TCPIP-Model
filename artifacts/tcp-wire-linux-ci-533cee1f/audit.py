"""Read-only Git-bound native evidence audit; never executes archived programs/SMT."""
import hashlib,json,subprocess,sys,tempfile,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];SOURCE='533cee1f5f29eb2a06b8f6f3003c2e66be482a22';PREFIX='/home/runner/work/TCPIP-Model/TCPIP-Model/';OUT=Path(__file__).resolve().parent
sha=lambda b:hashlib.sha256(b).hexdigest()
def blob(path):return subprocess.check_output(['git','show',SOURCE+':'+path],cwd=ROOT)
with zipfile.ZipFile(OUT/'original.zip')as archive:
    names=archive.namelist();assert all(not n.startswith('/')and'..'not in Path(n).parts for n in names)
    assert sha((OUT/'original.zip').read_bytes())=='574b79caa552e78e2e7e03b78007b509a58b3e7b5beab2a3b1adb46fae7610b2'
    bindings={};checked=0
    def bind(path,digest,report_name):
        global checked
        if not path.startswith(PREFIX):
            assert not Path(path).is_absolute() and '..' not in Path(path).parts,path
            base=Path('native') if report_name=='native-result.json' else Path(report_name).parent
            assert sha(archive.read(str(base/path)))==digest,path
            checked+=1
            return
        rel=path[len(PREFIX):]
        if rel.startswith('artifacts/tcp-wire-ci/'):
            assert sha(archive.read(rel[len('artifacts/tcp-wire-ci/'):]))==digest,path
        else:
            assert sha(blob(rel))==digest,path
            assert sha((ROOT/rel).read_bytes())==digest,'Current helper differs: '+rel
            bindings[rel]=digest
        checked+=1
    for name in names:
        if name.endswith('.json'):
            data=json.loads(archive.read(name))
            if isinstance(data,dict):
                for key in ('inputs','outputs'):
                    entries=data.get(key,{})
                    if isinstance(entries,dict):
                        for path,digest in entries.items():
                            if isinstance(digest,str)and len(digest)==64:bind(path,digest,name)
    sys.path.insert(0,str(ROOT))
    from protocol_lab.ir import load
    from protocol_lab.codegen import generate
    from protocol_lab.codegen.execute import compare,commands
    from protocol_lab.symbolic import replay
    model=load(ROOT/'model/tcp-wire-endpoint.json')
    generation=json.loads(archive.read('native/generated/generation.json'));compiled=json.loads(archive.read('native/build/compile.json'))
    assert compiled['status']=='pass'and compiled['returncode']==0
    assert sha(archive.read('native/generated/generation.json'))==compiled['generation_sha256']
    assert sha(archive.read('native/generated/protocol.c'))==compiled['generated_source_sha256']
    assert sha(archive.read('native/build/protocol-native'))==compiled['executable_sha256']
    assert compiled['checker_sha256']==sha(blob('protocol_lab/codegen/execute.py'))
    with tempfile.TemporaryDirectory()as temporary:
        generate(ROOT/'model/tcp-wire-endpoint.json',Path(temporary)/'generated')
        assert(Path(temporary)/'generated/protocol.c').read_bytes()==archive.read('native/generated/protocol.c')
    summary=json.loads(archive.read('native-result.json'));assert summary['status']=='pass'and len(summary['cases'])==11
    for i,case in enumerate(summary['cases']):
        folder='native/cases/'+str(i).zfill(3);scene=json.loads(blob('scenarios/tcp-wire-endpoint/'+case['scenario']))
        assert case['status']=='pass' and case['formal_fixed_input']=='match'
        execution=json.loads(archive.read(folder+'/execution/execution.json'))
        assert execution['status']=='pass' and execution['native_returncode']==0
        assert execution['executable_sha256']==compiled['executable_sha256']
        assert not execution['python_interpreter_in_native_process'] and not execution['linux_network_evidence']
        assert archive.read(folder+'/execution/native-input.txt').decode()==commands(model,scene)
        native=[json.loads(line)for line in archive.read(folder+'/execution/native.stdout').decode().splitlines()]
        diff=compare(model,scene,native);assert diff['status']=='match';assert diff==json.loads(archive.read(folder+'/execution/difference.json'))
        formal=json.loads(archive.read(folder+'/symbolic/result.json'));assert formal['query']=='sat'
        assert sha(archive.read(folder+'/symbolic/path.smt2'))==formal['smt2_sha256']
        assert replay(model,formal['witness'])['status']=='match'
        assert formal['model_semantic_sha256']==generation['model_semantic_sha256']
    result=dict(status='pass',source_commit=SOURCE,tested_merge='04cca7571287a57d81e3913dd0d227e62334720d',same_git_tree='cf9ed9059400aca13537e547edbb6728833e9ef7',archive_files=len(names),git_inputs=len(bindings),hash_bindings=checked,native_cases_recompared=11,fixed_queries_hash_checked=11,witnesses_reference_replayed=11,generated_c_rerender_identical=True,archived_programs_executed=False,archived_solver_queries_executed=False,new_Linux_execution=False,live_TCP_peer=False,all_input_safety_proof=False,CI_provenance_trusted_separately=True)
    (OUT/'audit.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
