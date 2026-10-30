"""Specialize an exported conjunction using only its asserted equalities.

All Boolean cases and original assertions are retained. Independent verification
checks each local XOR using only source equalities and case facts, then runs a
fresh CLI on every leaf. Python/Z3 are trusted; no IR translation/kernel proof.
"""
import argparse
import itertools
import json
from pathlib import Path

import z3
from modular_normalization import cli, sha, solver_binary, write
from tactic_recheck import read_query

MAX_SELECTORS = 4
SCOPE = 'one exact exported conjunction; no reachability, IR translation, kernel or protocol proof'


def script(terms):
    solver = z3.Solver()
    solver.add(*terms)
    return solver.to_smt2()


def check_terms(path, expected):
    # Compare against the parsed export, including Z3's negative integer spelling.
    canonical = list(z3.parse_smt2_string(script(expected)))
    actual = read_query(path)
    if len(actual) != len(canonical) or any(not a.eq(b) for a, b in zip(actual, canonical)):
        raise ValueError('Assertion order, coverage or expression changed: ' + str(path))
    return actual


def conjuncts(expr, path=()):
    if z3.is_and(expr):
        for i, child in enumerate(expr.children()):
            yield from conjuncts(child, path + (i,))
    else:
        yield list(path), expr


def at(expr, path):
    if not isinstance(path, list) or any(type(i) is not int or i < 0 for i in path):
        raise ValueError('Invalid expression path')
    for index in path:
        if index >= expr.num_args():
            raise ValueError('Expression path outside source')
        expr = expr.arg(index)
    return expr


def first_if_path(expr, path=()):
    if z3.is_app_of(expr, z3.Z3_OP_ITE):
        return list(path)
    for i, child in enumerate(expr.children()):
        found = first_if_path(child, path + (i,))
        if found is not None:
            return found
    return None


def source_parts(terms, recipe):
    if set(recipe) != {'target', 'definitions', 'selectors'}:
        raise ValueError('Unsupported recipe fields')
    def admitted(expr):
        if not z3.is_app(expr):
            raise ValueError('Quantifiers and bound variables are unsupported')
        for child in expr.children():
            admitted(child)
    for term in terms:
        admitted(term)
    target = recipe['target']
    if type(target) is not int or not 0 <= target < len(terms):
        raise ValueError('Invalid target assertion')
    definitions = []
    for row in recipe['definitions']:
        if set(row) != {'assertion', 'path'}:
            raise ValueError('Invalid source equality reference')
        index = row['assertion']
        if type(index) is not int or not 0 <= index < len(terms) or index == target:
            raise ValueError('Definition must be an original non-target assertion')
        candidates = dict((tuple(p), e) for p, e in conjuncts(terms[index]))
        expr = candidates.get(tuple(row['path']))
        if expr is None or not z3.is_eq(expr) or not z3.is_const(expr.arg(0)) or expr.arg(0).decl().kind() != z3.Z3_OP_UNINTERPRETED:
            raise ValueError('Definition must be a positive asserted constant equality')
        definitions.append(expr)
    if not 1 <= len(recipe['selectors']) <= MAX_SELECTORS:
        raise ValueError('Unsupported number of Boolean selectors')
    conditions = []
    for row in recipe['selectors']:
        if set(row) != {'definition', 'ite_path'}:
            raise ValueError('Invalid selector reference')
        index = row['definition']
        if type(index) is not int or not 0 <= index < len(definitions):
            raise ValueError('Selector definition outside source list')
        node = at(definitions[index].arg(1), row['ite_path'])
        if not z3.is_app_of(node, z3.Z3_OP_ITE):
            raise ValueError('Selector must address a source conditional')
        condition = node.arg(0)
        for equality in definitions:
            condition = z3.substitute(condition, (equality.arg(0), equality.arg(1)))
        conditions.append(condition)
    return target, definitions, conditions


