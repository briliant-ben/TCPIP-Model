"""Finite event-driven lwIP send/ACK/window implementation channel."""
import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from protocol_lab.capture import normalize
from protocol_lab.flow import digest,read,write,run_scenario,verify_sources
from protocol_lab.ir import load,model_files,require,Uncovered,Conflict
from protocol_lab.lwip import sources
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets
from protocol_lab.symbolic import crosscheck_trace,model_hash

PORT=ROOT/'ports/lwip-stream'
MODEL=ROOT/'model/tcp-delayed-ack.json'
SCOPE='one active connection; <=16 written octets, <=64 events, <=200ms; send/ACK/window; no receive text, close, loss or recovery claim'
FILES=('stimulus.txt','build.json','build.log','reference-trace.json','expected.json','symbolic/path.smt2','symbolic/result.json','capture.pcap','execution.log','observed.json','metadata.json','difference.json')



def build_command(cc, base, manifest, binary):
    return [cc,'-std=c99','-O1','-g','-I'+str(PORT),'-I'+str(base/'src/include'),str(PORT/'harness.c'),*[str(base/p)for p in manifest['files']if p.endswith('.c')],'-o',str(binary)]


def validate_plan(s):
    require(set(s)<={'scenario_version','id','description','initial','environment','steps','expect'},'Unsupported stream scenario field')
    require(s['scenario_version']=='0.1','Unsupported scenario version')
    require(set(s['environment']) <= {'drop_outgoing','assumptions'},'Unsupported stream environment field')
    require(s['initial']=={} and s['environment']['drop_outgoing']==[],'Unsupported stream initial/loss plan')
    steps=s['steps'];require(type(steps)is list and 3<=len(steps)<=64,'Unsupported stream event count')
    require(steps[0]=={'at_ms':0,'event':'app.connect','fields':{}},'Active connect at zero required')
    previous=-1;written=0;commands=[]
    for i,step in enumerate(steps):
        require(set(step)=={'at_ms','event','fields'},'Unsupported stream step field')
        t=step['at_ms'];event=step['event'];f=step['fields']
        require(type(t)is int and previous<=t<=200,'Stream clock outside finite monotone scope');previous=t
        if i==0:
            command='CONNECT'
        elif i==1:
            require(t==10 and event=='net.synack' and set(f)=={'seq','ack','window'} and f['seq']==9000 and f['ack']==1001,'Canonical handshake input required')
            require(all(type(v)is int for v in f.values()) and 0<=f['window']<=65535,'Invalid SYN window')
            command=f"SYNACK 9000 1001 {f['window']}"
        elif event=='app.send':
            require(set(f)=={'data'} and type(f['data'])is list and 1<=len(f['data'])<=16 and all(type(b)is int and 0<=b<=255 for b in f['data']),'Invalid stream application bytes')
            written+=len(f['data']);require(written<=16,'Stream written-byte scope exceeded')
            command='SEND '+bytes(f['data']).hex()
        elif event=='app.transmit':
            require(f=={},'Unsupported transmit fields');command='TRANSMIT'
        elif event=='net.ack':
            require(set(f)=={'seq','ack','window'} and all(type(v)is int for v in f.values()),'Invalid ACK fields')
            require(0<=f['seq']<2**32 and 0<=f['ack']<2**32 and 0<=f['window']<=65535,'ACK field outside wire range')
            command=f"ACK {f['seq']} {f['ack']} {f['window']}"
        else:
            require(False,'Unsupported stream event: '+event)
        commands.append(f'{t} {command}\n')
    require(written>0,'At least one application byte required')
    return ''.join(commands)


def validate_summary(summary, scenario):
    expected={'implementation':'lwIP-2.2.1','clock':'virtual_ms','connected':1,'mss':4,'receive_window':16,
              'written_bytes':sum(len(s['fields']['data'])for s in scenario['steps']if s['event']=='app.send'),'commands':len(scenario['steps'])}
    require(set(summary)==set(expected)|{'acknowledged_bytes'},'Unexpected execution summary fields')
    require(all(summary[k]==v and type(summary[k])is type(v) for k,v in expected.items()),'Execution summary changed')
    require(type(summary['acknowledged_bytes'])is int and 0<=summary['acknowledged_bytes']<=expected['written_bytes'],'Invalid acknowledged-byte callback')


def inputs():
    model=load(MODEL)
    paths=list(model_files(MODEL))+list(PORT.rglob('*.py'))+list(PORT.rglob('*.h'))+list(PORT.rglob('*.c'))+list(PORT.rglob('*.json'))+[PORT/'README.md',ROOT/'ports/lwip-data/lwipopts.h']
    paths += [ROOT/'ports/lwip/harness.c',ROOT/'ports/lwip/lwipopts.h',ROOT/'ports/lwip/arch/cc.h',ROOT/'third_party/lwip.lock.json',ROOT/'packet-profile.json',ROOT/'spec/sources/manifest.json',ROOT/'requirements-formal.txt',ROOT/'docs/semantics.md',ROOT/'docs/connection-capture.md']
    paths += list((ROOT/'protocol_lab').glob('*.py'))
    for r in model['requirements'].values():
        if not r['source'].startswith('https://'):paths.append(ROOT/r['source'])
    return {str(p.relative_to(ROOT)):digest(p)for p in paths}


