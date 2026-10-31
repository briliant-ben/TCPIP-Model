"""Generate typed byte IR constructors; inverse parser binds the ordered source AST.

This Python bridge is trusted. It does not prove interpreter/compiler equivalence.
Unsupported semantic fields are rejected rather than omitted.
"""
import hashlib
import json
from pathlib import Path
import re
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.ir import validate
from protocol_lab.symbolic import model_hash

HEADER = ('From Stdlib Require Import List ZArith.\n'
          'From ByteIR Require Import Semantics.\nImport ListNotations.\nOpen Scope Z_scope.\n')
DEFS = [('compiled_initial', 'list (list Z)'),
        ('compiled_byte_fields', 'list nat'), ('compiled_int_fields', 'list nat'),
        ('compiled_actions', 'list (nat * bexpr)'),
        ('compiled_invariants', 'list (bexpr * bexpr)')]


def admit(model):
    keys = {'ir_version', 'semantics', 'protocol', 'scope', 'states', 'initial_state',
            'variables', 'events', 'timers', 'messages', 'requirements', 'transitions', 'invariants'}
    if set(model) != keys or model['ir_version'] != '0.2' or model['semantics'] != 'flat-efsm-atomic-ordered-v1':
        raise ValueError('Unsupported IR extension/version/semantics')
    validate(model)
    if (len(model['states']) != 1 or model['scope']['terminal_states'] or model['timers'] or model['messages']
            or set(model['scope']) - {'terminal_states', 'excluded'}
            or len(model['events']) != 1 or len(model['transitions']) != 1):
        raise ValueError('Unsupported control, timer, message or scope semantics')
    event, spec = next(iter(model['events'].items()))
    rule = model['transitions'][0]
    if (set(spec) != {'origin', 'fields'} or spec['origin'] != 'application'
            or any(t not in ('bytes', 'int') for t in spec['fields'].values())):
        raise ValueError('Unsupported event fields')
    if (set(rule) != {'id', 'from', 'to', 'event', 'guard', 'requirements', 'actions'}
            or rule['guard'] is not True or rule['from'] != rule['to'] or rule['event'] != event):
        raise ValueError('Unsupported transition semantics')
    if any(set(v) != {'type', 'initial'} or v['type'] != 'bytes' for v in model['variables'].values()):
        raise ValueError('Only byte state variables are supported')
    variables = list(model['variables']); fields = list(spec['fields'])
    def typed(e):
        if type(e) is int: return 'int'
        if type(e) is not dict: raise ValueError('Unsupported expression')
        if set(e) == {'bytes'}: return 'bytes'
        if set(e) == {'var'} and e['var'] in variables: return 'bytes'
        if set(e) == {'event'} and e['event'] in fields: return spec['fields'][e['event']]
        if set(e) != {'op', 'args'}: raise ValueError('Unsupported expression extension')
        signatures = {'bytes_concat': (['bytes', 'bytes'], 'bytes'),
                      'bytes_slice': (['bytes', 'int', 'int'], 'bytes'),
                      'bytes_len': (['bytes'], 'int')}
        if e['op'] not in signatures: raise ValueError('Unsupported expression operation')
        args, result = signatures[e['op']]
        if [typed(a) for a in e['args']] != args: raise ValueError('Expression type mismatch')
        return result
    for a in rule['actions']:
        if (set(a) != {'set'} or set(a['set']) != {'var', 'value'}
                or a['set']['var'] not in variables or typed(a['set']['value']) != 'bytes'):
            raise ValueError('Unsupported assignment')
    for inv in model['invariants']:
        if (set(inv) != {'id', 'requirements', 'assert'} or set(inv['assert']) != {'op', 'args'}
                or inv['assert']['op'] != 'eq' or len(inv['assert']['args']) != 2
                or [typed(a) for a in inv['assert']['args']] != ['bytes', 'bytes']):
            raise ValueError('Only full byte equality invariants are supported')
    return variables, fields


def integer(n): return str(n) if n >= 0 else '(- ' + str(-n) + ')'
def listing(items): return '[' + '; '.join(items) + ']'


def render(model):
    variables, fields = admit(model)
    types = next(iter(model['events'].values()))['fields']
    def expr(e):
        if type(e) is int: return '(ILit ' + integer(e) + ')'
        if 'bytes' in e: return '(BLit ' + listing(map(integer, e['bytes'])) + ')'
        if 'var' in e: return '(BVar ' + str(variables.index(e['var'])) + '%nat)'
        if 'event' in e:
            return '(' + ('BField' if types[e['event']] == 'bytes' else 'IField') + ' ' + str(fields.index(e['event'])) + '%nat)'
        ctor = {'bytes_concat': 'BConcat', 'bytes_slice': 'BSlice', 'bytes_len': 'ILength'}[e['op']]
        return '(' + ctor + ' ' + ' '.join(expr(a) for a in e['args']) + ')'
    values = [listing(listing(map(integer, model['variables'][n]['initial'])) for n in variables),
              listing(str(i) + '%nat' for i,n in enumerate(fields) if types[n] == 'bytes'),
              listing(str(i) + '%nat' for i,n in enumerate(fields) if types[n] == 'int'),
              listing('(' + str(variables.index(a['set']['var'])) + '%nat, ' + expr(a['set']['value']) + ')'
                      for a in model['transitions'][0]['actions']),
              listing('(' + expr(i['assert']['args'][0]) + ', ' + expr(i['assert']['args'][1]) + ')'
                      for i in model['invariants'])]
    return HEADER + ''.join('Definition ' + n + ' : ' + t + ' := ' + v + '.\n'
                            for (n,t),v in zip(DEFS, values))