def recipe_for(source, names, selector_names):
    """Names are explicit query configuration, never protocol semantics."""
    terms = read_query(source)
    if len(names) != len(set(names)):
        raise ValueError('Duplicate definition names')
    found = {}
    for i, expr in enumerate(terms[:-1]):
        for path, clause in conjuncts(expr):
            if z3.is_eq(clause) and z3.is_const(clause.arg(0)):
                found.setdefault(str(clause.arg(0)), (i, path, clause))
    if any(name not in found for name in names + selector_names):
        raise ValueError('Requested definition not in source')
    definitions = [dict(assertion=found[name][0], path=found[name][1]) for name in names]
    selectors = []
    for name in selector_names:
        if name not in names:
            raise ValueError('Selector must have a selected definition')
        path = first_if_path(found[name][2].arg(1))
        if path is None:
            raise ValueError('Selector definition contains no conditional')
        selectors.append(dict(definition=names.index(name), ite_path=path))
    return dict(target=len(terms)-1, definitions=definitions, selectors=selectors)


def cases(conditions):
    for bits in itertools.product((False, True), repeat=len(conditions)):
        yield list(bits), [c if bit else z3.Not(c) for c, bit in zip(conditions, bits)]


def status(rows, context):
    if any(row['equivalence']['query'] != 'unsat' for row in rows):
        return 'local_equivalence_unknown'
    if all(row['query']['query'] == 'unsat' for row in rows):
        return {'sat':'exact_query_unsat_nonvacuous', 'unsat':'exact_query_unsat_vacuous_context', 'unknown':'exact_query_unsat_context_unresolved'}[context['query']]
    return 'sat_not_reachability_proof' if any(row['query']['query'] == 'sat' for row in rows) else 'unknown'


def produce(source, out, recipe):
    source, out = Path(source), Path(out)
    if out.exists():
        raise ValueError('Use a fresh evidence directory')
    terms = read_query(source)
    target, definitions, conditions = source_parts(terms, recipe)
    out.mkdir(parents=True)
    (out/'source.smt2').write_bytes(source.read_bytes())
    expanded = terms[target]
    for equality in definitions:
        after = z3.substitute(expanded, (equality.arg(0), equality.arg(1)))
        expanded = after
    all_cases = list(cases(conditions))
    coverage = [z3.Not(z3.Or(*[z3.And(*facts) for _, facts in all_cases]))]
    (out/'coverage.smt2').write_text(script(coverage))
    cover_result = cli(out/'coverage.smt2', out/'coverage.log')
    if cover_result['query'] != 'unsat':
        raise ValueError('Boolean case coverage not proved')
    (out/'context.smt2').write_text(script(terms[:target] + terms[target+1:]))
    context = cli(out/'context.smt2', out/'context.log')
    rows = []
    for i, (bits, facts) in enumerate(all_cases):
        directory = out/('case-' + str(i).zfill(2))
        directory.mkdir()
        derived = z3.simplify(z3.substitute(expanded, *[(c, z3.BoolVal(bit)) for c, bit in zip(conditions, bits)]))
        # All selected source equalities (and only those) are allowed premises.
        (directory/'equivalence.smt2').write_text(script(definitions + facts + [z3.Xor(terms[target], derived)]))
        eq = cli(directory/'equivalence.smt2', directory/'equivalence.log')
        (directory/'query.smt2').write_text(script(terms + facts + [derived]))
        answer = cli(directory/'query.smt2', directory/'query.log') if eq['query'] == 'unsat' else dict(query='unknown')
        rows.append(dict(bits=bits, equivalence=eq, query=answer))
    result = dict(status=status(rows, context), recipe=recipe, source_sha256=sha(out/'source.smt2'),
                  source_assertions=len(terms), coverage=cover_result, context=context, cases=rows,
                  checker_sha256=sha(__file__), solver_sha256=sha(solver_binary()), timeout_ms=10000,
                  dependencies={name:sha(Path(__file__).parent/name) for name in ('modular_normalization.py','tactic_recheck.py','partition_queries.py')},
                  scope=SCOPE, kernel_checked=False)
    result['files'] = {str(p.relative_to(out)):sha(p) for p in sorted(out.rglob('*')) if p.is_file()}
    write(out/'result.json', result)
    return result


