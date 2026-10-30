"""Source IR -> restricted Rocq data AST, plus independent inverse structural gate."""
import hashlib
import json
from pathlib import Path
import re
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from protocol_lab.ir import validate
from protocol_lab.symbolic import model_hash

OPS={'add':'EAdd','sub':'ESub','seq_add':'ESeqAdd','seq_distance':'EDistance'}
HEADER='From Stdlib Require Import List ZArith.\nFrom ScalarIR Require Import Semantics.\nImport ListNotations.\nOpen Scope Z_scope.\n'
DEFINITIONS=[('compiled_initial','list Z'),('compiled_seq_fields','list nat'),('compiled_actions','list (nat * expr)'),('compiled_invariants','list (expr * expr)')]


def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def admit(model):
    keys={'ir_version','semantics','protocol','scope','states','initial_state','variables','events','timers','messages','requirements','transitions','invariants'}
    if set(model)!=keys or model['ir_version']!='0.2' or model['semantics']!='flat-efsm-atomic-ordered-v1':
        raise ValueError('Unsupported IR version, extension or semantic fields')
    validate(model)
    if len(model['states'])!=1 or model['scope']['terminal_states'] or model['timers'] or model['messages']:
        raise ValueError('Unsupported control, timer or message semantics')
    if set(model['scope'])-{'terminal_states','excluded'} or len(model['events'])!=1 or len(model['transitions'])!=1:
        raise ValueError('Unsupported scope, event or transition semantics')
    event=next(iter(model['events']));spec=model['events'][event];rule=model['transitions'][0]
    if set(spec)!={'origin','fields'}or spec['origin']!='application' or any(t not in ('seq32','int')for t in spec['fields'].values()):
        raise ValueError('Unsupported event origin or scalar field type')
    if set(rule)!={'id','from','to','event','guard','requirements','actions'}or rule['guard']is not True or rule['from']!=rule['to']or rule['event']!=event:
        raise ValueError('Unsupported guard, target or rule fields')
    for variable in model['variables'].values():
        if set(variable)!={'type','initial'}or variable['type']not in ('seq32','int'):
            raise ValueError('Unsupported variable semantics')
    variables=list(model['variables']);fields=list(spec['fields'])
    def expression(e):
        if type(e)is int:return
        if type(e)is not dict:raise ValueError('Unsupported scalar literal')
        if set(e)=={'var'}and e['var']in variables:return
        if set(e)=={'event'}and e['event']in fields:return
        if set(e)=={'op','args'}and e['op']in OPS and len(e['args'])==2:
            for a in e['args']:expression(a)
            return
        raise ValueError('Unsupported expression semantics')
    for action in rule['actions']:
        if set(action)!={'set'}or set(action['set'])!={'var','value'}:raise ValueError('Unsupported action semantics')
        expression(action['set']['value'])
    for inv in model['invariants']:
        if set(inv)!={'id','requirements','assert'}or set(inv['assert'])!={'op','args'}or inv['assert']['op']!='eq' or len(inv['assert']['args'])!=2:
            raise ValueError('Unsupported invariant semantics')
        for e in inv['assert']['args']:expression(e)
    return variables,fields


def render(model):
    variables,fields=admit(model)
    def integer(n):return str(n)if n>=0 else '(- '+str(-n)+')'
    def expr(e):
        if type(e)is int:return '(ELit '+integer(e)+')'
        if 'var'in e:return '(EVar '+str(variables.index(e['var']))+'%nat)'
        if 'event'in e:return '(EField '+str(fields.index(e['event']))+'%nat)'
        return '('+OPS[e['op']]+' '+expr(e['args'][0])+' '+expr(e['args'][1])+')'
    seq=[str(i)+'%nat'for i,name in enumerate(fields)if next(iter(model['events'].values()))['fields'][name]=='seq32']
    data=[ [integer(model['variables'][n]['initial'])for n in variables],seq,
        ['('+str(variables.index(a['set']['var']))+'%nat, '+expr(a['set']['value'])+')'for a in model['transitions'][0]['actions']],
        ['('+expr(i['assert']['args'][0])+', '+expr(i['assert']['args'][1])+')'for i in model['invariants']]]
    return HEADER+''.join('Definition '+name+' : '+kind+' := ['+'; '.join(values)+'].\n'for (name,kind),values in zip(DEFINITIONS,data))


