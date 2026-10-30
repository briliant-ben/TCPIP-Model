"""Rebuild exact ACK query partitions from the committed original archive."""
import json
from pathlib import Path
import sys
import tarfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import conditional_ssa as c

OUT=Path(__file__).resolve().parent
ARCHIVE=ROOT/'artifacts/sent-ledger-single-target-unknown'

def main():
    members=json.loads((ARCHIVE/'members.json').read_text())
    archive=ARCHIVE/'exact-single-disjunct-attempt.tar.gz'
    results=[]
    for number in (92,280):
        name=f'group-{number:03}.smt2'
        source=OUT/name
        with tarfile.open(archive,'r:gz')as stream:
            entry=stream.getmember(name)
            if not entry.isfile():raise ValueError('Source is not a file')
            data=stream.extractfile(entry).read()
        if c.sha(source) != members[name] if source.exists() else False:
            raise ValueError('Existing source changed')
        if not source.exists():source.write_bytes(data)
        if c.sha(source)!=members[name]:raise ValueError('Original archive member binding failed')
        terms=c.read_query(source);names=[]
        for term in terms[:-1]:
            for _,clause in c.conjuncts(term):
                if c.z3.is_eq(clause)and c.z3.is_const(clause.arg(0)):
                    symbol=str(clause.arg(0))
                    if (symbol.startswith(('v_1_','active_1_','due_1_'))or symbol=='v_0_snd_nxt')and symbol not in names:
                        names.append(symbol)
        names.sort(key=lambda name:name=='v_0_snd_nxt')
        recipe=c.recipe_for(source,names,['v_1_snd_una','v_1_snd_nxt'])
        c.write(OUT/f'recipe-{number:03}.json',recipe)
        directory=OUT/f'group-{number:03}'
        result=c.produce(source,directory,recipe)
        verified=c.verify(directory,source)
        c.write(OUT/f'verification-{number:03}.json',verified)
        results.append(dict(group=number,source_sha256=c.sha(source),original_assertions=len(terms),
                            producer_status=result['status'],fresh_status=verified['fresh_status'],
                            context=verified['context']['query'],
                            leaves=[row['query']['query']for row in verified['cases']]))
        print(json.dumps(results[-1]),flush=True)
    c.write(OUT/'acceptance.json',dict(status='exact_conditional_refinement_recorded',
        groups=results,original_archive_sha256=c.sha(archive),original_members_sha256=c.sha(ARCHIVE/'members.json'),
        run_sha256=c.sha(__file__),checker_sha256=c.sha(ROOT/'formal/conditional_ssa.py'),
        original_unknown_reports_unchanged=True,kernel_checked=False,
        scope='exact query refinement only; unknown leaves and original TCP obligations remain open'))

if __name__=='__main__':main()
