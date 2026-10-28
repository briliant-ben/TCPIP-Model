"""Finite four-octet lwIP implementation channel; independent of IR execution."""
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
from protocol_lab.ir import load,model_files,require
from protocol_lab.lwip import sources
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets
from protocol_lab.symbolic import crosscheck_trace,model_hash

PORT=ROOT/'ports/lwip-data'
MODEL=ROOT/'model/tcp-delayed-ack.json'
SCOPE='one active connection, four application octets, one segment and full ACK; no PSH/loss/recovery/general data claim'
FILES=('build.json','build.log','reference-trace.json','expected.json','symbolic/path.smt2','symbolic/result.json','capture.pcap','execution.log','observed.json','metadata.json','difference.json')
SUMMARY={'implementation':'lwIP-2.2.1','clock':'virtual_ms','connected':1,'acknowledged_bytes':4,'mss':4,'receive_window':16}


def build_command(cc, base, manifest, binary):
    return [cc,'-std=c99','-O1','-g','-I'+str(PORT),'-I'+str(base/'src/include'),str(PORT/'harness.c'),*[str(base/p)for p in manifest['files']if p.endswith('.c')],'-o',str(binary)]


def validate_plan(s):
    require(set(s)<={'scenario_version','id','description','initial','environment','steps','expect'},'Unsupported data driver scenario field')
    require(set(s['environment']) <= {'drop_outgoing','assumptions'},'Unsupported data driver environment field')
    require(s['initial']=={} and s['environment']['drop_outgoing']==[],'Unsupported data driver initial/loss plan')
    steps=s['steps'];require(len(steps)==5,'Only the five-event data fixture is supported')
    fixed=[{'at_ms':0,'event':'app.connect','fields':{}},
           {'at_ms':10,'event':'net.synack','fields':{'seq':9000,'ack':1001,'window':8}},None,
           {'at_ms':21,'event':'app.transmit','fields':{}},
           {'at_ms':30,'event':'net.ack','fields':{'seq':9001,'ack':1005,'window':8}}]
    for i,expected in enumerate(fixed):
        if expected is not None:require(steps[i]==expected,'Unsupported data driver event/timing')
    send=steps[2];require(set(send)=={'at_ms','event','fields'}and send['at_ms']==20 and send['event']=='app.send'and set(send['fields'])=={'data'},'Unsupported application stimulus')
    data=send['fields']['data'];require(type(data)is list and len(data)==4 and all(type(b)is int and 0<=b<=255 for b in data),'Exactly four application octets required')
    return bytes(data).hex()


def inputs():
    model=load(MODEL)
    paths=list(model_files(MODEL))+list(PORT.rglob('*.py'))+list(PORT.rglob('*.h'))+list(PORT.rglob('*.c'))+[PORT/'scenario.json',PORT/'README.md']
    paths += [ROOT/'ports/lwip/harness.c',ROOT/'ports/lwip/lwipopts.h',ROOT/'ports/lwip/arch/cc.h',ROOT/'third_party/lwip.lock.json',ROOT/'packet-profile.json',ROOT/'spec/sources/manifest.json',ROOT/'requirements-formal.txt',ROOT/'docs/semantics.md',ROOT/'docs/connection-capture.md']
    paths += list((ROOT/'protocol_lab').glob('*.py'))
    for r in model['requirements'].values():
        if not r['source'].startswith('https://'):paths.append(ROOT/r['source'])
    return {str(p.relative_to(ROOT)):digest(p)for p in paths}


