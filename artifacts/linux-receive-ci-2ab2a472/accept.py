"""Bindings for one real finite kernel receive case and two control regressions."""
from pathlib import Path
import sys
import zipfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest
HEAD='2ab2a4729909ea9ea972b05bc70a0d43a830b3bb'
MERGE='0f24b7c17217b333c9912f0c31f37e72428e350e'
CASES=[('', 'receive-four-zero-octets',12958997182,123927572389,'5ced9dadd9618371e77414873e3c615bd4883fe7dad50a8d079e42ce7278b170',5020,5),
    ('regression/handshake','handshake',12959160911,123927572568,'774d952b35edbaa45cd27662f4e02f96aa3357062fd3a2e6a04fb6380f790011',5010,3),
    ('regression/syn-loss','syn-loss',12959635107,123927572610,'8f30e62348887c3765b3f7c92b3e372d6ee7b70db5156af6bb02be84c9543333',6010,4)]
negative=read(HERE/'negative-controls.json')
assert negative['status']=='five_receive_faults_rejected'and negative['checksum_valid_payload_fault']
assert negative['original_evidence_unchanged']and not negative['new_linux_execution']
assert {x['fault']for x in negative['tests']}=={'payload','reference','policy','checksum','quiet'}
assert negative['report_sha256']==digest(HERE/'download/report.json')
assert negative['checker_sha256']==digest(ROOT/'ports/linux-netns/verify.py')
for row in negative['tests']:assert digest(HERE/row['log'])==row['log_sha256']
rows=[]
for path,scenario,artifact_id,job,zip_sha,settle,count in CASES:
    parent=HERE/path;out=parent/'download';prov=read(parent/'provenance.json');a=prov['artifact']
    assert prov['source_head']==HEAD and prov['merge_snapshot']==MERGE and prov['run']==41014477824
    assert prov['job']==job and prov['job_conclusion']=='success'and a['id']==artifact_id
    assert a['workflow_run']['head_sha']==HEAD and a['workflow_run']['head_branch']=='codex/tcp-timers'
    assert a['name']=='linux-tcp-'+scenario+'-'+MERGE and a['digest']=='sha256:'+zip_sha
    assert digest(parent/'workflow-artifact.zip')==zip_sha
    with zipfile.ZipFile(parent/'workflow-artifact.zip')as z:
        for name in z.namelist():
            if name.endswith('/'):continue
            p=Path(name);assert not p.is_absolute()and '..'not in p.parts
            assert z.read(name)==(out/p).read_bytes(),name
    r=read(out/'report.json');runtime=read(out/'runtime-verification.json');offline=read(out/'offline-verification.json')
    assert r['scenario_id']==scenario and r['linux_execution']and r['host_tcp_stack']
    assert r['status']=='linux_execution_with_projection_mismatch'and not r['full_tcp_complete']and not r['upstream_modified']
    assert r['oracle_tolerance_ms']==0 and r['packetdrill_tolerance_us']==50000 and r['packetdrill_tolerance_percent']==12.5
    for name,sha in r['input_hashes'].items():assert digest(ROOT/name)==sha,name
    for name,sha in r['file_hashes'].items():assert digest(out/name)==sha,name
    assert runtime['status']=='valid_linux_runtime_evidence'and runtime['local_linux_execution_checked']
    assert offline['status']=='valid_retained_linux_snapshot_bindings'and not offline['local_linux_execution_checked']
    assert not offline['tool_binary_rechecked_locally']and not offline['new_linux_execution']
    for check in (runtime,offline):
        assert check['report_sha256']==digest(out/'report.json')and check['query_equivalence']=='unsat'
        assert check['checker_sha256']==digest(ROOT/'ports/linux-netns/verify.py')
        for name,sha in check['file_hashes'].items():assert digest(out/name)==sha,name
    ns=read(out/'namespace.json');observed=read(out/'observed.json');difference=read(out/'difference.json')
    assert ns['scenario_id']==scenario and ns['quiet_interval_complete']and ns['declared_settle_ms']==settle
    assert ns['capture_packet_limit']is None and '-c'not in ns['capture_command']
    assert '--tolerance_usecs=50000'in ns['packetdrill_command']and '--tolerance_percent=12.5'in ns['packetdrill_command']
    assert r['observed_window_ms']>=settle and len(observed)==count
    assert difference['status']=='mismatch'and difference['tolerance_ms']==0
    if scenario=='receive-four-zero-octets':
        assert r['projection']=='tcp-connection-v1'
        assert 'docs/tcp-sws.md'in r['input_hashes']and 'spec/sources/tcp-sws.json'in r['input_hashes']
        assert observed[3]['payload']==[0,0,0,0]and observed[-1]['ack']==9005
        assert all(x['kind']=='field'and x['field']in ('window','time_ms')for x in difference['differences'])
        policy=read(out/'driver-policy.json')
        assert [i for i,x in enumerate(policy)if x['role']=='independent_observation_only']==[2,4]
        assert len(read(out/'script-map.json'))==3
    else:
        assert r['projection']=='active-open-v1'
        assert all(x['kind']=='field'and x['field']=='time_ms'for x in difference['differences'])
    rows.append(dict(scenario=scenario,status=r['status'],kernel=r['kernel'],projection=r['projection'],
        observed_window_ms=r['observed_window_ms'],declared_window_ms=settle,packets=count,
        raw_capture_sha256=digest(out/'capture.pcap'),report_sha256=digest(out/'report.json'),
        runtime_verification_sha256=digest(out/'runtime-verification.json'),offline_verification_sha256=digest(out/'offline-verification.json'),
        difference_sha256=digest(out/'difference.json'),difference_fields=[dict(index=x['index'],field=x['field'],expected=x['expected'],observed=x['observed'])for x in difference['differences']],
        artifact=artifact_id,job=job,zip_sha256=zip_sha))
write(HERE/'acceptance.json',dict(status='one_real_linux_receive_case_and_two_regressions_accepted_with_differences',
    source_head=HEAD,merge_snapshot=MERGE,ci_run=41014477824,cases=rows,
    received_payload=[0,0,0,0],cumulative_ack=9005,model_ack_ms=60,kernel_ack_ms=20.059,
    model_receive_window_before_after=[16,12],kernel_advertised_window_before_after=[64240,64236],
    strict_difference_tolerance_ms=0,packetdrill_tolerance_minimum_us=50000,packetdrill_tolerance_percent=12.5,
    negative_controls_sha256=digest(HERE/'negative-controls.json'),local_linux_rerun=False,
    local_CI_binary_recheck=False,kernel_receive_buffer_contents_observed=False,application_read_tested=False,
    general_receive_or_data_recovery=False,physical_network_loss=False,full_tcp_complete=False,unbounded_proof=False,
    scope='one finite injected in-order four-zero-octet segment on one VM kernel; separate active-open regressions',
    original_lwip_syn_loss_ms=2750,integrity_is_not_authenticity=True,
    trusts=['GitHub runner/job/artifact provenance','Linux kernel/toolchain','pinned packetdrill injection driver',
        'independent tcpdump','IR reference/SMT encoder','PCAP parser/normalizer/comparator','offline Python/Z3 checkers']))
print('One real Linux receive case and two control regressions accepted; strict window/time Differences retained')
