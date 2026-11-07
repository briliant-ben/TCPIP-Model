"""Build a small data-only server release from immutable accepted Git sources."""
import argparse
import hashlib
import io
import json
from pathlib import Path,PurePosixPath
import subprocess
import posixpath
import tarfile
import sys

ROOT=Path(__file__).resolve().parents[1]
TASKS=('flows/tcp-active-open.json','flows/tcp-active-open-ipv4.json','flows/udp-header.json')
TESTS=('tests/test_pipeline.py','tests/test_codegen_wire.py','tests/test_flow_migration.py')


def blob(commit,name):
    path=PurePosixPath(name)
    if path.is_absolute()or '..'in path.parts or '\\'in name or '\n'in name or '\r'in name:raise ValueError('Unsafe release source path')
    return subprocess.check_output(['git','show',commit+':'+name],cwd=ROOT)


def build(out,source='HEAD',profile='flow'):
    if profile not in ('flow','native-bytes','udp-payload','wire-arithmetic','udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):raise ValueError('Unknown fixed release profile')
    commit=subprocess.check_output(['git','rev-parse','--verify',source+'^{commit}'],cwd=ROOT,text=True).strip()
    paths=set(TESTS)|{'examples/run_spec_candidate.py','requirements-formal.txt','docs/spec-flow-server.md','docs/spec-flow-acceptance.md'}
    tasks=[]
    additional=('flows/udp-payload.json',)if profile in ('udp-payload','wire-arithmetic','udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo')else()
    if profile in ('wire-arithmetic','udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):additional+=('flows/wire-arithmetic.json',)
    if profile in ('udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):additional+=('flows/udp-wire-transmit.json',)
    if profile in ('byte-access','udp-receive','arp-endpoint','icmp-echo'):additional+=('flows/byte-access.json',)
    if profile in ('udp-receive','arp-endpoint','icmp-echo'):additional+=('flows/udp-wire-receive.json',)
    if profile in ('arp-endpoint','icmp-echo'):additional+=('flows/arp-endpoint.json',)
    if profile=='icmp-echo':additional+=('flows/icmp-echo.json',)
    for task_path in TASKS+additional:
        raw=blob(commit,task_path);task=json.loads(raw);paths.add(task_path)
        paths|={task['model'],task['exploration'],*task['seeds'],*(s['path']for s in task['sources'])}
        # The fixed flow tasks have direct models; reject an unhandled base
        # chain rather than silently shipping an incomplete candidate workspace.
        model=json.loads(blob(commit,task['model']))
        if 'extends'in model or 'base'in model:raise ValueError('Deployment builder needs explicit inherited-model closure')
        tasks.append(dict(path=task_path,sha256=hashlib.sha256(raw).hexdigest(),id=task['id']))
    tests=list(TESTS);native_suites=[]
    if profile in ('udp-payload','wire-arithmetic','udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):
        tests.append('tests/test_udp_payload.py');paths.add('tests/test_udp_payload.py')
    if profile in ('wire-arithmetic','udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):
        tests+=['tests/test_wire_arithmetic.py','tests/test_data_semantics.py'];paths|=set(tests)
    if profile in ('udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):
        tests.append('tests/test_udp_transmit.py');paths|={'tests/test_udp_transmit.py','examples/run_udp_transmit.py'}
    if profile in ('byte-access','udp-receive','arp-endpoint','icmp-echo'):
        tests.append('tests/test_byte_access.py');paths.add('tests/test_byte_access.py')
    if profile in ('udp-receive','arp-endpoint','icmp-echo'):
        tests.append('tests/test_udp_receive.py');paths.add('tests/test_udp_receive.py')
    if profile in ('arp-endpoint','icmp-echo'):
        tests.append('tests/test_arp_endpoint.py');paths|={'tests/test_arp_endpoint.py','examples/arp_observe.py'}
    if profile=='icmp-echo':
        tests+=['tests/test_icmp_echo.py','tests/test_symbolic_witness.py'];paths|={'tests/test_icmp_echo.py','tests/test_symbolic_witness.py','examples/icmp_observe.py'}
    if profile in ('native-bytes','wire-arithmetic','udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):
        tests += ['tests/test_codegen_native.py','tests/test_codegen_bytes.py']
        paths |= set(tests)|{'examples/run_native_suite.py','model/bytes-contract.json','model/seq32-contract.json'}
        def model_chain(name,seen=()):
            if name in seen:raise ValueError('Cyclic model source chain')
            paths.add(name);raw=json.loads(blob(commit,name))
            for req in raw.get('requirements',{}).values():
                ref=req['source'].split('#')[0]
                if not ref.startswith('https://'):paths.add(ref)
            if 'extends'in raw:
                parent=PurePosixPath(name).parent;child=posixpath.normpath(str(parent/raw['extends']))
                if PurePosixPath(raw['extends']).is_absolute()or not child.startswith(str(parent)+'/'):raise ValueError('Model chain escapes its source directory')
                model_chain(child,(*seen,name))
        model_chain('model/tcp-data.json')
        files_scenarios=subprocess.check_output(['git','ls-tree','-r','--name-only',commit,'scenarios/data','scenarios/connection'],cwd=ROOT,text=True).splitlines()
        paths |= {n for n in files_scenarios if n.endswith('.json')}
        native_suites=[dict(model='model/tcp-data.json',scenario_dir='scenarios/data',formal_replay=True),dict(model='model/tcp-connection.json',scenario_dir='scenarios/connection',formal_replay=False)]
    if profile in ('arp-endpoint','icmp-echo'):native_suites.append(dict(model='model/arp-endpoint.json',scenario_dir='scenarios/arp-endpoint',formal_replay=True))
    if profile=='icmp-echo':native_suites.append(dict(model='model/icmp-echo.json',scenario_dir='scenarios/icmp-echo',formal_replay=True))
    files=subprocess.check_output(['git','ls-tree','-r','--name-only',commit,'protocol_lab'],cwd=ROOT,text=True).splitlines()
    paths|={p for p in files if Path(p).suffix in ('.py','.c')}
    content={name:blob(commit,name)for name in sorted(paths)}
    observations=[]
    if profile in ('udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'):
        oracle='spec/udp-wire-transmit-oracle.json'
        observations=[dict(kind='ipv4-udp-transmit-v1',task_index=5,oracle=oracle,oracle_sha256=hashlib.sha256(blob(commit,oracle)).hexdigest())]
    manifest=dict(schema='spec-flow-server-release-v1',source_commit=commit,repository='https://github.com/briliant-ben/TCPIP-Model',packet_observations=observations,
                  tasks=tasks,tests=tests,profile=profile,native_suites=native_suites,files={n:hashlib.sha256(raw).hexdigest()for n,raw in content.items()},
                  builder_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  secrets_included=False,compiled_programs_included=False,network_or_api_executed=False)
    out=Path(out).resolve();out.mkdir(parents=True,exist_ok=False)
    archive=out/'spec-flow-server.tar.gz'
    with tarfile.open(archive,'w:gz')as tar:
        for name,raw in content.items():
            info=tarfile.TarInfo('tools/'+name);info.size=len(raw);info.mode=0o644;info.mtime=0;tar.addfile(info,io.BytesIO(raw))
        raw=(json.dumps(manifest,indent=2,sort_keys=True)+'\n').encode()
        info=tarfile.TarInfo('release.json');info.size=len(raw);info.mode=0o644;info.mtime=0;tar.addfile(info,io.BytesIO(raw))
    (out/'release.json').write_text(json.dumps(manifest,indent=2,sort_keys=True)+'\n')
    summary=dict(schema='spec-flow-release-build-v1',source_commit=commit,source_files=len(content),archive_bytes=archive.stat().st_size,
                 archive_sha256=hashlib.sha256(archive.read_bytes()).hexdigest(),artifact=str(archive),credentials_included=False)
    (out/'build.json').write_text(json.dumps(summary,indent=2)+'\n');return summary


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path);parser.add_argument('--source',default='HEAD');parser.add_argument('--profile',choices=('flow','native-bytes','udp-payload','wire-arithmetic','udp-transmit','byte-access','udp-receive','arp-endpoint','icmp-echo'),default='flow');args=parser.parse_args()
    try:report=build(args.out,args.source,args.profile)
    except (ValueError,OSError,subprocess.CalledProcessError)as error:report=dict(status='rejected',reason=str(error));print(json.dumps(report));raise SystemExit(1)
    print(json.dumps(report))
