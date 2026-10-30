"""Finite independent lwIP data timers using real virtual-clock advancement."""
import argparse
import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
PORT = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('lwip_timer_stream', ROOT / 'ports/lwip-stream/run.py')
stream = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stream)
stream.MODEL = ROOT / 'model/tcp-limited-transmit.json'
stream.PORT = PORT
stream.SCOPE = ('one active connection; <=16 written octets, <=64 peer text octets, '
                '<=64 events, <=12000ms; sys_check_timeouts every virtual millisecond; '
                'data RTO/partial ACK/backoff/ACK cancellation/idle observations; '
                'no internal timer/cwnd state, real-peer loss, Linux or complete TCP claim')
require = stream.require
original_inputs = stream.inputs


def validate_source_lock(source):
    expected = {'rfc':6298,'url':'https://www.rfc-editor.org/rfc/rfc6298.txt',
                'version':'June 2011','sections':['2','3','4','5'],
                'sha256':stream.digest(ROOT/'spec/sources/rfc6298.txt'),
                'driver_clock':{'step_ms':1,'max_time_ms':12000,'max_events':64},
                'upstream_modified':False}
    require(source == expected,'Timer normative source/clock lock changed')


def inputs():
    validate_source_lock(stream.read(PORT/'sources.json'))
    result = original_inputs()
    path = ROOT / 'ports/lwip-stream/run.py'
    result[str(path.relative_to(ROOT))] = stream.digest(path)
    return result


def validate_plan(s):
    require(type(s)is dict,'Timer scenario must be an object')
    require(set(s)<={'scenario_version','id','description','initial','environment','steps','expect'},'Unsupported stream scenario field')
    require({'scenario_version','id','initial','environment','steps','expect'}<=set(s),'Missing timer scenario field')
    require(type(s['id'])is str and bool(s['id']) and type(s['environment'])is dict,'Invalid timer scenario identity/environment')
    expected=s['expect']
    require(type(expected)is dict and {'state','timers'}<=set(expected) and set(expected)<={'state','variables','timers'},'Missing/unsupported timer expectation contract')
    require(type(expected['state'])is str and type(expected['timers'])is dict and type(expected.get('variables',{}))is dict,'Invalid timer expectation types')
    require(all(type(k)is str and type(v)is int and v>=0 for k,v in expected['timers'].items()),'Invalid expected timer deadline')
    require(s['scenario_version']=='0.1','Unsupported scenario version')
    require('drop_outgoing' in s['environment'] and set(s['environment']) <= {'drop_outgoing','assumptions'},'Unsupported/missing timer environment field')
    require(s['initial']=={} and s['environment']['drop_outgoing']==[],'Unsupported stream initial/loss plan')
    steps=s['steps'];require(type(steps)is list and 3<=len(steps)<=64,'Unsupported stream event count')
    require(steps[0]=={'at_ms':0,'event':'app.connect','fields':{}},'Active connect at zero required')
    previous=-1;written=0;peer_text=0;closed=False;commands=[]
    for i,step in enumerate(steps):
        require(type(step)is dict,'Timer step must be an object')
        t=step.get('at_ms')
        require(type(t)is int and previous<=t<=12000,'Timer clock outside finite monotone scope');previous=t
        if 'tick' in step:
            require(set(step)=={'at_ms','tick'} and step['tick'] is True and i>=2,'Invalid timer clock step')
            commands.append(f'{t} TICK\n')
            continue
        require(set(step)=={'at_ms','event','fields'},'Unsupported timer step field')
        event=step['event'];f=step['fields']
        require(type(event)is str and type(f)is dict,'Invalid timer event fields')
        if i==0:
            command='CONNECT'
        elif i==1:
            require(t==10 and event=='net.synack' and set(f)=={'seq','ack','window'} and f['seq']==9000 and f['ack']==1001,'Canonical handshake input required')
            require(all(type(v)is int for v in f.values()) and 0<=f['window']<=65535,'Invalid SYN window')
            command=f"SYNACK 9000 1001 {f['window']}"
        elif event=='app.close':
            require(f=={} and not closed,'Invalid repeated close');closed=True;command='CLOSE'
        elif event=='app.send':
            require(not closed,'Application write after close unsupported')
            require(set(f)=={'data'} and type(f['data'])is list and 1<=len(f['data'])<=16 and all(type(b)is int and 0<=b<=255 for b in f['data']),'Invalid stream application bytes')
            written+=len(f['data']);require(written<=16,'Stream written-byte scope exceeded')
            command='SEND '+bytes(f['data']).hex()
        elif event=='app.transmit':
            require(f=={} and not closed,'Unsupported transmit after close or fields');command='TRANSMIT'
        elif event in ('net.data','net.fin_segment'):
            require(set(f)=={'seq','ack','window','data'},'Invalid peer text fields')
            require(all(type(f[k])is int for k in ('seq','ack','window')) and 0<=f['seq']<2**32 and 0<=f['ack']<2**32 and 0<=f['window']<=65535,'Invalid peer text header')
            data=f['data'];require(type(data)is list and len(data)<=16 and all(type(b)is int and 0<=b<=255 for b in data),'Invalid peer octets')
            require(bool(data) or event=='net.fin_segment','Empty DATA unsupported')
            peer_text+=len(data);require(peer_text<=64,'Peer text scope exceeded')
            command=('FIN' if event=='net.fin_segment' else 'DATA')+f" {f['seq']} {f['ack']} {f['window']} "+(bytes(data).hex() or '-')
        elif event=='net.ack':
            require(set(f)=={'seq','ack','window'} and all(type(v)is int for v in f.values()),'Invalid ACK fields')
            require(0<=f['seq']<2**32 and 0<=f['ack']<2**32 and 0<=f['window']<=65535,'ACK field outside wire range')
            command=f"ACK {f['seq']} {f['ack']} {f['window']}"
        else:
            require(False,'Unsupported stream event: '+event)
        commands.append(f'{t} {command}\n')
    require(written>0 or peer_text>0 or closed,'At least one application byte, peer byte or close required')
    return ''.join(commands)


