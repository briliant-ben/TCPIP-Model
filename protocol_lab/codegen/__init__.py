"""Direct native code generation from an explicitly admitted Protocol IR fragment."""
import hashlib
import json
import re
from pathlib import Path
from ..ir import infer,validate,model_files,load
from ..symbolic import model_hash

HERE=Path(__file__).resolve().parent
KINDS={'int':0,'bool':1,'seq32':2}
OPS={'eq','ne','and','or','not','implies','add','sub','mul','le','ge','min','ite',
     'seq_add','seq_distance','seq_lt','seq_le','seq_comparable'}

class Unsupported(ValueError): pass

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def cstr(s):return '"'+''.join('\\%03o'%b for b in s.encode())+'"'
def integer(n):
    if not -(1<<63)<=n<(1<<63):raise Unsupported('Integer literal outside signed 64-bit backend domain')
    return 'INT64_MIN'if n==-(1<<63)else '(-INT64_C('+str(-n)+'))'if n<0 else 'INT64_C('+str(n)+')'


def admit(m):
    validate(m)
    names=list(m['states'])+list(m['variables'])+list(m['events'])+list(m['timers'])+list(m['messages'])
    if any(len(n.encode())>256 for n in names):raise Unsupported('Native name capacity exceeded')
    if len(m['variables'])>256:raise Unsupported('Native variable capacity exceeded')
    if any(not re.fullmatch(r'[A-Za-z0-9_.:-]+',n)for n in m['events']):raise Unsupported('Event name cannot be represented in line interface')
    if set(m)!={'ir_version','protocol','semantics','scope','states','initial_state','variables','events','timers','messages','requirements','transitions','invariants'}:
        raise Unsupported('Unknown model fields')
    if m['ir_version']not in ('0.1','0.2')or m['semantics']!='flat-efsm-atomic-ordered-v1':
        raise Unsupported('Backend requires IR0.1/0.2 atomic ordered v1; clock-v3/rational unsupported')
    for v in m['variables'].values():
        if set(v)!={'type','initial'}or v['type']not in KINDS:raise Unsupported('Only int/bool/seq32 state supported in native-v1')
        integer(v['initial'])
    for spec in m['events'].values():
        if set(spec)!={'origin','fields'}or any(t not in KINDS for t in spec['fields'].values())or len(spec['fields'])>64:
            raise Unsupported('Unsupported event schema')
        if spec['origin']=='timer'and spec['fields']:raise Unsupported('Timer event fields unsupported')
    for spec in m['messages'].values():
        if set(spec)!={'fields'}or any(t not in (*KINDS,'string')for t in spec['fields'].values()):raise Unsupported('Unsupported message schema')
    if any(set(t)!={'event'}for t in m['timers'].values()):raise Unsupported('Unsupported timer fields')
    def expr(e):
        if type(e)is int:integer(e);return
        if type(e)in (str,bool):return
        if type(e)is not dict:raise Unsupported('Unsupported literal')
        if set(e)in ({'var'},{'event'},{'state'},{'timer_active'}):return
        if set(e)=={'seq'}:integer(e['seq']);return
        if set(e)=={'op','args'}and e['op']in OPS:
            for a in e['args']:expr(a)
            return
        raise Unsupported('Unsupported expression; bytes/clock/rational are not lowered')
    for r in m['transitions']:
        if set(r)!={'id','from','to','event','guard','actions','requirements'}:raise Unsupported('Unsupported rule/target fields')
        expr(r['guard'])
        for a in r['actions']:
            k,p=next(iter(a.items()))
            if k=='set':
                if set(p)!={'var','value'}:raise Unsupported('Extra assignment semantics')
                expr(p['value'])
            elif k in ('emit','emit_if'):
                if set(p)!=({'message','fields','when'}if k=='emit_if'else{'message','fields'}):raise Unsupported('Extra emission semantics')
                if k=='emit_if':expr(p['when'])
                for e in p['fields'].values():expr(e)
            elif k in ('arm','arm_if'):
                if set(p)!=({'timer','delay_ms','when'}if k=='arm_if'else{'timer','delay_ms'}):raise Unsupported('Extra timer semantics')
                expr(p['delay_ms'])
                if k=='arm_if':expr(p['when'])
            elif k=='cancel':pass
            elif k=='cancel_if':
                if set(p)!={'timer','when'}:raise Unsupported('Extra timer semantics')
                expr(p['when'])
            else:raise Unsupported('Unsupported action '+k)
    for inv in m['invariants']:
        if set(inv)!={'id','requirements','assert'}:raise Unsupported('Unsupported invariant fields')
        expr(inv['assert'])


