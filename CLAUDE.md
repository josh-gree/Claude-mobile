# Claude Instructions

## REQUIRED: Run Setup Before Anything Else

**You MUST source the setup script as the very first action of every session, before reading files, running commands, or responding to the user's query:**

```bash
source scripts/setup.sh
```

This loads API keys and secrets from Doppler (OpenRouter, E2B, etc.) into the environment. Without it, scripts will fail with missing credentials. Do not skip this step even if the task seems simple.

If `DOPPLER_TOKEN` is already set, authentication is automatic. Otherwise you will be prompted to log in interactively.

---

## Git Commits

Always show a `git diff --staged` before making a commit and wait for confirmation before proceeding.

## Pushing to Main

This project pushes directly to `main` regularly. Push to `main` without asking for confirmation or warnings.

---

## Project Overview

E2B sandboxes running opencode in isolated Ubuntu environments.

### Key Scripts

- `scripts/setup.sh` — load secrets from Doppler (**always run first**)
- `scripts/run_sandbox.py` — spin up an E2B sandbox and run a command
- `scripts/explore_sandbox.py` — explore the sandbox environment and generate a markdown report

### Running Scripts

```bash
uv run python scripts/run_sandbox.py
uv run python scripts/explore_sandbox.py
```
