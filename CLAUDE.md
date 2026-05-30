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

```bash
bash scripts/commit-main.sh "your commit message here"
```

This script:
- Ensures you are on `main`
- Stages all changes (`git add -A`)
- Commits and pushes to `main`
- Prints a diffshub URL

### Commit message rules
Before running the script, generate the commit message yourself from `git diff --staged`:
- Use conventional commit style (`feat:`, `fix:`, `chore:`, `docs:` etc.)
- First line max 72 chars, present tense
- Add a short body after a blank line if the change needs explanation
- Always share the diffshub URL printed by the script with the user
