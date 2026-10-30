"""Retain a terminal unknown refinement; independently recheck only closed targets."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tarfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from protocol_lab.flow import read,write,digest
from protocol_lab.ir import load,require
from protocol_lab.symbolic import model_hash
HERE=Path(__file__).resolve().parent
SOURCE=ROOT/'artifacts/sent-ledger-current-refinement'
PRIMARY=ROOT/'artifacts/sent-ledger-current-induction'
report=read(SOURCE/'result.json')
require(report['status']=='refinement_unknown' and report['primary_status']=='unknown','Not the terminal unknown attempt')
require(report['model_semantic_sha256']==model_hash(load(ROOT/'model/tcp-sent-ledger.json')),'Refinement model changed')
require(digest(PRIMARY/'result.json')==report['primary_result_sha256'],'Primary changed')
for name,sha in report['primary_query_hashes'].items():require(digest(PRIMARY/name)==sha,'Primary query changed')
for name,sha in report['checker_source_hashes'].items():require(digest(ROOT/name)==sha,'Checker changed')
for name,sha in report['artifact_hashes'].items():require(digest(SOURCE/name)==sha,'Refinement artifact changed')
closed=[]; answers={}
for index,row in enumerate(report['partitions']):
    part=read(SOURCE/row['directory']/'result.json')
    for group in part['groups']:answers[group['query']]=answers.get(group['query'],0)+1
    if row['status']!='query_partition_unsat':continue
    command=[sys.executable,str(ROOT/'formal/partition_queries.py'),'--out',str(SOURCE/row['directory']),'--verify']
    process=subprocess.run(command,capture_output=True,text=True,timeout=240)
    log=HERE/f'closed-target-{index:03}.log';log.write_text(process.stdout+process.stderr)
    require(process.returncode==0 and process.stdout.strip()=='valid_exact_partition_queries','Closed target not independently verified')
    closed.append(dict(target=row['target'],directory=row['directory'],command=command,log_sha256=digest(log),
        checks=row['verification']['checks'],scope='one original state/length preservation target only'))
require(len(report['partitions'])==len(report['original_unknown_targets'])==62 and len(closed)==3,'Refinement coverage changed')
members={str(p.relative_to(SOURCE)):digest(p)for p in sorted(SOURCE.rglob('*'))if p.is_file()}
write(HERE/'member-hashes.json',members)
archive=HERE/'unknown-attempt.tar.gz'
with tarfile.open(archive,'w:gz')as tar:
    for name in members:tar.add(SOURCE/name,arcname=name,recursive=False)
with tarfile.open(archive,'r:gz')as tar:
    require({m.name for m in tar.getmembers()}==set(members),'Archive member set changed')
    for member in tar.getmembers():
        require(member.isfile() and hashlib.sha256(tar.extractfile(member).read()).hexdigest()==members[member.name],
            'Archive member differs')
require(all(digest(SOURCE/name)==sha for name,sha in members.items()),'Refinement source changed while archiving')
write(HERE/'result.json',dict(status='terminal_refinement_unknown_retained_three_closed_targets_rechecked',
    primary_status='unknown',refinement_status='refinement_unknown',original_unknown_targets=62,
    independently_closed_targets=closed,remaining_unknown_targets=59,group_queries=answers,
    archive_sha256=digest(archive),member_manifest_sha256=digest(HERE/'member-hashes.json'),
    original_refinement_sha256=digest(SOURCE/'result.json'),model_semantic_sha256=report['model_semantic_sha256'],
    primary_result_sha256=report['primary_result_sha256'],checker_sources=report['checker_source_hashes'],
    unbounded_protocol_proof=False,kernel_checked_proof=False,all_state_properties_proved=False,
    source_directory_preserved=True,scope='same original induction queries; unknowns not converted into passes'))
print('Terminal unknown archived; three original targets independently rechecked;59 remain unknown')