def validate_summary(summary, scenario):
    expected={'implementation':'lwIP-2.2.1','clock':'virtual_ms','connected':1,'mss':4,'receive_window':16,
              'written_bytes':sum(len(s['fields']['data'])for s in scenario['steps']if s.get('event')=='app.send'),'commands':len(scenario['steps']),
              'end_ms':scenario['steps'][-1]['at_ms'],'clock_step_ms':1,
              'clock_checks':scenario['steps'][-1]['at_ms']+len(scenario['steps'])}
    require(set(summary)==set(expected)|{'acknowledged_bytes','received_bytes','receiver_events'},'Unexpected execution summary fields')
    require(all(summary[k]==v and type(summary[k])is type(v) for k,v in expected.items()),'Execution summary changed')
    require(type(summary['acknowledged_bytes'])is int and 0<=summary['acknowledged_bytes']<=expected['written_bytes'],'Invalid acknowledged-byte callback')
    require(type(summary['received_bytes'])is int and 0<=summary['received_bytes']<=16 and type(summary['receiver_events'])is list and len(summary['receiver_events'])<=64,'Invalid receiver observation schema')
    previous=-1;count=0
    for event in summary['receiver_events']:
        require(set(event)=={'time_ms','eof','data'} and type(event['time_ms'])is int and previous<=event['time_ms']<=12000 and type(event['eof'])is bool,'Invalid receiver event schema')
        data=event['data'];require(type(data)is list and len(data)<=16 and all(type(b)is int and 0<=b<=255 for b in data),'Invalid receiver byte observation')
        require(not event['eof'] or not data,'EOF observation has data')
        previous=event['time_ms'];count+=len(data)
    require(count==summary['received_bytes'],'Receiver event count changed')

stream.inputs = inputs
stream.validate_plan = validate_plan
stream.validate_summary = validate_summary


def run(out, scenario):
    return stream.run(out, Path(scenario).resolve())


def verify(out, scenario):
    path = Path(scenario).resolve()
    require(path.parent == PORT / 'scenarios' and path.suffix == '.json', 'Scenario must be a bound timer input')
    return stream.verify(out, path)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--scenario', type=Path, default=PORT / 'scenarios/unacknowledged-first-rto.json')
    parser.add_argument('--out', type=Path, default=ROOT / 'artifacts/lwip-timers/unacknowledged-first-rto')
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    result = verify(args.out, args.scenario) if args.verify else run(args.out, args.scenario)
    print(json.dumps(result if args.verify else {k: result[k] for k in ('status', 'comparison', 'summary')}))
    sys.exit(0 if args.verify or result['comparison'] == 'match' else 1)
