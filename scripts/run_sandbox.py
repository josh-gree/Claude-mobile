#!/usr/bin/env python3
"""Spin up an opencode-ubuntu E2B sandbox and run a command."""

import os
import sys
from e2b import Sandbox

TEMPLATE = "opencode-ubuntu"


def main(command: str = "opencode --version") -> None:
    envs = {}
    if key := os.environ.get("OPENROUTER_API_KEY"):
        envs["OPENROUTER_API_KEY"] = key

    print(f"Creating sandbox from template: {TEMPLATE}")
    with Sandbox.create(TEMPLATE, envs=envs or None) as sandbox:
        print(f"Sandbox ID: {sandbox.sandbox_id}")
        result = sandbox.commands.run(
            command,
            timeout=300,
            on_stdout=lambda x: print(x, end="", flush=True),
            on_stderr=lambda x: print(x, end="", file=sys.stderr, flush=True),
        )
        if result.stdout:
            print(result.stdout, end="")
        if result.stderr:
            print(result.stderr, end="", file=sys.stderr)
        if result.exit_code != 0:
            sys.exit(result.exit_code)


if __name__ == "__main__":
    cmd = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "opencode --version"
    main(cmd)