class Parser:
    """Decode constructors to source JSON; does not call render or its expression mapper."""
    def __init__(self,text,variables,fields):
        self.tokens=re.findall(r'%nat|[A-Za-z_][A-Za-z_0-9]*|[0-9]+|[\[\]();,\-]',text)
        if ''.join(self.tokens)!=re.sub(r'\s+','',text):raise ValueError('Unsupported generated token')
        self.index=0;self.variables=variables;self.fields=fields
    def take(self,expected=None):
        if self.index>=len(self.tokens):raise ValueError('Truncated generated term')
        value=self.tokens[self.index];self.index+=1
        if expected is not None and value!=expected:raise ValueError('Unexpected generated constructor/token')
        return value
    def number(self,nat=False):
        if not nat and self.tokens[self.index]=='(':
            self.take('(');self.take('-');value=-int(self.take());self.take(')');return value
        token=self.take()
        if not token.isdigit():raise ValueError('Expected generated numeral')
        if nat:self.take('%nat')
        return int(token)
    def expr(self):
        self.take('(');kind=self.take()
        if kind=='ELit':result=self.number()
        elif kind in ('EVar','EField'):
            index=self.number(True);names=self.variables if kind=='EVar'else self.fields
            if not 0<=index<len(names):raise ValueError('Generated lookup outside source mapping')
            result={'var'if kind=='EVar'else'event':names[index]}
        else:
            inverse={'EAdd':'add','ESub':'sub','ESeqAdd':'seq_add','EDistance':'seq_distance'}
            if kind not in inverse:raise ValueError('Unsupported generated expression constructor')
            result={'op':inverse[kind],'args':[self.expr(),self.expr()]}
        self.take(')');return result
    def listing(self,entry):
        self.take('[');values=[]
        if self.tokens[self.index]!=']':
            values.append(entry())
            while self.tokens[self.index]==';':self.take(';');values.append(entry())
        self.take(']')
        if self.index!=len(self.tokens):raise ValueError('Extra generated code/term')
        return values


def verify_text(model,text):
    variables,fields=admit(model)
    pattern=re.escape(HEADER)+''.join(re.escape('Definition '+name+' : '+kind+' := ')+r'([^\n]*)'+re.escape('.\n')for name,kind in DEFINITIONS)
    match=re.fullmatch(pattern,text)
    if match is None:raise ValueError('Generated module has unexpected definitions or code')
    parsers=[Parser(part,variables,fields)for part in match.groups()]
    initial=parsers[0].listing(lambda:parsers[0].number())
    seq=parsers[1].listing(lambda:parsers[1].number(True))
    p=parsers[2]
    def action():
        p.take('(');index=p.number(True);p.take(',');value=p.expr();p.take(')')
        if not 0<=index<len(variables):raise ValueError('Generated assignment outside source variables')
        return {'set':{'var':variables[index],'value':value}}
    actions=p.listing(action);p=parsers[3]
    def invariant():
        p.take('(');a=p.expr();p.take(',');b=p.expr();p.take(')');return {'op':'eq','args':[a,b]}
    invs=p.listing(invariant)
    expected_seq=[i for i,n in enumerate(fields)if next(iter(model['events'].values()))['fields'][n]=='seq32']
    if initial!=[model['variables'][n]['initial']for n in variables]or seq!=expected_seq or actions!=model['transitions'][0]['actions']or invs!=[i['assert']for i in model['invariants']]:
        raise ValueError('Generated AST does not match complete ordered source IR')
    return dict(status='source_ir_and_generated_ast_structurally_equal',variables=variables,fields=fields,
        actions=len(actions),invariants=len(invs),model_semantic_sha256=model_hash(model),
        scope='restricted fragment constructor binding; Python checker trusted, not universal compiler/interpreter proof')


def generate(model_file,out):
    model_file=Path(model_file);out=Path(out);out.mkdir(parents=True,exist_ok=True)
    if (out/'Compiled.v').exists():raise ValueError('Fresh output required')
    model=json.loads(model_file.read_text());text=render(model);binding=verify_text(model,text)
    (out/'Compiled.v').write_text(text)
    binding.update(source_file=str(model_file),source_sha256=sha(model_file),generated_sha256=sha(out/'Compiled.v'),checker_sha256=sha(__file__))
    (out/'binding.json').write_text(json.dumps(binding,indent=2)+'\n');return binding
