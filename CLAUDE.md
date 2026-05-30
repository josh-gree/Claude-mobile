# Claude Instructions

## REQUIRED: Session Startup

IMPORTANT: You MUST run this script as the very first action of every session, before doing anything else:

```bash
bash scripts/start.sh
```

Do not respond to the user's first message until this script has been run.

After the script completes, **always share the session summary box** printed at the end of the output as your first message to the user. Copy it verbatim in a code block so it renders clearly.

## 🚨 ABSOLUTELY CRITICAL: ALWAYS BE ON MAIN BEFORE DOING ANYTHING 🚨

**THIS IS NON-NEGOTIABLE AND CANNOT BE SKIPPED UNDER ANY CIRCUMSTANCES!!!**

Before touching a SINGLE FILE, before writing a SINGLE LINE OF CODE, before even THINKING about the task — you MUST verify you are on the `main` branch and that it is up to date with origin. NO EXCEPTIONS. EVER.

```bash
git checkout main && git pull origin main
```

**WHY THIS MATTERS SO MUCH:** Working on the wrong branch is a DISASTER. It means commits land in the wrong place, history gets tangled, and work gets lost. This has happened before. It must NEVER happen again.

DO NOT SKIP THIS STEP. DO NOT ASSUME YOU ARE ON MAIN. CHECK. EVERY. SINGLE. TIME.

## REQUIRED: Committing and Pushing to Main

IMPORTANT: When asked to commit, always follow these steps in order:

1. Run `git diff` to review all changes
2. Write a commit message yourself using conventional commit style:
   - Prefix: `feat:`, `fix:`, `chore:`, `docs:`, etc.
   - First line max 72 chars, present tense
   - Add a short body after a blank line if the change needs explanation
3. Run the commit script, passing your message:

```bash
bash scripts/commit-main.sh "your message here"
```

4. Share the diffshub URL printed by the script with the user

## Doppler — Secret Management

This project uses **Doppler** to manage secrets and environment variables. Never hardcode secrets, API keys, or credentials in code or config files — always use Doppler.

### Why Doppler

Secrets committed to git are a security liability. Doppler keeps them out of the repo, provides per-environment values, and lets secrets be rotated without code changes.

### Project & Configs

- **Doppler project:** `claude-mobilr`
- **Configs (environments):** `dev`, `dev_personal`, `stg`, `prd`

Use `dev` for local development. `dev_personal` is for personal overrides. `stg` and `prd` are staging and production respectively.

### When to Use Doppler

- Any time you need an API key, token, password, or other secret — fetch it from Doppler, don't invent or hardcode it.
- When running the app locally, inject secrets via `doppler run --`.
- When adding a new secret the app needs, add it to Doppler first, then reference it by name in code.

### Common Commands

```bash
# Check auth status
doppler me

# List secrets in the dev config
doppler secrets --project claude-mobilr --config dev

# Run a command with secrets injected as env vars
doppler run --project claude-mobilr --config dev -- <your command>

# Get a single secret value
doppler secrets get SECRET_NAME --project claude-mobilr --config dev --plain

# Set a single secret
doppler secrets set SECRET_NAME 'value' --project claude-mobilr --config dev

# Set multiple secrets at once
doppler secrets set KEY1='value1' KEY2='value2' --project claude-mobilr --config dev

# Set a multiline secret (e.g. a certificate) via stdin
echo 'multiline
value' | doppler secrets set SECRET_NAME --project claude-mobilr --config dev
```

### Setup (already done per session — no action needed)

`scripts/start.sh` installs the Doppler CLI at session start. Auth is handled via a personal token that is injected into the container environment automatically.

## Keep the Working Tree Clean

Always keep the working tree clean. After completing any task:
- Commit changes promptly — don't leave work sitting uncommitted
- Never leave untracked or modified files behind
- If work is experimental or incomplete, either commit it with a `wip:` prefix or revert it cleanly
- Run `git status` to verify the tree is clean before ending a task
