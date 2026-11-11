"""Bounded default-reachable test stimulus search; not an independent oracle."""
import copy,json
from collections import deque
from protocol_lab.ir import Machine,Uncovered,Conflict,ModelError

def collect(model,seeds,targets,limits):
 limits={k:limits.get(k,v)for k,v in dict(max_attempts=400,max_prefixes=128,max_steps=20,max_cases=40).items()}
 if any(type(v)is not int or v<=0 for v in limits.values()):raise ValueError('positive integer limits required')
 ids={t['id']for t in targets}
 if len(ids)!=len(targets):raise ValueError('duplicate targets')
 for t in targets:
  if t.get('fields')or model['events'][t['event']]['fields']or model['events'][t['event']]['origin']=='timer':raise ValueError('only fieldless external targets')
 events=sorted({t['event']for t in targets});root=Machine(model)
 def clone(m):return copy.deepcopy(m,{id(m.model):root.model})
 def key(path):return json.dumps(path,sort_keys=True,separators=(',',':'))
 cache={key([]):(clone(root),[])};queue=deque([key([])]);attempted=set();cases=[];covered=set();gaps=[];failures=[];attempts=0;cutoff=False
 def accept(m,path):
  nonlocal cutoff
  found=ids.intersection(r['transition']for r in m.trace)-covered
  if not found:return
  if len(cases)>=limits['max_cases']:cutoff=True;return
  cases.append(dict(target_rules=sorted(found),scenario=dict(scenario_version='0.1',id='directed-'+str(len(cases)+1).zfill(3),initial={},steps=copy.deepcopy(path),expect=copy.deepcopy(m.snapshot())),origin='model_generated',initial_override=False));covered.update(found)
 def edge(m,path,step):
  nonlocal attempts,cutoff
  new=path+[step];k=key(new)
  if k in cache:return cache[k][0]
  if k in attempted:return None
  if len(new)>limits['max_steps']:return None
  if attempts>=limits['max_attempts']or len(cache)>=limits['max_prefixes']or len(cases)>=limits['max_cases']:cutoff=True;return None
  attempted.add(k);attempts+=1;b=clone(m)
  try:
   if step.get('tick'):b.tick(step['at_ms'])
   else:b.dispatch(step['event'],copy.deepcopy(step.get('fields',{})),step['at_ms'])
  except Uncovered as e:gaps.append(dict(path=copy.deepcopy(new),classification='model_gap',error=str(e)));return None
  except (Conflict,ModelError)as e:failures.append(dict(path=copy.deepcopy(new),classification=type(e).__name__,error=str(e)));return None
  b=clone(b);cache[k]=(b,copy.deepcopy(new));queue.append(k);accept(b,new);return b
 def add_path(path):
  m=root;prefix=[]
  for s in path:
   if cutoff or failures:return
   m=edge(m,prefix,s)
   if m is None:return
   prefix=prefix+[s]
 for seed in seeds:
  if seed.get('initial',{}):continue
  original=copy.deepcopy(seed['steps']);add_path(original)
  resolve=[i for i,s in enumerate(original)if s.get('event')=='L.app.resolve']
  arp=[i for i,s in enumerate(original)if s.get('event')=='L.net.frame'and len(s.get('fields',{}).get('frame',[]))>=22 and s['fields']['frame'][12:14]==[8,6]and s['fields']['frame'][20:22]==[0,2]]
  for omitted in [set(resolve),set(arp),set(resolve+arp)]:
   if omitted:add_path([s for i,s in enumerate(original)if i not in omitted])
  if cutoff or failures:break
 while queue and not cutoff and not failures and covered!=ids:
  m,path=cache[queue.popleft()]
  if len(path)>=limits['max_steps']:continue
  stimuli=[dict(at_ms=m.now_ms,event=e,fields={})for e in events]
  if m.timers:stimuli.append(dict(at_ms=min(m.timers.values()),tick=True))
  for s in stimuli:
   edge(m,path,s)
   if cutoff or failures:break
 return dict(schema='model-derived-directed-cases-v1',cases=cases,attempts=attempts,prefixes=len(cache),unreached_targets=sorted(ids-covered),failures=failures,rejections=gaps,cutoff=cutoff,scope='bounded default-initial reference-derived input candidates; no C/Z3 acceptance, independent RFC oracle, reachability completeness or proof')
