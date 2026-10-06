#!/usr/bin/env python3
"""Focused unit tests for Anvil-on-Beads helpers.

These tests exercise deterministic parsing/gating helpers without requiring a
real Beads database.
"""

from __future__ import annotations

import importlib.machinery
import importlib.util
from pathlib import Path
import unittest


HERE = Path(__file__).resolve().parent
SCRIPTS = HERE.parent / "scripts"


def load_script(name: str):
    path = SCRIPTS / name
    loader = importlib.machinery.SourceFileLoader(name.replace("-", "_"), str(path))
    spec = importlib.util.spec_from_loader(loader.name, loader)
    module = importlib.util.module_from_spec(spec)
    loader.exec_module(module)
    return module


check = load_script("anvil-check")
bundle = load_script("anvil-bundle")


class CheckHelpersTests(unittest.TestCase):
    def test_bounded_preserves_head_and_tail(self):
        value = "a" * 100 + "END"
        result = check.bounded(value, 60)
        self.assertLessEqual(len(result), 60)
        self.assertTrue(result.startswith("a"))
        self.assertTrue(result.endswith("END"))
        self.assertIn("truncated", result)

    def test_json_parser_tolerates_warning_prefix(self):
        payload = check.parse_json_output('warning: sandbox\n[{"id":"bd-1"}]')
        self.assertEqual(check.first_issue_id(payload), "bd-1")

    def test_redaction(self):
        self.assertEqual(check.redact("token=secret", [r"secret"]), "token=[REDACTED]")


class BundleHelpersTests(unittest.TestCase):
    def evidence(self, name: str, attempt: int, passed: bool, *, status: str = "closed"):
        return {
            "id": f"bd-{name}-{attempt}",
            "title": name,
            "status": status,
            "metadata": {
                "anvil_schema": "anvil-beads/v1",
                "anvil_kind": "evidence",
                "anvil_root": "bd-root",
                "anvil_phase": "after",
                "anvil_check": name,
                "anvil_attempt": str(attempt),
                "anvil_passed": "true" if passed else "false",
            },
        }

    def test_latest_attempt_wins(self):
        latest = bundle.latest_by_check(
            [self.evidence("pytest", 1, False), self.evidence("pytest", 2, True)]
        )
        self.assertEqual(bundle.attempt(latest["pytest"]), 2)
        self.assertTrue(bundle.truthy(bundle.metadata(latest["pytest"])["anvil_passed"]))

    def test_gate_discovery_prefers_metadata(self):
        gate = {
            "id": "bd-gate",
            "title": "Whatever",
            "status": "open",
            "metadata": {
                "anvil_root": "bd-root",
                "anvil_kind": "gate",
                "anvil_stage": "evidence-gate",
            },
        }
        self.assertEqual(bundle.find_gate([gate], "bd-root", None)["id"], "bd-gate")

    def test_status_closed(self):
        self.assertTrue(bundle.status_closed({"status": "closed"}))
        self.assertFalse(bundle.status_closed({"status": "open"}))


if __name__ == "__main__":
    unittest.main()
