import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

script = Path(__file__).with_name('codex_wiki_hook.py')
if not script.exists():
    script = Path(__file__).parents[1] / 'scripts/codex_wiki_hook.py'
spec = importlib.util.spec_from_file_location('wiki_hook', script)
hook = importlib.util.module_from_spec(spec)
spec.loader.exec_module(hook)


class HookTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name).resolve()
        self.vault = self.root / 'vault'
        (self.vault / 'wiki/concepts').mkdir(parents=True)
        (self.vault / 'meta').mkdir()
        self.page = self.vault / 'wiki/concepts/ansible'
        self.page.with_suffix('.md').write_text('Evidence')
        (self.vault / 'config.json').write_text('{}')
        self.registry = self.vault / 'meta/registry.json'
        self.registry.write_text(json.dumps({'pages': {
            'concepts/ansible': {'title': 'Ansible production operations', 'tags': ['devops']},
            '../../escape': {'title': 'Ansible escape'},
            'concepts/missing': {'title': 'Ansible missing'},
        }}))

    def test_recall_only_existing_contained_pages(self):
        result = hook.candidates(self.vault, 'help with ansible production')
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]['path'], str(self.page.with_suffix('.md')))

    def test_does_not_recall_unrelated_prompt(self):
        self.assertEqual(hook.candidates(self.vault, 'translate hello to German'), [])

    def test_corrupt_registry_is_nonblocking(self):
        self.registry.write_text('{')
        self.assertEqual(hook.candidates(self.vault, 'ansible'), [])
        self.assertIn('wiki_recall', hook.context({'hook_event_name': 'UserPromptSubmit', 'prompt': 'ansible'}, self.vault))

    def test_session_start_has_guide_and_retention_boundary(self):
        message = hook.context({'hook_event_name': 'SessionStart'}, self.vault)
        self.assertIn('SKILL.md', message)
        self.assertIn('retention instructions', message)

    def test_event_gating(self):
        self.assertIsNone(hook.context({'hook_event_name': 'Stop'}, self.vault))
        self.assertIsNone(hook.context({'hook_event_name': 'UserPromptSubmit', 'prompt': ''}, self.vault))

    def test_config_resolution_and_disabled_server(self):
        config = self.root / 'config.toml'
        (self.root / '.llm-wiki').symlink_to(self.vault)
        config.write_text('[mcp_servers.llm-wiki.env]\nWIKI_ROOT = ' + json.dumps(str(self.root)))
        self.assertEqual(hook.wiki_vault(self.root, self.root), self.vault)
        config.write_text('[mcp_servers.llm-wiki]\nenabled = false\n[mcp_servers.llm-wiki.env]\nWIKI_ROOT = ' + json.dumps(str(self.root)))
        self.assertIsNone(hook.wiki_vault(self.root, self.root))

    def test_read_only(self):
        before = {str(p): p.read_bytes() for p in self.vault.rglob('*') if p.is_file()}
        hook.context({'hook_event_name': 'UserPromptSubmit', 'prompt': 'ansible'}, self.vault)
        after = {str(p): p.read_bytes() for p in self.vault.rglob('*') if p.is_file()}
        self.assertEqual(before, after)


if __name__ == '__main__':
    unittest.main()
