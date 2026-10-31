"""Explicitly scoped IPv4/TCP codec binding; EFSM decisions remain in Protocol IR."""
import ipaddress
from . import HERE,Unsupported


def render_codec(model,binding):
    if set(binding)!={'schema','local','peer','input_event','message','ttl','scope'}or binding['schema']!='native-ipv4-tcp-binding-v1':
        raise Unsupported('Unknown wire binding schema/fields')
    event=binding['input_event'];message=binding['message']
    if event not in model['events']or model['events'][event]!={'origin':'network','fields':{'seq':'seq32','ack':'seq32'}}:
        raise Unsupported('Wire input needs a network event with seq32 seq/ack only')
    if message not in model['messages']or model['messages'][message]!={'fields':{'flags':'string','seq':'seq32','ack':'seq32','window':'int'}}:
        raise Unsupported('Wire output needs flags/seq/ack/window message fields')
    if type(binding['ttl'])is not int or not 1<=binding['ttl']<=255 or type(binding['scope'])is not str or not binding['scope']:
        raise Unsupported('Explicit TTL and scope required')
    arrays=[]
    for key in ('local','peer'):
        endpoint=binding[key]
        if set(endpoint)!={'ip','port'}or type(endpoint['port'])is not int or not 1<=endpoint['port']<=65535:
            raise Unsupported('Invalid wire endpoint')
        try:octets=ipaddress.IPv4Address(endpoint['ip']).packed
        except (ValueError,TypeError):raise Unsupported('IPv4 endpoint required')
        arrays.append('static const unsigned char wire_'+key+'[4]={'+','.join(map(str,octets))+'};')
        arrays.append('#define WIRE_'+key.upper()+'_PORT '+str(endpoint['port']))
    fields=list(model['events'][event]['fields'])
    header='\n'.join(['#define WIRE_PROFILE 1','#define WIRE_EVENT '+str(list(model['events']).index(event)),
                       '#define WIRE_SEQ_FIELD '+str(fields.index('seq')),'#define WIRE_ACK_FIELD '+str(fields.index('ack')),
                       '#define WIRE_TTL '+str(binding['ttl']),*arrays])
    return header+'\n'+(HERE/'wire.c').read_text()
