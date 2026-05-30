# Claude Instructions

## REQUIRED: Session Startup

IMPORTANT: You MUST run this script as the very first action of every session, before doing anything else:

```bash
bash scripts/start.sh
```

Do not respond to the user's first message until this script has been run.

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

## Keep the Working Tree Clean

Always keep the working tree clean. After completing any task:
- Commit changes promptly — don't leave work sitting uncommitted
- Never leave untracked or modified files behind
- If work is experimental or incomplete, either commit it with a `wip:` prefix or revert it cleanly
- Run `git status` to verify the tree is clean before ending a task
