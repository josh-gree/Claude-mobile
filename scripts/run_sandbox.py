#!/usr/bin/env python3
"""Spin up an opencode-ubuntu E2B sandbox and run a command."""

import sys
from e2b import Sandbox

TEMPLATE = "opencode-ubuntu"


def main(command: str = "opencode --version") -> None:
    print(f"Creating sandbox from template: {TEMPLATE}")
    with Sandbox.create(TEMPLATE) as sandbox:
        print(f"Sandbox ID: {sandbox.sandbox_id}")
        result = sandbox.commands.run(command)
        if result.stdout:
            print(result.stdout, end="")
        if result.stderr:
            print(result.stderr, end="", file=sys.stderr)
        if result.exit_code != 0:
            sys.exit(result.exit_code)


if __name__ == "__main__":
    cmd = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "opencode --version"
    main(cmd)
