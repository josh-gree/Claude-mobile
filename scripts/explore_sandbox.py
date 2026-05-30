#!/usr/bin/env python3
"""Use E2B + opencode to explore the sandbox environment and write a markdown report."""

import os
import re
import shlex
import sys
from e2b import Sandbox
from e2b.exceptions import FileNotFoundException

TEMPLATE = "opencode-ubuntu"
MODEL = "openrouter/deepseek/deepseek-v4-flash"
REPORT_PATH = "/home/user/environment-report.md"

ANSI_ESCAPE = re.compile(r"\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])")


def strip_ansi(text: str) -> str:
    return ANSI_ESCAPE.sub("", text)


GATHER_CMD = r"""
echo "=== OS ===" && uname -a
echo "=== CPU ===" && nproc && lscpu | grep -E "Model name|^CPU\(s\)"
echo "=== MEMORY ===" && free -h
echo "=== DISK ===" && df -h /
echo "=== LANGUAGES ===" && python3 --version 2>&1; node --version 2>&1 || true; go version 2>&1 || true; rustc --version 2>&1 || true
echo "=== TOOLS ===" && for t in git curl jq ssh docker make gcc; do printf "$t: "; which $t 2>/dev/null || echo "not found"; done
echo "=== NETWORK ===" && curl -s -o /dev/null -w "HTTP %{http_code} to google.com\n" https://www.google.com 2>/dev/null || echo "no access"
""".strip()


def main() -> None:
    envs = {}
    if key := os.environ.get("OPENROUTER_API_KEY"):
        envs["OPENROUTER_API_KEY"] = key

    print(f"Creating sandbox from template: {TEMPLATE}")
    with Sandbox.create(TEMPLATE, envs=envs or None) as sandbox:
        print(f"Sandbox ID: {sandbox.sandbox_id}\n")

        # Gather environment data directly
        print("Gathering environment data...")
        data = sandbox.commands.run(GATHER_CMD).stdout
        print(data)

        # Ask opencode to format it as a markdown report and write the file
        prompt = (
            f"Format the following environment data as a clean markdown report "
            f"and save it to {REPORT_PATH}. Do not run any commands — just write the file.\n\n"
            f"```\n{data}\n```"
        )

        print("\nAsking opencode to write the report...")
        result = sandbox.commands.run(
            f'opencode run --model {MODEL} {shlex.quote(prompt)}',
            timeout=120,
            on_stdout=lambda x: print(strip_ansi(x), end="", flush=True),
            on_stderr=lambda x: print(strip_ansi(x), end="", file=sys.stderr, flush=True),
        )

        print("\n\n--- Report ---\n")
        try:
            print(sandbox.files.read(REPORT_PATH))
        except FileNotFoundException:
            print("Report file not written.")
            if result.exit_code != 0:
                sys.exit(result.exit_code)


if __name__ == "__main__":
    main()