def render(m):
    admit(m)
    variables=list(m['variables']);events=list(m['events']);timers=list(m['timers']);states=m['states']
    lines=[(HERE/'runtime.c').read_text()]
    emit=lines.append
    def exp(e,event=None):
        if type(e)is bool:return '1'if e else'0'
        if type(e)is int:return integer(e)
        if type(e)is str:return cstr(e)
        if 'seq'in e:return integer(e['seq'])
        if 'var'in e:return 'm->v['+str(variables.index(e['var']))+']'
        if 'event'in e:return 'f['+str(list(m['events'][event]['fields']).index(e['event']))+']'
        if 'state'in e:return '(m->state=='+str(states.index(e['state']))+')'
        if 'timer_active'in e:return 'm->active['+str(timers.index(e['timer_active']))+']'
        a=[exp(x,event)for x in e['args']];op=e['op']
        if op in ('eq','ne')and infer(e['args'][0],m,event)=='string':return '(strcmp('+a[0]+','+a[1]+')'+('=='if op=='eq'else'!=')+'0)'
        binary={'eq':'==','ne':'!=','le':'<=','ge':'>=','and':'&&','or':'||'}
        if op in binary:return '('+a[0]+binary[op]+a[1]+')'
        if op=='not':return '(!'+a[0]+')'
        if op=='implies':return '(!'+a[0]+'||'+a[1]+')'
        if op=='ite':return '('+a[0]+'?'+a[1]+':'+a[2]+')'
        if op=='seq_lt':return '(distance('+','.join(a)+')>0&&distance('+','.join(a)+')<INT64_C(2147483648))'
        if op=='seq_le':return '(distance('+','.join(a)+')<INT64_C(2147483648))'
        if op=='seq_comparable':return '(distance('+','.join(a)+')!=INT64_C(2147483648))'
        return {'add':'add','sub':'sub','mul':'mul','min':'minimum','seq_add':'seqadd','seq_distance':'distance'}[op]+'('+','.join(a)+')'
    def literal(out,s):emit('text('+out+','+cstr(s)+');')
    def value(out,e,kind,event=None):
        if kind=='string':
            # Variables and inputs are scalar; every string expression is a
            # statically selectable source literal. Escape through JSON here.
            if type(e)is not str:raise Unsupported('Dynamic string expression unsupported')
            literal(out,json.dumps(e,ensure_ascii=False))
        elif kind=='bool':emit('text('+out+','+exp(e,event)+'?"true":"false");')
        else:emit('number('+out+','+exp(e,event)+');')
    emit('enum { NV='+str(len(variables))+', NT='+str(len(timers))+' };')
    emit('typedef struct { int state; int64_t now,v[NV?NV:1],due[NT?NT:1]; int active[NT?NT:1]; } Machine;')
    emit('const char *state_names[]={'+','.join(map(cstr,states))+'};')
    emit('const char *event_names[]={'+','.join(map(cstr,events))+'};')
    emit('const char *timer_names[]={'+(','.join(map(cstr,timers))or'""')+'};')
    emit('int event_origin[]={'+','.join('1'if m['events'][e]['origin']=='timer'else'0'for e in events)+'};')
    emit('int event_fields[]={'+','.join(str(len(m['events'][e]['fields']))for e in events)+'};')
    emit('int event_kinds['+str(len(events))+'][FIELD_CAP]={'+','.join('{'+(','.join(str(KINDS[k])for k in m['events'][e]['fields'].values())or'0')+'}'for e in events)+'};')
    emit('int timer_events[]={'+(','.join(str(events.index(m['timers'][t]['event']))for t in timers)or'0')+'};')
    emit('int variable_kinds[]={'+(','.join(str(KINDS[m['variables'][n]['type']])for n in variables)or'0')+'};')
    emit('const char *variable_names[]={'+(','.join(map(cstr,variables))or'""')+'};')
    emit('void initialize(Machine *m) { memset(m,0,sizeof(*m)); m->state='+str(states.index(m['initial_state']))+';')
    for i,n in enumerate(variables):emit('m->v['+str(i)+']='+exp(m['variables'][n]['initial'])+';')
    emit('}')
    emit('int invariants(Machine *m) { (void)m; if(failure)return 0;')
    for inv in m['invariants']:emit('if(!('+exp(inv['assert'])+')) {failure='+cstr('invariant:'+inv['id'])+';return 0;}')
    emit('return failure==NULL; }')
    emit('void snapshot(Buffer *out,Machine *m) { int first=1;')
    literal('out','{"state":');emit('switch(m->state) {')
    for i,s in enumerate(states):emit('case '+str(i)+':');literal('out',json.dumps(s));emit('break;')
    emit('default:failure="invalid_state";}');literal('out',',"variables":{')
    for i,n in enumerate(variables):
        literal('out',(','if i else'')+json.dumps(n)+':');value('out',{'var':n},m['variables'][n]['type'])
    literal('out','},"timers":{')
    for i,n in enumerate(timers):
        emit('if(m->active['+str(i)+']) { if(!first)text(out,",");first=0;');literal('out',json.dumps(n)+':');emit('number(out,m->due['+str(i)+']);}')
    emit('(void)first;');literal('out','}}');emit('}')
    emit('int fire(Machine *m,int event,int64_t *f,int expiring,Buffer *log) { int match=-1,count=0; Buffer messages={{0},0}; int emitted=0; (void)f; (void)emitted;')
    for i,r in enumerate(m['transitions']):emit('if(m->state=='+str(states.index(r['from']))+'&&event=='+str(events.index(r['event']))+'&&('+exp(r['guard'],r['event'])+')) {match='+str(i)+';count++;}')
    emit('if(failure)return 0;\nif(count!=1){failure=count?"rule_conflict":"uncovered_event";return 0;} if(expiring>=0)m->active[expiring]=0; switch(match) {')
    for i,r in enumerate(m['transitions']):
        ev=r['event'];emit('case '+str(i)+': {')
        for a in r['actions']:
            k,p=next(iter(a.items()))
            if k=='set':emit('m->v['+str(variables.index(p['var']))+']='+exp(p['value'],ev)+';')
            elif k in ('emit','emit_if'):
                emit('if('+exp(p['when'],ev)+') {'if k=='emit_if'else'{')
                emit('if(emitted++)text(&messages,",");');literal('&messages','{"message":'+json.dumps(p['message'])+',"fields":{')
                for j,(name,e)in enumerate(p['fields'].items()):
                    literal('&messages',(','if j else'')+json.dumps(name)+':');value('&messages',e,m['messages'][p['message']]['fields'][name],ev)
                literal('&messages','}}');emit('}')
            elif k in ('arm','arm_if'):
                emit('if('+exp(p['when'],ev)+') {'if k=='arm_if'else'{');emit('int64_t delay='+exp(p['delay_ms'],ev)+'; if(delay<=0){failure="invalid_timer_delay";return 0;}')
                ix=str(timers.index(p['timer']));emit('m->due['+ix+']=add(m->now,delay);m->active['+ix+']=1;}')
            elif k in ('cancel','cancel_if'):
                name=p if k=='cancel'else p['timer'];condition='1'if k=='cancel'else exp(p['when'],ev)
                emit('if('+condition+')m->active['+str(timers.index(name))+']=0;')
            emit('if(failure)return 0;')
        emit('m->state='+str(states.index(r['to']))+'; if(!invariants(m))return 0;')
        literal('log','{"status":"transition","transition":'+json.dumps(r['id'])+',"requirements":'+json.dumps(r['requirements'])+',"time_ms":');emit('number(log,m->now);')
        literal('log',',"event":{"name":'+json.dumps(ev)+',"fields":{')
        for j,(name,kind)in enumerate(m['events'][ev]['fields'].items()):
            literal('log',(','if j else'')+json.dumps(name)+':');value('log',{'event':name},kind,ev)
        literal('log','}},"after":');emit('snapshot(log,m);');literal('log',',"emitted":[');emit('text(log,messages.data);');literal('log',']}\n');emit('break; }')
    emit('default:failure="invalid_rule";return 0;} return failure==NULL; }')
    lines.append((HERE/'harness.c').read_text())
    return '\n'.join(lines)+'\n'


