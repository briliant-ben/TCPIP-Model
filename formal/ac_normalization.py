"""Typed AC congruence normalization with a separately checked operand certificate.

Hashes order operands only; equality acceptance always compares actual Z3 ASTs.
No Boolean assumption or query constraint is discarded.
"""
from collections import Counter, deque
import hashlib
import z3

COMMUTATIVE = {z3.Z3_OP_AND, z3.Z3_OP_OR, z3.Z3_OP_ADD, z3.Z3_OP_MUL, z3.Z3_OP_EQ}
ASSOCIATIVE = COMMUTATIVE - {z3.Z3_OP_EQ}


def supported(expr):
    if not z3.is_app(expr): return False
    kind = expr.decl().kind()
    if kind in (z3.Z3_OP_ADD, z3.Z3_OP_MUL):
        return expr.sort().kind() in (z3.Z3_INT_SORT, z3.Z3_REAL_SORT)
    return kind in (z3.Z3_OP_AND, z3.Z3_OP_OR) or (kind == z3.Z3_OP_EQ and expr.num_args() == 2)


def flattened(children, kind):
    result = []; stack = list(reversed(children))
    while stack:
        value = stack.pop()
        if kind in ASSOCIATIVE and z3.is_app(value) and value.decl().kind() == kind and value.num_args() > 1:
            stack.extend(reversed(value.children()))
        else: result.append(value)
    return result


def normalize(expr):
    mapping = {}; keys = {}
    def key(value):
        identity = value.get_id()
        if identity not in keys:
            description = value.sort().sexpr() + ':' + (value.decl().sexpr() if z3.is_app(value) else value.sexpr())
            if not z3.is_app(value) or not value.num_args(): description += ':' + value.sexpr()
            parts = [description.encode()]
            if z3.is_app(value): parts += [key(c) for c in value.children()]
            keys[identity] = hashlib.sha256(b'\0'.join(parts)).digest()
        return keys[identity]
    def visit(value):
        identity = value.get_id()
        if identity in mapping: return mapping[identity]
        if not z3.is_app(value) or not value.num_args():
            result = value
        else:
            children = [visit(c) for c in value.children()]
            if supported(value):
                kind = value.decl().kind(); items = sorted(flattened(children, kind), key=key)
                if kind == z3.Z3_OP_AND: result = z3.And(*items)
                elif kind == z3.Z3_OP_OR: result = z3.Or(*items)
                elif kind == z3.Z3_OP_EQ: result = items[0] == items[1]
                elif len(items) == 1: result = value.decl()(*items)
                else:
                    result = items[0]
                    for item in items[1:]:
                        result = result + item if kind == z3.Z3_OP_ADD else result * item
            else: result = value.decl()(*children)
        mapping[identity] = result
        return result
    return visit(expr), mapping


def verify_certificate(expr, mapping):
    """Independently enforce congruence and exact multisets, including duplicates."""
    checked = set(); laws = {}
    def operand_counts(children, kind):
        # Use a separate traversal from the producer's stack flattener.
        queue = deque(children); counts = Counter()
        while queue:
            value = queue.popleft()
            if kind in ASSOCIATIVE and z3.is_app(value) and value.decl().kind() == kind and value.num_args() > 1:
                queue.extend(value.children())
            else: counts[value.get_id()] += 1
        return counts
    def visit(value):
        identity = value.get_id()
        if identity in checked: return
        if identity not in mapping: raise ValueError('Missing normalization node')
        result = mapping[identity]
        if value.sort() != result.sort(): raise ValueError('Normalization changed sort')
        if not z3.is_app(value) or not value.num_args():
            if not z3.eq(value, result): raise ValueError('Normalization changed a leaf')
        else:
            for child in value.children(): visit(child)
            children = [mapping[c.get_id()] for c in value.children()]
            if supported(value):
                kind = value.decl().kind()
                if not z3.is_app(result) or result.decl().kind() != kind:
                    raise ValueError('Normalization changed AC operator')
                if operand_counts(children, kind) != operand_counts(result.children(), kind):
                    raise ValueError('Normalization changed operand multiplicity')
                sort = children[0].sort()
                laws[(kind, sort.sexpr())] = (kind, sort)
            else:
                if not z3.is_app(result) or not z3.eq(value.decl(), result.decl()) or len(children) != result.num_args():
                    raise ValueError('Normalization changed ordered operator')
                if not all(z3.eq(a, b) for a, b in zip(children, result.children())):
                    raise ValueError('Normalization changed ordered children')
        checked.add(identity)
    visit(expr)
    return list(laws.values())


def law_queries(kind, sort):
    prefix = 'ac_law_' + str(kind) + '_' + hashlib.sha256(sort.sexpr().encode()).hexdigest()
    a, b, c = [z3.Const(prefix + suffix, sort) for suffix in ['_a', '_b', '_c']]
    def operation(x, y):
        if kind == z3.Z3_OP_AND: return z3.And(x, y)
        if kind == z3.Z3_OP_OR: return z3.Or(x, y)
        if kind == z3.Z3_OP_ADD: return x + y
        if kind == z3.Z3_OP_MUL: return x * y
        if kind == z3.Z3_OP_EQ: return x == y
        raise ValueError('Unsupported AC law')
    yield 'commutative', z3.Not(operation(a, b) == operation(b, a))
    if kind in ASSOCIATIVE:
        yield 'associative', z3.Not(operation(operation(a, b), c) == operation(a, operation(b, c)))
