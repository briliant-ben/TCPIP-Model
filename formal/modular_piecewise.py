"""Exact piecewise integer remainders with an unchanged out-of-range fallback.

Universal local equality checks use no query premises. Independent congruence
reconstruction retains every original assertion; Python/Z3 remain trusted.
"""
import argparse
import json
from pathlib import Path

import z3
import modular_normalization as n
from conditional_ssa import check_terms, script

SCOPE = 'exact quantifier-free integer remainder expansion; no IR, reachability, kernel or protocol proof'


def expansion(argument, modulus):
    return z3.If(z3.And(-modulus <= argument, argument < 2*modulus),
                 z3.If(argument < 0, argument+modulus,
                       z3.If(argument >= modulus, argument-modulus, argument)),
                 argument % modulus)


def lemma(modulus):
    argument = z3.Int('remainder_argument')
    return [z3.Not(argument % modulus == expansion(argument, modulus))]


def produce(source, out):
    source, out = Path(source), Path(out)
    if out.exists():raise ValueError('Use a fresh evidence directory')
    before = n.sha(source)
    terms = n.read_query(source)
    out.mkdir(parents=True)
    (out/'source.smt2').write_bytes(source.read_bytes())
    proofs, rows = {}, []
    def apply(ordinal, node):
        modulus = node.arg(1).as_long()
        if modulus not in proofs:
            name = f'lemma-{len(proofs):03}.smt2'
            (out/name).write_text(script(lemma(modulus)))
            answer = n.cli(out/name,out/(name+'.log'))
            if answer['query'] != 'unsat':raise ValueError('Unconditional remainder equality not proved')
            proofs[modulus] = dict(modulus=modulus,file=name,sha256=n.sha(out/name),**answer)
        rows.append(dict(ordinal=ordinal,proof=proofs[modulus]['file']))
        return expansion(node.arg(0),modulus)
    normalized = n.rebuild(terms,apply)
    (out/'normalized.smt2').write_text(script(normalized))
    check_terms(out/'normalized.smt2',normalized)
    if n.sha(source) != before:raise ValueError('Source changed during production')
    result = dict(status='exact_piecewise_modulo_equalities_checked',source_sha256=before,
        assertion_count=len(terms),normalized_sha256=n.sha(out/'normalized.smt2'),
        rewrites=rows,rewrite_count=len(rows),proofs=list(proofs.values()),
        checker_sha256=n.sha(__file__),solver_sha256=n.sha(n.solver_binary()),
        dependencies={name:n.sha(Path(__file__).parent/name) for name in
                      ('modular_normalization.py','conditional_ssa.py','tactic_recheck.py','partition_queries.py')},
        timeout_ms=10000,query_premises_used=False,integer_domain_restricted=False,
        kernel_checked=False,scope=SCOPE)
    n.write(out/'result.json',result)
    return result


def verify(out, source=None):
    out = Path(out)
    result = json.loads((out/'result.json').read_text())
    if result['status'] != 'exact_piecewise_modulo_equalities_checked' or result['scope'] != SCOPE:
        raise ValueError('Scope changed')
    if result['timeout_ms'] != 10000 or any(result[name] is not False for name in
                                           ('query_premises_used','integer_domain_restricted','kernel_checked')):
        raise ValueError('Premises, domain, kernel claim or budget changed')
    if n.sha(__file__) != result['checker_sha256'] or n.sha(n.solver_binary()) != result['solver_sha256']:
        raise ValueError('Checker or solver changed')
    dependencies = {name:n.sha(Path(__file__).parent/name) for name in
                    ('modular_normalization.py','conditional_ssa.py','tactic_recheck.py','partition_queries.py')}
    if dependencies != result['dependencies']:raise ValueError('Dependency changed')
    if n.sha(out/'source.smt2') != result['source_sha256'] or (source is not None and n.sha(source) != result['source_sha256']):
        raise ValueError('Original source changed')
    if n.sha(out/'normalized.smt2') != result['normalized_sha256']:raise ValueError('Normalized query changed')
    proofs, checks = {}, []
    for row in result['proofs']:
        name, modulus = row['file'], row['modulus']
        if Path(name).name != name or name in proofs or type(modulus) is not int or modulus <= 0:
            raise ValueError('Invalid certificate coverage or modulus')
        if n.sha(out/name) != row['sha256']:raise ValueError('Certificate hash changed')
        # Exact one unconditional theorem: no hidden bound or false premise.
        check_terms(out/name,lemma(modulus))
        answer = n.cli(out/name,out/(name+'.independent.log'))
        if row['query'] != 'unsat' or answer['query'] != 'unsat':
            raise ValueError('Unconditional remainder equality not independently proved')
        expr = n.read_query(out/name)[0].arg(0)
        proofs[name] = expr.children()
        checks.append(dict(file=name,**answer))
    rows = {row['ordinal']:row for row in result['rewrites']}
    if len(rows) != len(result['rewrites']) or len(rows) != result['rewrite_count']:
        raise ValueError('Duplicate/missing rewrite coverage')
    used, used_proofs = set(), set()
    def apply(ordinal,node):
        if ordinal not in rows:return node
        row = rows[ordinal]
        if row['proof'] not in proofs:raise ValueError('Missing local certificate')
        left,right = proofs[row['proof']]
        if not z3.is_app_of(left,z3.Z3_OP_MOD):raise ValueError('Certificate source is not a remainder')
        bindings = [(z3.Int('remainder_argument'),node.arg(0))]
        actual_left = z3.substitute(left,*bindings)
        if not actual_left.eq(node):raise ValueError('Certificate does not instantiate to source node')
        used.add(ordinal);used_proofs.add(row['proof'])
        return z3.substitute(right,*bindings)
    terms = n.read_query(out/'source.smt2')
    rebuilt = n.rebuild(terms,apply)
    if used != set(rows) or used_proofs != set(proofs):raise ValueError('Unused/missing certificate coverage')
    if len(terms) != result['assertion_count']:raise ValueError('Source assertion count changed')
    check_terms(out/'normalized.smt2',rebuilt)
    return dict(status='valid_exact_piecewise_modulo_expansion',source_sha256=result['source_sha256'],
                assertions=len(terms),rewrites=len(rows),local_equalities=checks,
                integer_domain_restricted=False,kernel_checked=False,scope=SCOPE)


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('source',nargs='?',type=Path);p.add_argument('--out',required=True,type=Path)
    p.add_argument('--verify',action='store_true');args=p.parse_args()
    if args.verify:answer=verify(args.out,args.source)
    else:
        if args.source is None:p.error('source required')
        answer=produce(args.source,args.out)
    print(json.dumps(answer))
