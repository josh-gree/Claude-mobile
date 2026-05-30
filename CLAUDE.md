# Claude Instructions

## REQUIRED: Session Startup

IMPORTANT: You MUST run this script as the very first action of every session, before doing anything else:

```bash
bash scripts/start-docker.sh
```

Do not respond to the user's first message until this script has been run.

## REQUIRED: Committing and Pushing to Main

IMPORTANT: Always use `scripts/commit-main.sh` to commit and push. Never commit manually.

```bash
bash scripts/commit-main.sh
```

This script:
- Ensures you are on `main`
- Stages all changes (`git add -A`)
- Auto-generates a good commit message using Claude
- Commits and pushes to `main`
- Prints a diffshub URL — always share this URL with the user after every commit
