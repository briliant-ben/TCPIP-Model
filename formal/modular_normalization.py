"""Exact positive-integer modulo normalization with universal local certificates.

Every local equality is checked without query premises. A separate traversal
checks instantiation and congruence against every original assertion. Python and
Z3 remain trusted; this is not a Rocq certificate or an IR translation proof.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import time

import z3
from tactic_recheck import read_query,solver_binary

TIMEOUT_MS=10000


def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def write(path,value):Path(path).write_text(json.dumps(value,indent=2)+'\n')
def sum_terms(terms):return z3.Sum(*terms)if len(terms)>1 else terms[0]if terms else z3.IntVal(0)


def proposal(node):
    modulus=node.arg(1).as_long();atoms=[];paths=[];indices={}
    def add(parts):
        result={}
        for coefficients,scale in parts:
            for key,value in coefficients.items():result[key]=result.get(key,0)+value*scale
        return {k:v for k,v in result.items()if v}
    def visit(expr,path):
        if z3.is_int_value(expr):return expr,{-1:expr.as_long()}
        kind=expr.decl().kind();children=expr.children()
        if kind in (z3.Z3_OP_ADD,z3.Z3_OP_SUB,z3.Z3_OP_UMINUS):
            rows=[visit(c,path+[i])for i,c in enumerate(children)]
            scales=[-1]if kind==z3.Z3_OP_UMINUS else [1]+[-1]*(len(rows)-1)if kind==z3.Z3_OP_SUB else [1]*len(rows)
            return expr.decl()(*[x[0]for x in rows]),add([(x[1],s)for x,s in zip(rows,scales)])
        if kind==z3.Z3_OP_MUL and sum(not z3.is_int_value(c)for c in children)<=1:
            scale=1;rows=[];coefficients={-1:1}
            for i,c in enumerate(children):
                if z3.is_int_value(c):scale*=c.as_long();rows.append(c)
                else:
                    term,coefficients=visit(c,path+[i]);rows.append(term)
            return expr.decl()(*rows),add([(coefficients,scale)])
        if kind==z3.Z3_OP_MOD and z3.is_int_value(children[1])and children[1].as_long()==modulus:
            term,coefficients=visit(children[0],path+[0])
            return term%modulus,coefficients
        key=expr.get_id()
        if key not in indices:
            indices[key]=len(atoms);atoms.append(expr);paths.append(path)
        index=indices[key]
        return z3.Int('atom_'+str(index)),{index:1}
    before,coefficients=visit(node.arg(0),[0])
    before=before%modulus
    def polynomial(values):
        terms=[]
        for key in sorted(coefficients):
            value=coefficients[key]%modulus
            if key>=0 and value>modulus//2:value-=modulus
            if not value:continue
            if key==-1:terms.append(z3.IntVal(value))
            elif value==1:terms.append(values[key])
            else:terms.append(z3.IntVal(value)*values[key])
        return sum_terms(terms)%modulus
    variables=[z3.Int('atom_'+str(i))for i in range(len(atoms))]
    after=polynomial(variables)
    bindings=list(zip(variables,atoms))
    actual_before=z3.substitute(before,*bindings)if bindings else before
    actual_after=z3.substitute(after,*bindings)if bindings else after
    if not actual_before.eq(node):raise ValueError('Proposer template does not instantiate to original node')
    return actual_after,paths,before,after


def proof_parts(path):
    terms=read_query(path)
    if len(terms)!=1 or not z3.is_not(terms[0])or not z3.is_eq(terms[0].arg(0)):
        raise ValueError('Certificate must be one unconditional negated equality')
    before,after=terms[0].arg(0).children()
    def check(expr):
        if expr.sort()!=z3.IntSort():raise ValueError('Certificate must use integer expressions')
        if z3.is_int_value(expr):return
        kind=expr.decl().kind()
        if kind==z3.Z3_OP_UNINTERPRETED and expr.num_args()==0:
            if not re.fullmatch(r'atom_[0-9]+',str(expr)):raise ValueError('Unlisted certificate symbol')
            return
        if kind not in (z3.Z3_OP_ADD,z3.Z3_OP_SUB,z3.Z3_OP_UMINUS,z3.Z3_OP_MUL,z3.Z3_OP_MOD):
            raise ValueError('Unsupported certificate arithmetic')
        if kind==z3.Z3_OP_MOD and (not z3.is_int_value(expr.arg(1))or expr.arg(1).as_long()<=0):
            raise ValueError('Nonpositive or symbolic certificate modulus')
        for child in expr.children():check(child)
    check(before);check(after)
    return before,after


def cli(path,log):
    start=time.monotonic()
    try:
        p=subprocess.run([str(solver_binary()),'-t:'+str(TIMEOUT_MS),'-smt2',str(Path(path).resolve())],
            capture_output=True,text=True,timeout=15)
        output=p.stdout+p.stderr
        if p.returncode!=0 or p.stderr.strip()or p.stdout.strip()not in ('sat','unsat','unknown'):
            raise ValueError('Unexpected independent solver output: '+output[:300])
        answer=p.stdout.strip()
    except subprocess.TimeoutExpired:
        output='External deadline exceeded\n';answer='unknown'
    Path(log).write_text(output)
    return dict(query=answer,seconds=time.monotonic()-start,log_sha256=sha(log))


def rebuild(assertions,apply):
    memo={};ordinal=0
    def walk(node):
        nonlocal ordinal
        key=node.get_id()
        if key in memo:return memo[key]
        if not z3.is_app(node):raise ValueError('Quantifiers or bound variables are unsupported')
        children=[walk(c)for c in node.children()]
        current=node.decl()(*children)if children else node
        index=ordinal;ordinal+=1
        if node.decl().kind()==z3.Z3_OP_MOD:
            if not z3.is_int_value(current.arg(1))or current.arg(1).as_long()<=0:
                raise ValueError('Symbolic/nonpositive modulus is unsupported')
            current=apply(index,current)
        memo[key]=current;return current
    return [walk(a)for a in assertions]


def produce(source,out):
    source=Path(source);out=Path(out);out.mkdir(parents=True,exist_ok=True)
    if (out/'result.json').exists():raise ValueError('Use fresh evidence directory')
    source_sha=sha(source);assertions=read_query(source);rows=[];proofs={}
    def apply(index,node):
        candidate,paths,before,after=proposal(node)
        if candidate.eq(node):return node
        solver=z3.Solver();solver.add(z3.Not(before==after));text=solver.to_smt2()
        digest=hashlib.sha256(text.encode()).hexdigest()
        if digest not in proofs:
            name='lemma-'+str(len(proofs)).zfill(3)+'.smt2';(out/name).write_text(text)
            proof_parts(out/name)
            result=cli(out/name,out/(name+'.log'))
            if result['query']!='unsat':raise ValueError('Universal modulo equality not proved: '+result['query'])
            proofs[digest]=dict(file=name,sha256=sha(out/name),**result)
        rows.append(dict(ordinal=index,atom_paths=paths,proof=proofs[digest]['file']))
        return candidate
    normalized=rebuild(assertions,apply)
    solver=z3.Solver();solver.add(*normalized);(out/'normalized.smt2').write_text(solver.to_smt2())
    if sha(source)!=source_sha:raise ValueError('Source changed during normalization')
    result=dict(status='local_modular_equalities_checked',source_file=str(source),source_sha256=source_sha,
        assertion_count=len(assertions),rewrite_count=len(rows),rewrites=rows,proofs=list(proofs.values()),
        normalized_sha256=sha(out/'normalized.smt2'),checker_sha256=sha(__file__),solver_binary_sha256=sha(solver_binary()),
        timeout_ms=TIMEOUT_MS,query_premises_used_for_lemmas=False,kernel_checked=False,
        scope='quantifier-free query equivalence by unconditional integer equalities, instantiation and congruence; no IR/translator/protocol proof')
    write(out/'result.json',result);return result


def verify(out,source=None):
    out=Path(out);r=json.loads((out/'result.json').read_text());source=Path(source or r['source_file'])
    if r['status']!='local_modular_equalities_checked'or r['timeout_ms']!=TIMEOUT_MS or r['query_premises_used_for_lemmas']:
        raise ValueError('Normalization scope or budget changed')
    if sha(source)!=r['source_sha256']or sha(__file__)!=r['checker_sha256']or sha(solver_binary())!=r['solver_binary_sha256']:
        raise ValueError('Source/checker/solver changed')
    if sha(out/'normalized.smt2')!=r['normalized_sha256']:raise ValueError('Normalized script changed')
    proofs={};checks=[]
    for row in r['proofs']:
        name=row['file'];p=Path(name)
        if p.name!=name or name in proofs or sha(out/name)!=row['sha256']:raise ValueError('Certificate coverage or binding changed')
        proofs[name]=proof_parts(out/name)
        check=cli(out/name,out/(name+'.independent.log'))
        if check['query']!='unsat':raise ValueError('Universal equality did not independently pass: '+check['query'])
        checks.append(dict(file=name,**check))
    rows={x['ordinal']:x for x in r['rewrites']};used=set()
    if len(rows)!=len(r['rewrites'])or len(rows)!=r['rewrite_count']:raise ValueError('Duplicate/missing rewrite certificate')
    def apply(index,node):
        if index not in rows:return node
        row=rows[index];used.add(index)
        if row['proof']not in proofs:raise ValueError('Missing equality certificate')
        before,after=proofs[row['proof']];bindings=[]
        for i,path in enumerate(row['atom_paths']):
            value=node
            for child in path:
                if type(child)is not int or not 0<=child<value.num_args():raise ValueError('Invalid instantiation path')
                value=value.arg(child)
            if value.sort()!=z3.IntSort():raise ValueError('Noninteger equality instantiation')
            bindings.append((z3.Int('atom_'+str(i)),value))
        def instantiate(expr):return z3.substitute(expr,*bindings)if bindings else expr
        if not instantiate(before).eq(node):raise ValueError('Certificate does not instantiate to source subtree')
        target=instantiate(after)
        # No unbound placeholders may survive in either generic statement.
        def placeholders(expr):
            if z3.is_const(expr)and expr.decl().kind()==z3.Z3_OP_UNINTERPRETED:return {str(expr)}
            return set().union(*(placeholders(c)for c in expr.children()))if expr.num_args()else set()
        allowed={'atom_'+str(i)for i in range(len(bindings))}
        if not (placeholders(before)|placeholders(after))<=allowed:raise ValueError('Unbound certificate atom')
        return target
    expected=rebuild(read_query(source),apply);actual=read_query(out/'normalized.smt2')
    if used!=set(rows)or len(expected)!=r['assertion_count']or len(actual)!=len(expected)or any(not a.eq(b)for a,b in zip(actual,expected)):
        raise ValueError('Normalized query omits or changes an original assertion/rewrite')
    return dict(status='valid_exact_modular_normalization',assertions=len(expected),rewrites=len(rows),
        universal_equalities=len(checks),independent_checks=checks,kernel_checked=False,source_sha256=r['source_sha256'])


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('source',nargs='?',type=Path)
    parser.add_argument('--out',required=True,type=Path);parser.add_argument('--verify',action='store_true')
    args=parser.parse_args()
    result=verify(args.out,args.source)if args.verify else produce(args.source,args.out)
    print(json.dumps({k:v for k,v in result.items()if k not in ('rewrites','proofs','independent_checks')}))
