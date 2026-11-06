import hashlib
import io
import json
from pathlib import Path
import tarfile
import tempfile
import unittest
from unittest.mock import patch
from deploy.package import build
from deploy.unpack import unpack
from agents.deepseek_gateway import request


class ServerReleaseTests(unittest.TestCase):
    def test_real_git_release_includes_all_acceptance_task_closure(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);report=build(root/'bundle');archive=root/'bundle/spec-flow-server.tar.gz'
            r=unpack(archive,report['archive_sha256'],root/'release')
            manifest=json.loads((root/'release/release.json').read_text())
            self.assertEqual(len(manifest['tasks']),3)
            self.assertTrue((root/'release/tools/flows/tcp-active-open.json').exists())
            self.assertFalse((root/'release/tools/.venv').exists())
            self.assertFalse(any('artifacts/'in p or '.env'in p for p in manifest['files']))
            self.assertEqual(r['files'],report['source_files'])

    def test_changed_archive_is_rejected_before_output_creation(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);p=root/'archive';p.write_bytes(b'not the approved release')
            with self.assertRaisesRegex(ValueError,'approved digest'):unpack(p,'0'*64,root/'out')
            self.assertFalse((root/'out').exists())

    def test_archive_traversal_and_symlink_are_rejected(self):
        for name,kind in (('../escape',tarfile.REGTYPE),('tools/link',tarfile.SYMTYPE)):
            with self.subTest(name=name),tempfile.TemporaryDirectory()as tmp:
                root=Path(tmp);p=root/'bad.tar.gz'
                with tarfile.open(p,'w:gz')as tar:
                    info=tarfile.TarInfo(name);info.type=kind
                    if kind==tarfile.SYMTYPE:info.linkname='/etc/passwd';tar.addfile(info)
                    else:info.size=1;tar.addfile(info,io.BytesIO(b'x'))
                with self.assertRaisesRegex(ValueError,'Unsafe'):unpack(p,hashlib.sha256(p.read_bytes()).hexdigest(),root/'out')
                self.assertFalse((root/'out').exists())


class BoundedGatewayTests(unittest.TestCase):
    def messages(self,text='Return JSON'):
        return [{'role':'user','content':text}]

    def test_reasoning_configuration_is_sent_and_bound_to_cache_and_same_ledger(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);key=root/'key';key.write_text('fake-local-reasoning-key');key.chmod(0o600)
            data={'usage':{'total_tokens':9},'choices':[{'finish_reason':'stop','message':{'content':'{"ready":true}'}}]}
            with patch('agents.deepseek_gateway.urllib.request.build_opener')as make:
                make.return_value.open.side_effect=lambda *a,**kw:io.BytesIO(json.dumps(data).encode())
                old=request(self.messages(),root/'ledger',key,max_tokens=32,max_calls=64)
                new=request(self.messages(),root/'ledger',key,max_tokens=8192,max_calls=64,thinking='enabled',reasoning_effort='high')
                cached=request(self.messages(),root/'ledger',key,max_tokens=8192,max_calls=64,thinking='enabled',reasoning_effort='high')
                self.assertNotEqual(old['request_sha256'],new['request_sha256']);self.assertTrue(cached['cached'])
                payload=json.loads(make.return_value.open.call_args_list[-1].args[0].data)
                self.assertEqual(payload['thinking'],{'type':'enabled'});self.assertEqual(payload['reasoning_effort'],'high')
                self.assertEqual(payload['max_tokens'],8192);self.assertEqual(make.return_value.open.call_count,2)
                ledger=json.loads((root/'ledger/ledger.json').read_text());self.assertEqual(len(ledger),2)
                self.assertIn(old['request_sha256'],ledger)

    def test_invalid_reasoning_does_not_create_ledger_or_send_request(self):
        with tempfile.TemporaryDirectory()as tmp,patch('agents.deepseek_gateway.urllib.request.build_opener')as make:
            target=Path(tmp)/'ledger'
            with self.assertRaises(ValueError):request(self.messages(),target,'unused',thinking='disabled',reasoning_effort='high')
            self.assertFalse(target.exists());make.assert_not_called()

    def test_success_is_cached_and_global_count_budget_prevents_new_request(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);key=root/'key';key.write_text('fake-local-test-credential');key.chmod(0o600)
            data={'model':'test-model','id':'fake','usage':{'total_tokens':9},'choices':[{'finish_reason':'stop','message':{'content':'{"ready":true}'}}]}
            with patch('agents.deepseek_gateway.urllib.request.build_opener')as make:
                make.return_value.open.return_value=io.BytesIO(json.dumps(data).encode())
                a=request(self.messages(),root/'out',key,max_tokens=32,max_calls=1)
                b=request(self.messages(),root/'out',key,max_tokens=32,max_calls=1)
                self.assertFalse(a['cached']);self.assertTrue(b['cached']);self.assertEqual(make.return_value.open.call_count,1)
                with self.assertRaisesRegex(ValueError,'budget exhausted'):request(self.messages('another request'),root/'out',key,max_tokens=32,max_calls=1)
            self.assertNotIn(key.read_text(),(root/'out/ledger.json').read_text())

    def test_uncertain_request_is_not_automatically_retried_or_logged_with_secret(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);key=root/'key';key.write_text('fake-sensitive-value');key.chmod(0o600)
            with patch('agents.deepseek_gateway.urllib.request.build_opener')as make:
                make.return_value.open.side_effect=TimeoutError(key.read_text())
                with self.assertRaisesRegex(ValueError,'did not complete'):request(self.messages(),root/'out',key,max_tokens=32)
                with self.assertRaisesRegex(ValueError,'no automatic paid retry'):request(self.messages(),root/'out',key,max_tokens=32)
                self.assertEqual(make.return_value.open.call_count,1)
            text=(root/'out/ledger.json').read_text();self.assertNotIn(key.read_text(),text)
            self.assertIsNone(next(iter(json.loads(text).values()))['usage'])

    def test_provider_echo_of_credential_is_never_retained(self):
        with tempfile.TemporaryDirectory()as tmp:
            root=Path(tmp);key=root/'key';key.write_text('fake-secret-for-echo');key.chmod(0o600)
            with patch('agents.deepseek_gateway.urllib.request.build_opener')as make:
                make.return_value.open.return_value=io.BytesIO(json.dumps({'echo':key.read_text()}).encode())
                with self.assertRaisesRegex(ValueError,'did not complete'):request(self.messages(),root/'out',key,max_tokens=32)
            self.assertEqual([p.name for p in (root/'out').glob('*.json')],['ledger.json'])
            self.assertNotIn(key.read_text(),(root/'out/ledger.json').read_text())


if __name__=='__main__':unittest.main()
