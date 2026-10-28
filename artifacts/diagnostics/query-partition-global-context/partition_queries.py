"""Exact Boolean partitioning of one exported SMT obligation.

This checks the original conjunction, not protocol reachability. No assertion or
violation branch is omitted. It does not upgrade an existing induction report.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re

import z3


def digest(data):
    return hashlib.sha256(data).hexdigest()


def top_commands(source):
    commands=[];depth=0;start=None;quoted=None;comment=False;i=0
    while i<len(source):
        char=source[i]
        if comment:
            if char=='\n':comment=False
        elif quoted:
            if char==quoted:
                if quoted=='"'and i+1<len(source)and source[i+1]=='"':i+=1
                else:quoted=None
        elif char==';':comment=True
        elif char in ('"','|'):quoted=char
        elif char=='(':
            if depth==0:start=i
            depth+=1
        elif char==')':
            depth-=1
            if depth<0:raise ValueError('Unbalanced SMT commands')
            if depth==0:
                match=re.match(r'\(\s*([^\s()]+)',source[start:i+1])
                if not match:raise ValueError('Missing SMT command name')
                commands.append(match.group(1))
        elif depth==0 and not char.isspace():raise ValueError('Text outside SMT commands')
        i+=1
    if depth or quoted:raise ValueError('Unterminated SMT syntax')
    return commands


def extract(text, label):
    markers=list(re.finditer(r'^; (.+ -> .+)\n\(reset\)\n',text,re.M))
    matching=[i for i,m in enumerate(markers)if m.group(1)==label]
    if len(matching)!=1:raise ValueError('Expected exactly one labelled query')
    i=matching[0];end=markers[i+1].start()if i+1<len(markers)else len(text)
    source=text[markers[i].end():end]
    # A deliberately restricted exported-query subset; never silently discard
    # incremental state, assumptions, or alternate checking commands.
    commands=top_commands(source)
    allowed={'set-info','declare-fun','declare-const','assert','check-sat'}
    if not commands or commands[-1]!='check-sat' or commands.count('check-sat')!=1 or not set(commands)<=allowed:
        raise ValueError('Unsupported incremental or multiple-check query')
    assertions=list(z3.parse_smt2_string(source))
    if not assertions or len(assertions)!=commands.count('assert'):raise ValueError('Empty or incomplete exported assertion list')
    return assertions


def disjuncts(expr):
    if z3.is_or(expr):
        return [term for child in expr.children()for term in disjuncts(child)]
    if z3.is_not(expr)and z3.is_and(expr.arg(0)):
        return [term for child in expr.arg(0).children()for term in disjuncts(z3.Not(child))]
    return [expr]


def partition(path, label, out, assertion_index=-4, group_size=16, timeout_ms=10000):
    checker_sha=digest(Path(__file__).read_bytes())
    out=Path(out);out.mkdir(parents=True,exist_ok=True)
    (out/'result.json').write_text(json.dumps({'status':'incomplete','checker_source_sha256':checker_sha})+'\n')
    if type(group_size)is not int or group_size<1:raise ValueError('Positive group size required')
    if type(timeout_ms)is not int or timeout_ms<1:raise ValueError('Positive timeout required')
    path=Path(path);source=path.read_bytes();assertions=extract(source.decode(),label)
    index=assertion_index if assertion_index>=0 else len(assertions)+assertion_index
    if not 0<=index<len(assertions):raise ValueError('Assertion index outside query')
    selected=assertions[index];terms=disjuncts(selected)
    prefix=assertions[:index]+assertions[index+1:]
    out=Path(out);out.mkdir(parents=True,exist_ok=True)
    files={}
    def solve(name, constraints):
        solver=z3.Solver();solver.set(timeout=timeout_ms);solver.add(*constraints)
        script=solver.to_smt2();(out/name).write_text(script)
        files[name]=digest(script.encode())
        answer=solver.check()
        return {'query':str(answer),**({'reason':solver.reason_unknown()}if answer==z3.unknown else {})}
    equivalence=solve('equivalence.smt2',[z3.Xor(selected,z3.Or(*terms))])
    groups=[]
    # Do not assume distributivity from a host-language reconstruction alone.
    if equivalence['query']=='unsat':
        for start in range(0,len(terms),group_size):
            indices=list(range(start,min(start+group_size,len(terms))))
            name=f'group-{len(groups):03}.smt2'
            answer=solve(name,prefix+[z3.Or(*[terms[i]for i in indices])])
            groups.append({'file':name,'disjunct_indices':indices,**answer})
    statuses=[g['query']for g in groups]
    status=('query_partition_unsat'if equivalence['query']=='unsat'and groups and all(s=='unsat'for s in statuses)
            else 'satisfiable_query_not_reachability_proof'if 'sat'in statuses else 'unknown')
    result={'status':status,'scope':'exact Boolean partition of one exported query; no protocol-completeness or kernel-checked claim',
        'source_file':str(path),'source_sha256':digest(source),'label':label,'assertion_index':index,
        'assertion_count':len(assertions),'selected_assertion_sha256':digest(selected.sexpr().encode()),
        'disjunct_count':len(terms),'group_size':group_size,'timeout_ms':timeout_ms,
        'solver_version':z3.get_version_string(),'equivalence':equivalence,'groups':groups,'query_hashes':files,
        'checker_source_sha256':checker_sha,'all_other_assertions_retained':True}
    if digest(Path(__file__).read_bytes())!=checker_sha or digest(path.read_bytes())!=result['source_sha256']:
        raise ValueError('Source changed during partition execution')
    (out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
    return result


def verify(out):
    out=Path(out);r=json.loads((out/'result.json').read_text())
    if r['checker_source_sha256']!=digest(Path(__file__).read_bytes()):raise ValueError('Partition checker changed')
    if r['status']!='query_partition_unsat' or r['equivalence']['query']!='unsat' or any(g['query']!='unsat'for g in r['groups']):
        raise ValueError('No passing partition result')
    if r['solver_version']!=z3.get_version_string():raise ValueError('Partition solver version changed')
    if type(r['group_size'])is not int or r['group_size']<1 or type(r['timeout_ms'])is not int or r['timeout_ms']<1:
        raise ValueError('Invalid partition execution parameters')
    source=Path(r['source_file']).read_bytes()
    if digest(source)!=r['source_sha256']:raise ValueError('Partition source changed')
    assertions=extract(source.decode(),r['label']);index=r['assertion_index']
    if not 0<=index<len(assertions):raise ValueError('Bad selected assertion index')
    selected=assertions[index];terms=disjuncts(selected);prefix=assertions[:index]+assertions[index+1:]
    if r['assertion_count']!=len(assertions)or r['disjunct_count']!=len(terms)or r['selected_assertion_sha256']!=digest(selected.sexpr().encode()):
        raise ValueError('Partition statement changed')
    expected_indices=[list(range(i,min(i+r['group_size'],len(terms))))for i in range(0,len(terms),r['group_size'])]
    if r['group_size']<1 or [g['disjunct_indices']for g in r['groups']]!=expected_indices:
        raise ValueError('Missing or changed disjunct coverage')
    expected_files={'equivalence.smt2',*[f'group-{i:03}.smt2'for i in range(len(expected_indices))]}
    if set(r['query_hashes'])!=expected_files:raise ValueError('Missing partition query')
    checks=[('equivalence.smt2',[z3.Xor(selected,z3.Or(*terms))])]
    checks += [(f'group-{i:03}.smt2',prefix+[z3.Or(*[terms[j]for j in indices])])for i,indices in enumerate(expected_indices)]
    for name,expected in checks:
        raw=(out/name).read_bytes()
        if digest(raw)!=r['query_hashes'][name]:raise ValueError('Partition query changed')
        actual=list(z3.parse_smt2_string(raw.decode()))
        if len(actual)!=len(expected)or any(not a.eq(b)for a,b in zip(actual,expected)):
            raise ValueError('Partition omitted or changed an original constraint')
        solver=z3.Solver();solver.set(timeout=r['timeout_ms']);solver.add(*actual)
        if solver.check()!=z3.unsat:raise ValueError('Partition query not independently unsat')
    if digest(Path(__file__).read_bytes())!=r['checker_source_sha256'] or digest(Path(r['source_file']).read_bytes())!=r['source_sha256'] or any(digest((out/name).read_bytes())!=h for name,h in r['query_hashes'].items()):
        raise ValueError('Source or query changed during verification')
    return {'status':'valid_exact_partition_queries','checks':len(checks),'disjuncts':len(terms)}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source',type=Path,nargs='?');parser.add_argument('--label')
    parser.add_argument('--out',type=Path,required=True);parser.add_argument('--assertion-index',type=int,default=-4)
    parser.add_argument('--group-size',type=int,default=16);parser.add_argument('--verify',action='store_true')
    args=parser.parse_args()
    if args.verify:result=verify(args.out)
    else:
        if args.source is None or args.label is None:parser.error('source and --label required')
        result=partition(args.source,args.label,args.out,args.assertion_index,args.group_size)
    print(result['status'])
    if result['status']not in ('query_partition_unsat','valid_exact_partition_queries'):raise SystemExit(2)