def phase(out, name):
    write(Path(out)/'report.json',{'status':'incomplete','phase':name})


def run(out, scenario_path):
    out=Path(out).resolve();scenario_path=Path(scenario_path).resolve()
    try:
        require(scenario_path.parent==PORT/'scenarios' and scenario_path.suffix=='.json','Scenario must be a bound stream input')
        return _run(out,scenario_path)
    except (ValueError,OSError,subprocess.SubprocessError) as error:
        stage=read(out/'report.json').get('phase','input_validation') if (out/'report.json').exists() else 'input_validation'
        status={'input_validation':'unsupported_stimulus','source_integrity':'source_integrity_failure','compiler':'environment_failure','reference':'model_failure','symbolic':'formal_replay_failure','execution':'execution_failure','observation':'observation_invalid','input_integrity':'stale_inputs'}[stage]
        if isinstance(error,Uncovered):status='model_uncovered'
        if isinstance(error,Conflict):status='model_rule_conflict'
        write(out/'report.json',{'status':status,'phase':stage,'error_type':type(error).__name__,'error':str(error),'scenario':str(scenario_path),'linux_execution':False,'full_stack_validated':False})
        raise


def _run(out, scenario_path):
    out=Path(out).resolve();out.mkdir(parents=True,exist_ok=True)
    phase(out,'input_validation')
    scenario=read(scenario_path);stimulus=validate_plan(scenario);before=inputs()
    phase(out,'source_integrity');manifest,base=sources();verify_sources()
    phase(out,'compiler')
    cc=shutil.which('cc');require(cc is not None,'C99 compiler unavailable')
    binary=out/'lwip-harness'
    command=build_command(cc,base,manifest,binary)
    build=subprocess.run(command,capture_output=True,text=True,timeout=90);(out/'build.log').write_text(build.stdout+build.stderr)
    write(out/'build.json',{'command':command,'returncode':build.returncode,'compiler_sha256':digest(cc),'compiler_version':subprocess.check_output([cc,'--version'],text=True),'log_sha256':digest(out/'build.log')})
    require(build.returncode==0,'Independent data adapter compilation failed')
    phase(out,'reference');model=load(MODEL);machine=run_scenario(model,scenario);expected=control_packets(machine,scenario)
    write(out/'reference-trace.json',machine.trace);write(out/'expected.json',expected)
    phase(out,'symbolic');symbolic=crosscheck_trace(model,machine.trace,out/'symbolic');require(symbolic['status']=='match','Reference fixed-byte symbolic replay did not match')
    (out/'stimulus.txt').write_text(stimulus)
    execution_command=[str(binary),str(out/'capture.pcap'),str(out/'stimulus.txt')]
    phase(out,'execution');executed=subprocess.run(execution_command,capture_output=True,text=True,timeout=10)
    (out/'execution.log').write_text(executed.stdout+executed.stderr)
    require(executed.returncode==0,'Independent lwIP data execution failed')
    summary=json.loads(executed.stdout)
    validate_summary(summary,scenario)
    phase(out,'observation');observed,metadata=normalize(out/'capture.pcap',read(ROOT/'packet-profile.json'),expected,origin='external_capture',checksum_policy='strict',projection='tcp-connection-v1')
    metadata.update(producer='lwip_memory_netif_stream',clock='virtual_ms',binary_sha256=digest(binary),host_tcp_stack=False,linux_execution=False)
    difference=compare(expected,observed,tolerance_ms=0,projection='tcp-connection-v1')
    write(out/'observed.json',observed);write(out/'metadata.json',metadata);write(out/'difference.json',difference)
    phase(out,'input_integrity');require(before==inputs(),'Data channel inputs changed during execution')
    files=FILES
    result={'status':'execution_and_projection_pass'if difference['status']=='match'else'executed_with_differences','scenario':str(scenario_path.relative_to(ROOT)),'scope':SCOPE,'implementation':'lwIP-2.2.1','network_interface':'in_memory_ipv4','host_tcp_stack':False,'linux_execution':False,'full_stack_validated':False,'upstream_commit':manifest['commit'],'model_semantic_sha256':model_hash(model),'input_hashes':before,'binary_sha256':digest(binary),'command':execution_command,'returncode':executed.returncode,'summary':summary,'comparison':difference['status'],'file_hashes':{p:digest(out/p)for p in files},'trusted_components':['pinned upstream source and C compiler','C application/peer driver and netif capture','IR reference and fixed-input Z3 translator','independent PCAP parser/normalizer/oracle'],'integrity_is_not_authenticity':True}
    write(out/'report.json',result);return result