def generate(model_file,out):
    model_file=Path(model_file).resolve();out=Path(out).resolve()
    if out.exists():raise ValueError('Fresh output directory required')
    paths=model_files(model_file)+[HERE/'__init__.py',HERE/'__main__.py',HERE/'runtime.c',HERE/'harness.c',Path(__file__).parents[1]/'ir.py',Path(__file__).parents[1]/'symbolic.py']
    inputs={str(p):sha(p)for p in paths}
    m=load(model_file);source=render(m)
    if any(sha(p)!=h for p,h in inputs.items()):raise ValueError('Source changed during generation')
    out.mkdir(parents=True);(out/'protocol.c').write_text(source)
    result=dict(schema='spec-flow-stage-v1',stage='generate',status='pass',backend='direct-c99-scalar-v1',
                model_file=str(model_file),model_semantic_sha256=model_hash(m),inputs=inputs,
                outputs={'protocol.c':sha(out/'protocol.c')},runtime_python_required=False,
                external_protocol_stack_used=False,compiler_correctness_proved=False,
                limits=dict(integer='signed64; checked overflow',command_log_bytes=131072,fields_per_event=64,variables=256,name_bytes=256,timer_steps_per_command=4096),
                unsupported=['byte buffers','rational','clock-v3','post-action target cases','dynamic strings'],
                rules=[dict(id=r['id'],requirements=r['requirements'])for r in m['transitions']],
                scope=m['scope'])
    (out/'generation.json').write_text(json.dumps(result,indent=2)+'\n');return result
