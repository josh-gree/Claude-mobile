"""Integration tests verifying API access to OpenRouter and E2B."""

import json
import os
import urllib.request

import pytest
from e2b import Sandbox


def test_openrouter_access():
    api_key = os.environ["OPENROUTER_API_KEY"]
    req = urllib.request.Request(
        "https://openrouter.ai/api/v1/models",
        headers={"Authorization": f"Bearer {api_key}"},
    )
    with urllib.request.urlopen(req, timeout=10) as response:
        assert response.status == 200
        data = json.loads(response.read())
    assert "data" in data
    assert len(data["data"]) > 0


def test_e2b_access():
    with Sandbox.create("opencode-ubuntu") as sandbox:
        result = sandbox.commands.run("echo hello")
    assert result.exit_code == 0
    assert "hello" in result.stdout