def verify(out, scenario_path):
    out=Path(out).resolve();r=read(out/'report.json');require(r['status']in ('execution_and_projection_pass','executed_with_differences'),'Data execution not complete')
    manifest,base=sources();verify_sources();require(r['input_hashes']==inputs(),'Data source inputs stale')
    require(digest(out/'lwip-harness')==r['binary_sha256'],'Data binary changed/missing')
    require(set(r['file_hashes'])==set(FILES),'Data evidence file set changed')
    require(r['scope']==SCOPE and r['implementation']=='lwIP-2.2.1' and r['upstream_commit']==manifest['commit'],'Implementation scope changed')
    require(r['network_interface']=='in_memory_ipv4' and r['host_tcp_stack'] is False and r['linux_execution'] is False and r['full_stack_validated'] is False,'Execution scope relabelled')
    for name,h in r['file_hashes'].items():
        p=(out/name).resolve();require(p.is_relative_to(out)and digest(p)==h,'Data artifact changed: '+name)
    build=read(out/'build.json');require(build['returncode']==0 and digest(build['command'][0])==build['compiler_sha256'],'Compiler/build record changed')
    require(build['command']==build_command(build['command'][0],base,manifest,out/'lwip-harness') and build['log_sha256']==digest(out/'build.log'),'Build command/log changed')
    require(r['scenario']==str(scenario_path.relative_to(ROOT)),'Scenario binding changed')
    s=read(scenario_path);stimulus=validate_plan(s);require((out/'stimulus.txt').read_text()==stimulus,'Input event mapping changed');m=load(MODEL);reference=run_scenario(m,s);expected=control_packets(reference,s)
    require(r['model_semantic_sha256']==model_hash(m),'Data model binding changed')
    require(read(out/'expected.json')==expected and read(out/'reference-trace.json')==reference.trace,'Reference output changed, even if rehashed')
    symbolic=read(out/'symbolic/result.json');require(symbolic['status']=='match'and symbolic['query']=='sat'and symbolic['replay']['status']=='match'and symbolic['model_semantic_sha256']==model_hash(m)and symbolic['smt2_sha256']==digest(out/'symbolic/path.smt2'),'Fixed-byte evidence changed')
    with tempfile.TemporaryDirectory(prefix='lwip-data-recheck-') as tmp:
        recheck=crosscheck_trace(m,reference.trace,Path(tmp))
        require(recheck['status']=='match','Independent fixed-byte recheck failed')
        # Z3's serialization aliases depend on earlier AST allocations. Bind the
        # original bytes, then check logical equivalence rather than new text.
        import z3
        original=z3.And(*z3.parse_smt2_file(str(out/'symbolic/path.smt2')))
        regenerated=z3.And(*z3.parse_smt2_file(str(Path(tmp)/'path.smt2')))
        equivalence=z3.Solver();equivalence.set(timeout=10000)
        equivalence.add(z3.Xor(original,regenerated))
        require(equivalence.check()==z3.unsat,'Exported fixed-byte query differs from regenerated semantics')
    require(r['command']==[str(out/'lwip-harness'),str(out/'capture.pcap'),str(out/'stimulus.txt')]and r['returncode']==0,'Application command/stimulus changed')
    require(json.loads((out/'execution.log').read_text())==r['summary'],'Execution summary changed')
    validate_summary(r['summary'],s)
    actual,meta=normalize(out/'capture.pcap',read(ROOT/'packet-profile.json'),expected,origin='external_capture',checksum_policy='strict',projection='tcp-connection-v1')
    meta.update(producer='lwip_memory_netif_stream',clock='virtual_ms',binary_sha256=r['binary_sha256'],host_tcp_stack=False,linux_execution=False)
    require(read(out/'observed.json')==actual and read(out/'metadata.json')==meta,'Independent observation changed')
    diff=compare(expected,actual,tolerance_ms=0,projection='tcp-connection-v1')
    require(read(out/'difference.json')==diff and r['comparison']==diff['status'],'Difference changed')
    require(r['status']==('execution_and_projection_pass'if diff['status']=='match'else'executed_with_differences'),'Difference status relabelled')
    return {'status':'valid_independent_lwip_stream_evidence','comparison':diff['status'],'linux_execution':False,'full_stack_validated':False}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--scenario',type=Path,default=PORT/'scenarios/two-segments-partial-ack.json')
    parser.add_argument('--out',type=Path,default=ROOT/'artifacts/lwip-stream/two-segments-partial-ack')
    parser.add_argument('--verify',action='store_true');args=parser.parse_args()
    scenario_path=args.scenario.resolve()
    require(scenario_path.parent==PORT/'scenarios' and scenario_path.suffix=='.json','Scenario must be a bound stream input')
    result=verify(args.out,scenario_path)if args.verify else run(args.out,scenario_path)
    print(json.dumps(result if args.verify else {k:result[k]for k in ('status','comparison','summary')},ensure_ascii=False))
    if not args.verify and result['comparison']!='match':sys.exit(1)