class Parser:
    """Independent typed inverse grammar, without calling the producer mapping."""
    def __init__(self, text, variables, fields, types):
        self.tokens = re.findall(r'%nat|[A-Za-z_][A-Za-z_0-9]*|[0-9]+|[\[\]();,\-]', text)
        if ''.join(self.tokens) != re.sub(r'\s+', '', text): raise ValueError('Unknown generated token')
        self.i = 0; self.variables = variables; self.fields = fields; self.types = types
    def take(self, expected=None):
        if self.i >= len(self.tokens): raise ValueError('Truncated generated term')
        value = self.tokens[self.i]; self.i += 1
        if expected is not None and value != expected: raise ValueError('Unexpected constructor/token')
        return value
    def number(self, nat=False):
        if not nat and self.i < len(self.tokens) and self.tokens[self.i] == '(':
            self.take('('); self.take('-'); n = self.number(); self.take(')'); return -n
        t = self.take()
        if not t.isdigit(): raise ValueError('Expected numeral')
        if nat: self.take('%nat')
        return int(t)
    def items(self, entry):
        self.take('['); result = []
        if self.i < len(self.tokens) and self.tokens[self.i] != ']':
            result.append(entry())
            while self.i < len(self.tokens) and self.tokens[self.i] == ';':
                self.take(';'); result.append(entry())
        self.take(']'); return result
    def expr(self, kind):
        self.take('('); ctor = self.take()
        if ctor == 'ILit' and kind == 'int': result = self.number()
        elif ctor == 'BLit' and kind == 'bytes': result = {'bytes': self.items(self.number)}
        elif ctor == 'BVar' and kind == 'bytes':
            n = self.number(True)
            if n >= len(self.variables): raise ValueError('Lookup outside source variables')
            result = {'var': self.variables[n]}
        elif ctor in ('BField', 'IField') and kind == ('bytes' if ctor == 'BField' else 'int'):
            n = self.number(True)
            if n >= len(self.fields) or self.types[self.fields[n]] != kind: raise ValueError('Field type/index mismatch')
            result = {'event': self.fields[n]}
        elif ctor == 'BConcat' and kind == 'bytes':
            result = {'op': 'bytes_concat', 'args': [self.expr('bytes'), self.expr('bytes')]}
        elif ctor == 'BSlice' and kind == 'bytes':
            result = {'op': 'bytes_slice', 'args': [self.expr('bytes'), self.expr('int'), self.expr('int')]}
        elif ctor == 'ILength' and kind == 'int': result = {'op': 'bytes_len', 'args': [self.expr('bytes')]}
        else: raise ValueError('Unsupported typed constructor')
        self.take(')'); return result


def verify_text(model, text):
    variables, fields = admit(model); types = next(iter(model['events'].values()))['fields']
    pattern = re.escape(HEADER) + ''.join(re.escape('Definition ' + n + ' : ' + t + ' := ') + r'([^\n]*)' + re.escape('.\n') for n,t in DEFS)
    match = re.fullmatch(pattern, text)
    if match is None: raise ValueError('Unexpected definitions/code')
    ps = [Parser(x, variables, fields, types) for x in match.groups()]
    p = ps[0]; initial = p.items(lambda: p.items(p.number))
    byte_fields = ps[1].items(lambda: ps[1].number(True)); int_fields = ps[2].items(lambda: ps[2].number(True))
    p = ps[3]
    def action():
        p.take('('); n = p.number(True); p.take(','); value = p.expr('bytes'); p.take(')')
        if n >= len(variables): raise ValueError('Assignment outside source mapping')
        return {'set': {'var': variables[n], 'value': value}}
    actions = p.items(action); p = ps[4]
    def prop():
        p.take('('); a = p.expr('bytes'); p.take(','); b = p.expr('bytes'); p.take(')')
        return {'op': 'eq', 'args': [a,b]}
    props = p.items(prop)
    if any(p.i != len(p.tokens) for p in ps): raise ValueError('Extra generated terms')
    if (initial != [model['variables'][n]['initial'] for n in variables]
            or byte_fields != [i for i,n in enumerate(fields) if types[n] == 'bytes']
            or int_fields != [i for i,n in enumerate(fields) if types[n] == 'int']
            or actions != model['transitions'][0]['actions']
            or props != [i['assert'] for i in model['invariants']]):
        raise ValueError('Generated AST does not match complete ordered source IR')
    return dict(status='source_ir_and_generated_ast_structurally_equal', variables=variables,
                fields=fields, actions=len(actions), invariants=len(props), model_semantic_sha256=model_hash(model),
                scope='restricted full-byte constructor binding; Python bridge trusted, not a compiler proof')


def sha(path): return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def generate(model_file, out):
    model_file = Path(model_file); out = Path(out); out.mkdir(parents=True, exist_ok=True)
    if (out/'Compiled.v').exists(): raise ValueError('Fresh output required')
    model = json.loads(model_file.read_text()); text = render(model); result = verify_text(model,text)
    (out/'Compiled.v').write_text(text)
    result.update(source_sha256=sha(model_file), generated_sha256=sha(out/'Compiled.v'), checker_sha256=sha(__file__))
    (out/'binding.json').write_text(json.dumps(result,indent=2)+'\n'); return result
