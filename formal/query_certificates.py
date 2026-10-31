"""Verify standalone UNSAT query certificates using fixed built-in checkers.

Certificate directories contain data only. No Python code or commands supplied
by a certificate are executed. Every source query is bound by its caller's SHA.
"""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import uuid

import conditional_ssa as c
import finite_specialization as f
import modular_normalization as n
import modular_piecewise as p
import tactic_recheck as t

FORMAT='standalone-query-certificate-v1'


class VerificationSession:
    """Volatile verified results; never restored from a certificate/report."""
    def __init__(self):
        self.id=uuid.uuid4().hex
        self.entries={}
        self.fresh=0
        self.hits=0

    def stats(self):
        return dict(session_id=self.id,fresh_certificates=self.fresh,cache_hits=self.hits,
                    invocation_local=True,loaded_from_artifacts=False)


def checker_epoch():
    folder=Path(__file__).parent
    files=('query_certificates.py','query_lemmas.py','finite_specialization.py','modular_piecewise.py',
           'conditional_ssa.py','modular_normalization.py','tactic_recheck.py','partition_queries.py')
    state={name:c.sha(folder/name)for name in files}
    state['solver_binary_sha256']=c.sha(c.solver_binary())
    state['z3_python_version']=c.z3.get_full_version()
    return hashlib.sha256(json.dumps(state,sort_keys=True).encode()).hexdigest()


def certificate_digest(root):
    """Hash complete relative file names and bytes, including unused metadata."""
    result=hashlib.sha256()
    for path in sorted(Path(root).rglob('*')):
        if path.is_symlink():raise ValueError('Symlink certificate members unsupported')
        if path.is_file():
            name=str(path.relative_to(root)).encode()
            result.update(len(name).to_bytes(8,'big'));result.update(name)
            result.update(bytes.fromhex(c.sha(path)))
    return result.hexdigest()


def inside(root,name):
    if not isinstance(name,str)or not name:raise ValueError('Invalid certificate path')
    path=Path(name)
    if path.is_absolute()or '..'in path.parts:raise ValueError('Unsafe certificate path')
    result=(root/path).resolve()
    if not result.is_relative_to(root.resolve()):raise ValueError('Certificate path escapes root')
    return result


def admitted(terms):
    seen=set()
    def visit(expr):
        if expr.get_id()in seen:return
        seen.add(expr.get_id())
        if not c.z3.is_app(expr):raise ValueError('Quantifiers and bound variables unsupported')
        for child in expr.children():visit(child)
    for term in terms:visit(term)


def source(root):
    root=Path(root)
    record=json.loads((root/'certificate.json').read_text())
    expected={'format','kind','source','proof'}|({'target'}if record.get('kind')=='reuse'else set())
    if set(record)!=expected or record['format']!=FORMAT:
        raise ValueError('Unsupported certificate schema')
    if record['kind']not in ('tactic','piecewise','modular-normalization','finite','reuse'):
        raise ValueError('Unsupported certificate kind; no custom checker execution')
    path=inside(root,record['source']);admitted(c.read_query(path))
    return path,inside(root,record['proof']),record['kind']


def fingerprint(path):
    """Canonical assertion vector, independent of comments/SMT whitespace."""
    return hashlib.sha256(c.script(c.read_query(path)).encode()).hexdigest()


def finite(proof,expected_source):
    if c.sha(proof/'original.smt2')!=c.sha(expected_source):raise ValueError('Finite original source mismatch')
    normalization=p.verify(proof/'modulo',expected_source)
    checked=f.verify(proof/'finite',proof/'modulo/normalized.smt2')
    old=json.loads((proof/'finite/result.json').read_text())
    methods=json.loads((proof/'proof-methods.json').read_text())
    values=old['recipe']['values']
    if len(methods)!=len(values)or [row['value']for row in methods]!=values:raise ValueError('Incomplete finite certificate')
    alternatives=[]
    for index,(value,method)in enumerate(zip(values,methods)):
        allowed={'value','method','equivalence_method','method_source_sha256','equivalence_method_source_sha256'}
        if not set(method)<=allowed:raise ValueError('Unsupported finite proof route fields')
        for kind,key,file in (('equivalence','equivalence_method','equivalence.smt2'),('query','method','query.smt2')):
            if method.get(key)=='finite_default':
                if old['cases'][index][kind]['query']!='unsat'or checked['cases'][index][kind]['query']!='unsat':
                    raise ValueError('Unproved direct finite '+kind)
            elif method.get(key)=='exact_tactic':
                original=proof/f'finite/case-{index:02}'/file
                if method.get(key+'_source_sha256')!=c.sha(original):raise ValueError('Alternate finite source changed')
                alternatives.append(dict(value=value,kind=kind,result=t.verify(proof/f'{kind}-tactic-{index:02}',original)))
            else:raise ValueError('Missing finite local-equivalence or leaf proof')
    return dict(normalization=normalization,finite=checked,alternatives=alternatives)