def verify(out, source=None):
    out = Path(out)
    result = json.loads((out/'result.json').read_text())
    if result['checker_sha256'] != sha(__file__) or result['solver_sha256'] != sha(solver_binary()):
        raise ValueError('Checker or solver changed')
    if result['timeout_ms'] != 10000 or result['scope'] != SCOPE or result['kernel_checked'] is not False:
        raise ValueError('Scope or budget changed')
    actual_files = {str(p.relative_to(out)):sha(p) for p in sorted(out.rglob('*'))
                    if p.is_file() and p.name != 'result.json' and not p.name.endswith('.independent.log')}
    if actual_files != result['files'] or sha(out/'source.smt2') != result['source_sha256']:
        raise ValueError('Evidence file coverage or hashes changed')
    expected_dependencies = {name:sha(Path(__file__).parent/name) for name in ('modular_normalization.py','tactic_recheck.py','partition_queries.py')}
    if result['dependencies'] != expected_dependencies:
        raise ValueError('Dependency changed')
    if source is not None and sha(source) != result['source_sha256']:
        raise ValueError('Source differs from expected original')
    terms = read_query(out/'source.smt2')
    target, definitions, conditions = source_parts(terms, result['recipe'])
    if len(terms) != result['source_assertions']:
        raise ValueError('Source assertion coverage changed')
    all_cases = list(cases(conditions))
    if len(result['cases']) != len(all_cases):
        raise ValueError('Missing Boolean cases')
    coverage = [z3.Not(z3.Or(*[z3.And(*facts) for _, facts in all_cases]))]
    check_terms(out/'coverage.smt2', coverage)
    cover = cli(out/'coverage.smt2', out/'coverage.independent.log')
    if cover['query'] != 'unsat':
        raise ValueError('Case coverage not independently proved')
    check_terms(out/'context.smt2', terms[:target] + terms[target+1:])
    context = cli(out/'context.smt2', out/'context.independent.log')
    rows = []
    for i, ((bits, facts), old) in enumerate(zip(all_cases, result['cases'])):
        if old['bits'] != bits:
            raise ValueError('Missing, duplicated or reordered Boolean case')
        directory = out/('case-' + str(i).zfill(2))
        actual = read_query(directory/'query.smt2')
        derived = actual[-1]
        check_terms(directory/'query.smt2', terms + facts + [derived])
        # Do not trust producer substitution/simplification: reconstruct local
        # theorem around the ACTUAL proposed leaf and original source clauses.
        check_terms(directory/'equivalence.smt2', definitions + facts + [z3.Xor(terms[target], derived)])
        eq = cli(directory/'equivalence.smt2', directory/'equivalence.independent.log')
        answer = cli(directory/'query.smt2', directory/'query.independent.log') if eq['query'] == 'unsat' else dict(query='unknown')
        for name, current in (('equivalence',eq), ('query',answer)):
            if old[name]['query'] not in ('sat','unsat','unknown'):
                raise ValueError('Invalid result classification')
            # A positive source closure must be reproducible, never promoted
            # from unknown by editing the report.
            if old[name]['query'] == 'unsat' and current['query'] != 'unsat':
                raise ValueError('UNSAT not reproduced by fresh CLI')
        rows.append(dict(bits=bits, equivalence=eq, query=answer))
    if result['status'] != status(result['cases'],result['context']):
        raise ValueError('Scope/classification does not match all cases')
    if result['context']['query'] == 'sat' and context['query'] != 'sat':
        raise ValueError('Nonvacuity not independently reproduced')
    return dict(status='verified_conditional_query_evidence', producer_status=result['status'],
                fresh_status=status(rows,context), source_sha256=result['source_sha256'],
                context=context, cases=rows, kernel_checked=False, scope=SCOPE)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', nargs='?', type=Path)
    parser.add_argument('--out', required=True, type=Path)
    parser.add_argument('--recipe', type=Path)
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    if args.verify:
        answer = verify(args.out,args.source)
    else:
        if args.source is None or args.recipe is None:
            parser.error('source and --recipe required')
        answer = produce(args.source,args.out,json.loads(args.recipe.read_text()))
    print(json.dumps(answer))
