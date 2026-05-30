# Claude Instructions

## REQUIRED: Session Startup

IMPORTANT: You MUST run this script as the very first action of every session, before doing anything else:

```bash
bash scripts/start-docker.sh
```

Do not respond to the user's first message until this script has been run.

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
