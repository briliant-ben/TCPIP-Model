"""Verify all original selected partitions and every accepted modulo proof."""
import argparse,json
from pathlib import Path
import sys,tarfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import modular_piecewise as p
import conditional_ssa as c
ORIGINAL=ROOT/'artifacts/sent-ledger-single-target-unknown'


def verify(out):
    out=Path(out);r=json.loads((out/'result.json').read_text());started=json.loads((out/'started.json').read_text())
    if r['status']!='terminal_exact_refinement'or r['git_commit']!=started['git_commit']:
        raise ValueError('No terminal checkpoint')
    if c.sha(out/'driver.py')!=started['driver_sha256']or c.sha(ROOT/'formal/modular_piecewise.py')!=started['normalizer_sha256']or r['normalizer_sha256']!=started['normalizer_sha256']:
        raise ValueError('Driver/normalizer changed')
    archive=ORIGINAL/'exact-single-disjunct-attempt.tar.gz'
    if c.sha(archive)!=started['archive_sha256']or c.sha(ORIGINAL/'members.json')!=started['members_sha256']:
        raise ValueError('Original archive changed')
    manifest=json.loads((ORIGINAL/'members.json').read_text())
    with tarfile.open(archive,'r:gz')as stream:
        prior=json.load(stream.extractfile('result.json'))
    selected=[x for x in prior['groups']if x['query']=='unknown'and x['disjunct_indices'][0]not in (52,92)]
    if len(r['groups'])!=len(selected)or len(selected)!=68:raise ValueError('Missing selected partitions')
    checks=[];common=None
    for row,source_row in zip(r['groups'],selected):
        name=source_row['file'];number=source_row['disjunct_indices'][0]
        if row['file']!=name or row['disjunct']!=number or row['source_sha256']!=manifest[name]or c.sha(out/name)!=manifest[name]:
            raise ValueError('Original query/member order changed')
        terms=c.read_query(out/name)
        if len(terms)!=444:raise ValueError('Original assertion count changed')
        if common is None:common=terms[:-1]
        elif len(common)!=len(terms)-1 or any(not a.eq(b)for a,b in zip(common,terms[:-1])):
            raise ValueError('Different nonvacuity context')
        directory=out/Path(name).stem;normalized=p.verify(directory,out/name)
        if normalized['rewrites']!=row['rewrites']:raise ValueError('Rewrite coverage changed')
        proved=row['producer']['query']=='unsat'and row['fresh']is not None and row['fresh']['query']=='unsat'
        if proved!=row['accepted_unsat']:raise ValueError('Incorrect query classification')
        answer=None
        if proved:
            for key,log in (('producer','query.log'),('fresh','query.independent.log')):
                if c.sha(directory/log)!=row[key]['log_sha256']or (directory/log).read_text().strip()!='unsat':
                    raise ValueError('Producer/fresh proof result not bound')
            answer=c.cli(directory/'normalized.smt2',directory/'query.acceptance.log')
            if answer['query']!='unsat':raise ValueError('Original query UNSAT not reproduced')
        checks.append(dict(disjunct=number,accepted_unsat=proved,normalization=normalized,fresh_query=answer))
    accepted=sum(x['accepted_unsat']for x in checks)
    if accepted!=r['accepted_unsat']or r['unknown']!=68-accepted:raise ValueError('Totals changed')
    c.check_terms(out/'context.smt2',common)
    context=c.cli(out/'context.smt2',out/'context.acceptance.log')
    if context['query']!='sat'or r['context']['query']!='sat'or r['fresh_context']['query']!='sat':
        raise ValueError('Nonvacuity not reproduced')
    return dict(status='valid_original_partition_modulo_refinement',accepted_unsat=accepted,
        unknown=68-accepted,context=context,checks=checks,kernel_checked=False,
        primary_reports_replaced=False,
        scope='68 original exported disjuncts only; not whole ACK, invariant basis, IR translation or TCP proof')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    print(json.dumps(verify(parser.parse_args().out)))