def run(out):
    out=Path(out).resolve();out.mkdir(parents=True,exist_ok=True)
    write(out/'report.json',{'status':'incomplete'})
    scenario=read(PORT/'scenario.json');payload=validate_plan(scenario);before=inputs();manifest,base=sources();verify_sources()
    cc=shutil.which('cc');require(cc is not None,'C99 compiler unavailable')
    binary=out/'lwip-harness'
    command=build_command(cc,base,manifest,binary)
    build=subprocess.run(command,capture_output=True,text=True,timeout=90);(out/'build.log').write_text(build.stdout+build.stderr)
    write(out/'build.json',{'command':command,'returncode':build.returncode,'compiler_sha256':digest(cc),'compiler_version':subprocess.check_output([cc,'--version'],text=True),'log_sha256':digest(out/'build.log')})
    require(build.returncode==0,'Independent data adapter compilation failed')
    model=load(MODEL);machine=run_scenario(model,scenario);expected=control_packets(machine,scenario)
    write(out/'reference-trace.json',machine.trace);write(out/'expected.json',expected)
    symbolic=crosscheck_trace(model,machine.trace,out/'symbolic');require(symbolic['status']=='match','Reference fixed-byte symbolic replay did not match')
    execution_command=[str(binary),str(out/'capture.pcap'),payload]
    executed=subprocess.run(execution_command,capture_output=True,text=True,timeout=10)
    (out/'execution.log').write_text(executed.stdout+executed.stderr)
    require(executed.returncode==0,'Independent lwIP data execution failed')
    summary=json.loads(executed.stdout)
    require(summary==SUMMARY,'Independent callbacks/configuration did not confirm the finite data scope')
    observed,metadata=normalize(out/'capture.pcap',read(ROOT/'packet-profile.json'),expected,origin='external_capture',checksum_policy='strict',projection='tcp-connection-v1')
    metadata.update(producer='lwip_memory_netif_data',clock='virtual_ms',binary_sha256=digest(binary),host_tcp_stack=False,linux_execution=False)
    difference=compare(expected,observed,tolerance_ms=0,projection='tcp-connection-v1')
    write(out/'observed.json',observed);write(out/'metadata.json',metadata);write(out/'difference.json',difference)
    require(before==inputs(),'Data channel inputs changed during execution')
    files=FILES
    result={'status':'execution_and_projection_pass'if difference['status']=='match'else'executed_with_differences','scope':SCOPE,'implementation':'lwIP-2.2.1','network_interface':'in_memory_ipv4','host_tcp_stack':False,'linux_execution':False,'full_stack_validated':False,'upstream_commit':manifest['commit'],'model_semantic_sha256':model_hash(model),'input_hashes':before,'binary_sha256':digest(binary),'command':execution_command,'returncode':executed.returncode,'summary':summary,'comparison':difference['status'],'file_hashes':{p:digest(out/p)for p in files},'trusted_components':['pinned upstream source and C compiler','C application/peer driver and netif capture','IR reference and fixed-input Z3 translator','independent PCAP parser/normalizer/oracle'],'integrity_is_not_authenticity':True}
    write(out/'report.json',result);return result


def verify(out):
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
    s=read(PORT/'scenario.json');payload=validate_plan(s);m=load(MODEL);reference=run_scenario(m,s);expected=control_packets(reference,s)
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
    require(r['command']==[str(out/'lwip-harness'),str(out/'capture.pcap'),payload]and r['returncode']==0,'Application command/stimulus changed')
    require(json.loads((out/'execution.log').read_text())==r['summary']==SUMMARY,'Execution summary changed')
    actual,meta=normalize(out/'capture.pcap',read(ROOT/'packet-profile.json'),expected,origin='external_capture',checksum_policy='strict',projection='tcp-connection-v1')
    meta.update(producer='lwip_memory_netif_data',clock='virtual_ms',binary_sha256=r['binary_sha256'],host_tcp_stack=False,linux_execution=False)
    require(read(out/'observed.json')==actual and read(out/'metadata.json')==meta,'Independent observation changed')
    diff=compare(expected,actual,tolerance_ms=0,projection='tcp-connection-v1')
    require(read(out/'difference.json')==diff and r['comparison']==diff['status'],'Difference changed')
    require(r['status']==('execution_and_projection_pass'if diff['status']=='match'else'executed_with_differences'),'Difference status relabelled')
    return {'status':'valid_independent_lwip_data_evidence','comparison':diff['status'],'linux_execution':False,'full_stack_validated':False}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',type=Path,default=ROOT/'artifacts/lwip-data');parser.add_argument('--verify',action='store_true');args=parser.parse_args()
    result=verify(args.out)if args.verify else run(args.out)
    print(json.dumps(result if args.verify else {k:result[k]for k in ('status','comparison','summary')},ensure_ascii=False))