def verify(root,expected_source_sha256,active=None,_session=None):
    root=Path(root);original,proof,kind=source(root)
    if c.sha(original)!=expected_source_sha256:raise ValueError('Certificate does not prove expected original query')
    active=set(active or ())
    key=fingerprint(original)
    if key in active:raise ValueError('Cyclic/circular query proof dependency')
    session=_session if _session is not None else VerificationSession()
    if type(session)is not VerificationSession:raise ValueError('Invalid private verification session')
    digest=certificate_digest(root);epoch=checker_epoch()
    cache_key=(expected_source_sha256,digest,epoch)
    if cache_key in session.entries:
        prior=session.entries[cache_key]
        if active&set(prior['proof_query_fingerprints']):raise ValueError('Cyclic/circular cached proof dependency')
        session.hits+=1
        answer=copy.deepcopy(prior);answer['cached_verification']=True;answer['certificate_input_digest']=digest
        return answer
    active.add(key)
    if kind=='tactic':detail=t.verify(proof,original)
    elif kind=='finite':detail=finite(proof,original)
    elif kind=='reuse':
        import query_lemmas as g
        record=json.loads((root/'certificate.json').read_text());target=g.name(record['target'])
        if c.sha(proof/'targets'/target/'original.smt2')!=expected_source_sha256:
            raise ValueError('Reused proof target does not match expected source')
        old=json.loads((proof/'result.json').read_text())
        selected=[row for row in old['targets']if row['name']==target]
        if len(selected)!=1 or selected[0]['query']['query']!='unsat'or selected[0]['fresh_query']['query']!='unsat':
            raise ValueError('Reused source has no prior independently checked closure')
        detail=g.verify(proof,root/'reuse-verifications'/uuid.uuid4().hex,_active=active,_session=session)
        selected=[row for row in detail['targets']if row['name']==target]
        if len(selected)!=1 or selected[0]['query']['query']!='unsat':raise ValueError('Reused source not freshly proved')
    else:
        detail=p.verify(proof,original)if kind=='piecewise'else n.verify(proof,original)
        answer=c.cli(proof/'normalized.smt2',root/'certificate-verification.log')
        if answer['query']!='unsat':raise ValueError('Standalone normalized query not proved UNSAT: '+answer['query'])
        detail=dict(normalization=detail,query=answer)
    session.fresh+=1
    queries={key}
    if kind=='reuse':queries.update(detail['dependency_query_fingerprints'])
    answer=dict(status='verified_standalone_query_unsat',kind=kind,source_sha256=expected_source_sha256,
                verifier_sha256=c.sha(__file__),details=detail,kernel_checked=False,
                verification_session_id=session.id,verification_id=session.fresh,cached_verification=False,
                certificate_input_digest=digest,proof_query_fingerprints=sorted(queries),
                scope='one provided exported SMT conjunction only; no IR translation, reachability or protocol proof')
    # Verification can add/refresh its own logs. Both exact pre- and post-check
    # byte trees are associated only after actual positive verification.
    if checker_epoch()!=epoch:raise ValueError('Checker/solver epoch changed during verification')
    session.entries[cache_key]=copy.deepcopy(answer)
    after=certificate_digest(root)
    session.entries[(expected_source_sha256,after,epoch)]=copy.deepcopy(answer)
    return answer



if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('certificate',type=Path)
    parser.add_argument('--source',required=True,type=Path);args=parser.parse_args()
    print(json.dumps(verify(args.certificate,c.sha(args.source))))
