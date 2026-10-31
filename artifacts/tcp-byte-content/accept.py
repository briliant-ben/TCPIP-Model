"""Audit retained byte-step evidence; --replay-out also rebuilds and reruns native queries."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import sys
import tarfile
import tempfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT));sys.path.insert(0,str(ROOT/'formal'))
import content_recheck,content_step,byte_observer
from protocol_lab.ir import load
sha=content_step.sha
read=lambda p:json.loads(Path(p).read_text())


def unpack(label,out):
    expected=read(HERE/(label+'-members.json'));seen=set()
    with tarfile.open(HERE/(label+'.tar.gz')) as t:
        for m in t:
            p=Path(m.name)
            if not m.isfile()or p.is_absolute()or '..'in p.parts or '\\'in m.name or m.name in seen or m.name not in expected:
                raise ValueError('Unsafe/unlisted/duplicate member')
            raw=t.extractfile(m).read()
            if hashlib.sha256(raw).hexdigest()!=expected[m.name]:raise ValueError('Archive member changed')
            target=out/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw);seen.add(m.name)
    if seen!=set(expected):raise ValueError('Missing members')


def accept(replay_out=None):
    selection=read(HERE/'selection.json');records=read(HERE/'records.json')
    before=byte_observer.check(load(ROOT/'model/tcp-sws.json'),load(ROOT/'model/tcp-byte-content.json'))
    if before!=read(HERE/'observer-binding.json')or set(selection)!=set(before['selected_rules']):raise ValueError('Observer or rule selection changed')
    if len(selection)!=14 or sum(map(len,selection.values()))!=22:raise ValueError('Scope changed')
    baseline=read(ROOT/'artifacts/full-regression-aec3c95c/inputs.json')
    if any(sha(ROOT/n)!=h for n,h in baseline.items()):raise ValueError('Old frozen source input changed')
    if replay_out is not None:
        replay_out=Path(replay_out).resolve();replay_out.mkdir(exist_ok=False,parents=True)
    with tempfile.TemporaryDirectory(prefix='tcp-byte-data-')as tmp:
        tmp=Path(tmp).resolve()
        for label in ('production','fresh-replay'):
            unpack(label,tmp/label)
            checked=[]
            for rid,props in selection.items():
                folder=tmp/label/rid;r=read(folder/'result.json')
                if r!=records[label][rid]:raise ValueError('Retained record changed')
                for name,h in r['files'].items():
                    p=(folder/name).resolve()
                    if not p.is_relative_to(folder)or sha(p)!=h:raise ValueError('Native evidence file changed')
                row=r['results'][0]
                if len(r['results'])!=1 or row['rule']!=rid or [p['id']for p in row['properties']]!=props or row['context']['query']!='sat':raise ValueError('Coverage/context changed')
                if (folder/rid/'context.log').read_text().strip()!='sat':raise ValueError('Context log mismatch')
                for p in row['properties']:
                    if p['applicability']['query']!='sat':raise ValueError('Vacuous or unknown property applicability')
                    for suffix,answer in [('-applicable','sat'),('',p['query'])]:
                        path=folder/rid/(p['id']+suffix+'.log')
                        if path.read_text().strip()!=answer:raise ValueError('Native log/answer differs')
                    if sha(folder/rid/(p['id']+'.smt2'))!=p['source_query_sha256']:raise ValueError('Query binding changed')
                    checked.append(p['query'])
                if label=='production':
                    if r['rules']!=[rid]or r['properties']!=props or r['prestate_invariants_assumed'] or r['poststate_invariants_assumed']:raise ValueError('Source assumptions changed')
                    for name,h in r['inputs'].items():
                        if sha(ROOT/name)!=h:raise ValueError('Trusted source changed')
                    if r['model_semantic_sha256']!=before['observed_model_semantic_sha256']:raise ValueError('Model changed')
                else:
                    if r['checker_sha256']!=sha(ROOT/'formal/content_recheck.py')or not r['fresh_native_execution']:raise ValueError('Replay checker changed')
                    if r['source_report_sha256']!=sha(tmp/'production'/rid/'result.json'):raise ValueError('Replay source changed')
                    old=records['production'][rid]['results'][0]['properties']
                    if [(p['id'],p['source_query_sha256'])for p in old]!=[(p['id'],p['source_query_sha256'])for p in row['properties']]:raise ValueError('Fresh query source changed')
                if replay_out is not None and label=='production':content_recheck.recheck(folder,replay_out/rid)
            if collections.Counter(checked)!=dict(unsat=21,unknown=1):raise ValueError('Expected outcomes changed; use a new evidence checkpoint')
    if byte_observer.check(load(ROOT/'model/tcp-sws.json'),load(ROOT/'model/tcp-byte-content.json'))!=before:raise ValueError('Observer changed during audit')
    result=dict(status='retained_partial_full_byte_step_evidence_accepted',selected_rules=14,
       content_properties_verified=21,content_properties_unknown=1,
       unresolved=[dict(rule='S-ACK-VALID',property='BC-PARTITION')],
       native_contexts_sat=14,native_property_applicability_sat=22,
       original_two_native_stages=True,new_native_replay=replay_out is not None,
       old_frozen_inputs_unchanged=len(baseline),observer_binding=before,
       whole_model_induction=False,whole_protocol_proved=False,kernel_checked=False,
       source_encoder_trusted=True,interpreter_correspondence_proved=False,linux_execution=False,
       scope='selected actual TCP byte-queue/content steps only; ACK content obligation remains unresolved')
    content_step.write(HERE/'acceptance.json',result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--replay-out',type=Path)
    print(json.dumps(accept(p.parse_args().replay_out)))
