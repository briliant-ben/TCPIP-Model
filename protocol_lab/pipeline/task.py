import hashlib
import json
from pathlib import Path
import re

TOOL=Path(__file__).resolve().parents[1]
SCHEMA='spec-flow-task-v1'


def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def read(p):return json.loads(Path(p).read_text())
def write(p,v):Path(p).write_text(json.dumps(v,indent=2,ensure_ascii=False)+'\n')


def resolve(workspace,name):
    if not isinstance(name,str):raise ValueError('Input path must be a string')
    path=(Path(workspace)/name).resolve()
    if not path.is_relative_to(Path(workspace).resolve()):raise ValueError('Input path escapes workspace')
    if not path.is_file():raise ValueError('Input file unavailable: '+name)
    return path


def load_task(filename,workspace):
    workspace=Path(workspace).resolve();filename=Path(filename).resolve()
    if not filename.is_relative_to(workspace):raise ValueError('Task outside workspace')
    t=read(filename)
    keys={'schema','id','model','sources','requirement_bindings','exploration','seeds','formal','limits','scope'}
    if set(t)!=keys or t['schema']!=SCHEMA:raise ValueError('Unknown task fields/version')
    if not isinstance(t['id'],str)or not re.fullmatch(r'[A-Za-z0-9_.-]+',t['id']):raise ValueError('Invalid task ID')
    resolve(workspace,t['model']);resolve(workspace,t['exploration'])
    if not isinstance(t['seeds'],list):raise ValueError('Seeds must be a list')
    for name in t['seeds']:resolve(workspace,name)
    if not isinstance(t['sources'],list)or not t['sources']:raise ValueError('Pinned sources required')
    ids=[]
    for s in t['sources']:
        if set(s)!={'id','path','sha256','version','uri_aliases'}or not isinstance(s['version'],str)or not s['version']:raise ValueError('Incomplete source declaration')
        if not isinstance(s['id'],str)or not re.fullmatch(r'[A-Za-z0-9_.-]+',s['id']):raise ValueError('Invalid source ID')
        resolve(workspace,s['path']);ids.append(s['id'])
        if not re.fullmatch('[0-9a-f]{64}',s['sha256']):raise ValueError('Invalid source digest')
        if not isinstance(s['uri_aliases'],list)or not s['uri_aliases']or any(not isinstance(u,str)or not u for u in s['uri_aliases']):raise ValueError('Source URI aliases required')
    if len(ids)!=len(set(ids)):raise ValueError('Duplicate source ID')
    if not isinstance(t['requirement_bindings'],dict):raise ValueError('Requirement bindings required')
    for b in t['requirement_bindings'].values():
        if set(b)!={'source','clause','reference'}or b['source']not in ids or any(not isinstance(b[k],str)or not b[k]for k in b):raise ValueError('Incomplete requirement binding')
    f=t['formal'];limits=t['limits']
    if set(f)!={'depth','symbolic_initials'}or type(f['depth'])is not int or not 1<=f['depth']<=30 or not isinstance(f['symbolic_initials'],list):raise ValueError('Unsupported formal configuration')
    if set(limits)!={'stage_seconds','max_prefixes','max_cases'}or any(type(n)is not int for n in limits.values()):raise ValueError('Invalid resource limits')
    if not 1<=limits['stage_seconds']<=600 or not 1<=limits['max_prefixes']<=10000 or not 1<=limits['max_cases']<=1000:raise ValueError('Resource budget outside admitted range')
    if not isinstance(t['scope'],dict)or set(t['scope'])!={'purpose','assumptions','excluded'}:raise ValueError('Explicit task scope required')
    return t


def inputs(filename,workspace,t):
    from ..ir import model_files
    workspace=Path(workspace).resolve()
    paths=[Path(filename).resolve(),resolve(workspace,t['exploration'])]
    paths+=model_files(resolve(workspace,t['model']))
    paths+=[resolve(workspace,s['path'])for s in t['sources']]
    paths+=[resolve(workspace,s)for s in t['seeds']]
    if any(not p.is_relative_to(workspace)for p in paths):raise ValueError('Resolved model chain escapes workspace')
    result={'workspace/'+p.relative_to(workspace).as_posix():sha(p)for p in paths}
    for p in sorted(TOOL.rglob('*')):
        if p.is_file()and p.suffix in ('.py','.c'):result['tool/'+p.relative_to(TOOL).as_posix()]=sha(p)
    return result


def check_inputs(snapshot,workspace):
    expected={n for n in snapshot if n.startswith('tool/')}
    actual={'tool/'+p.relative_to(TOOL).as_posix()for p in TOOL.rglob('*')if p.is_file()and p.suffix in ('.py','.c')}
    if expected!=actual:raise ValueError('Tool source file set changed')
    for name,h in snapshot.items():
        prefix,tail=name.split('/',1);root=Path(workspace).resolve()if prefix=='workspace'else TOOL if prefix=='tool'else None
        if root is None:raise ValueError('Unknown input namespace')
        path=(root/tail).resolve()
        if not path.is_relative_to(root)or sha(path)!=h:raise ValueError('Source input changed: '+name)
