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
uv run python scripts/run_sandbox.py                  # runs `opencode --version` by default
uv run python scripts/run_sandbox.py "opencode --help" # pass any shell command as an argument
uv run python scripts/explore_sandbox.py
```

To run any script with secrets loaded (without re-sourcing setup.sh):

```bash
doppler run -- uv run python scripts/run_sandbox.py
```

### Running Tests

```bash
doppler run -- uv run pytest tests/ -v
```

Tests in `tests/test_connectivity.py` verify live access to OpenRouter and E2B — they require secrets to be loaded.

### Required Secrets (managed via Doppler)

| Secret | Used by |
|---|---|
| `OPENROUTER_API_KEY` | OpenRouter API calls in tests and opencode |
| `E2B_API_KEY` | E2B sandbox creation |

### E2B Sandbox Template

The sandbox image is defined in `e2b.Dockerfile` (Ubuntu 22.04 + opencode). Template name: `opencode-ubuntu`.

To rebuild and publish the template after changing `e2b.Dockerfile`:

```bash
doppler run -- e2b template build
```
