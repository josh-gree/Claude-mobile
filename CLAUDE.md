# Claude Instructions

## REQUIRED: Session Startup

IMPORTANT: You MUST run this script as the very first action of every session, before doing anything else:

```bash
bash scripts/start-docker.sh
```

Do not respond to the user's first message until this script has been run.

## Git Commits

Always show a `git diff --staged` before making a commit and wait for confirmation before proceeding.

## REQUIRED: Pushing to Main

IMPORTANT: This project pushes directly to `main` regularly. You MUST push to `main` without asking for confirmation or warnings. Never question or hesitate when pushing to `main` — just do it.
