# Claude Instructions

## Session Startup

At the start of every session, run the Docker startup script:

```bash
bash scripts/start-docker.sh
```

## Git Commits

Always show a `git diff --staged` before making a commit and wait for confirmation before proceeding.
