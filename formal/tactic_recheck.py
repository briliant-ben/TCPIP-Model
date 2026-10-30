"""Recheck an unchanged single SMT query with an explicit fixed Z3 pipeline.

No assertion is sliced or rewritten by this adapter. Z3's tactic engine is trusted;
this is not a kernel-checked certificate or an interpreter/translator proof.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

import z3
from partition_queries import top_commands

PIPELINE='(then simplify propagate-values solve-eqs simplify smt)'
TIMEOUT_MS=10000


def digest(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read_query(path):
    source=Path(path).read_text()
    commands=top_commands(source)
    allowed={'set-info','declare-fun','declare-const','assert','check-sat'}
    if not commands or commands[-1]!='check-sat' or commands.count('check-sat')!=1 or not set(commands)<=allowed:
        raise ValueError('Unsupported incremental, option-changing or multiple-check source')
    terms=list(z3.parse_smt2_string(source))
    if not terms or len(terms)!=commands.count('assert'):raise ValueError('Incomplete assertion coverage')
    return terms


def script_for(terms):
    solver=z3.Solver();solver.add(*terms)
    script=solver.to_smt2()
    suffix='(check-sat)\n'
    if not script.endswith(suffix):raise ValueError('Unexpected solver export')
    return script[:-len(suffix)]+f'(check-sat-using (try-for {PIPELINE} {TIMEOUT_MS}))\n'


def check_script(source, script):
    """Compare every parsed assertion in order; no omitted/extra premises allowed."""
    expected=read_query(source)
    text=Path(script).read_text()
    suffix=f'(check-sat-using (try-for {PIPELINE} {TIMEOUT_MS}))\n'
    if not text.endswith(suffix):raise ValueError('Strategy or budget changed')
    plain=text[:-len(suffix)]+'(check-sat)\n'
    commands=top_commands(plain)
    if not set(commands)<={'set-info','declare-fun','declare-const','assert','check-sat'} or commands[-1]!='check-sat' or commands.count('check-sat')!=1:
        raise ValueError('Unsupported execution commands')
    actual=list(z3.parse_smt2_string(plain))
    if len(actual)!=len(expected) or any(not a.eq(b)for a,b in zip(actual,expected)):
        raise ValueError('Original assertion changed or omitted')
    return len(expected)


def solver_binary():
    path=Path(sys.executable).parent/'z3'
    if not path.is_file():raise ValueError('Independent Z3 CLI unavailable')
    return path.resolve()


def execute(script, log):
    binary=solver_binary();start=time.monotonic()
    try:
        result=subprocess.run([str(binary),'-smt2',str(Path(script).resolve())],capture_output=True,text=True,timeout=TIMEOUT_MS/1000+5)
        output=result.stdout+result.stderr
        if result.returncode==0 and result.stdout.strip()in ('sat','unsat','unknown') and not result.stderr.strip():
            answer=result.stdout.strip()
        elif 'canceled'in output and 'unsat'not in output and 'sat'not in output:
            answer='unknown'
        else:raise ValueError('Unexpected Z3 CLI result: '+output[:500])
    except subprocess.TimeoutExpired as error:
        def decode(x):return x.decode(errors='replace')if isinstance(x,bytes)else x or ''
        output=decode(error.stdout)+decode(error.stderr)+'\nExternal resource deadline exceeded\n';answer='unknown'
    Path(log).write_text(output)
    return dict(query=answer,seconds=time.monotonic()-start,binary_sha256=digest(binary),
        solver_cli_version=subprocess.check_output([str(binary),'-version'],text=True).strip())


def produce(source,out):
    source=Path(source);out=Path(out);out.mkdir(parents=True,exist_ok=True)
    if (out/'result.json').exists():raise ValueError('Use a fresh directory; previous evidence is retained')
    before=digest(source);terms=read_query(source)
    script=out/'query.smt2';script.write_text(script_for(terms));count=check_script(source,script)
    result=execute(script,out/'solver.log')
    if digest(source)!=before:raise ValueError('Source changed during execution')
    result.update(status='exact_query_tactic_unsat'if result['query']=='unsat'else 'sat_not_reachability_proof'if result['query']=='sat'else'unknown',
        source_file=str(source),source_sha256=before,assertion_count=count,script_sha256=digest(script),
        solver_log_sha256=digest(out/'solver.log'),pipeline=PIPELINE,timeout_ms=TIMEOUT_MS,
        checker_sha256=digest(__file__),all_original_assertions_retained=True,
        scope='one original SMT conjunction; no protocol, reachability, byte/time or kernel proof')
    (out/'result.json').write_text(json.dumps(result,indent=2)+'\n');return result


def verify(out,source=None):
    out=Path(out);r=json.loads((out/'result.json').read_text());source=Path(source or r['source_file'])
    if r['status']!='exact_query_tactic_unsat' or r['query']!='unsat':raise ValueError('No passing exact tactic result')
    if r['pipeline']!=PIPELINE or r['timeout_ms']!=TIMEOUT_MS or not r['all_original_assertions_retained']:raise ValueError('Strategy or scope changed')
    if digest(source)!=r['source_sha256'] or digest(__file__)!=r['checker_sha256']:raise ValueError('Source/checker changed')
    if digest(out/'query.smt2')!=r['script_sha256'] or digest(out/'solver.log')!=r['solver_log_sha256']:raise ValueError('Artifact changed')
    count=check_script(source,out/'query.smt2')
    if count!=r['assertion_count']:raise ValueError('Assertion coverage changed')
    if digest(solver_binary())!=r['binary_sha256']:raise ValueError('Solver CLI changed')
    answer=execute(out/'query.smt2',out/'independent-cli.log')
    if answer['query']!='unsat':raise ValueError('Fresh CLI did not prove original query unsat: '+answer['query'])
    if answer['solver_cli_version']!=r['solver_cli_version']:raise ValueError('Solver version changed')
    return dict(status='valid_exact_query_tactic_unsat',assertions=count,source_sha256=r['source_sha256'],
        fresh_cli=answer,log_sha256=digest(out/'independent-cli.log'),kernel_checked=False)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('source',nargs='?',type=Path)
    parser.add_argument('--out',required=True,type=Path);parser.add_argument('--verify',action='store_true')
    args=parser.parse_args()
    if args.verify:result=verify(args.out,args.source)
    else:
        if args.source is None:parser.error('source required')
        result=produce(args.source,args.out)
    print(json.dumps(result))
    if result['status']not in ('exact_query_tactic_unsat','valid_exact_query_tactic_unsat'):raise SystemExit(2)
