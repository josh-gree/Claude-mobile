#!/bin/bash
set -e

# Ensure we're on main
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "Switching from $CURRENT_BRANCH to main..."
  git checkout main
fi

# Stage everything
git add -A

# Bail if nothing to commit
if git diff --staged --quiet; then
  echo "Nothing to commit."
  exit 0
fi

# Generate commit message from staged diff using Claude
echo "Generating commit message..."
COMMIT_MSG=$(git diff --staged | claude -p "Write a concise git commit message for this diff. Follow conventional commit style. First line: short summary (max 72 chars). Optionally a blank line then a short body if needed. Output ONLY the commit message, nothing else.")

echo ""
echo "Commit message:"
echo "---"
echo "$COMMIT_MSG"
echo "---"
echo ""

# Commit and push
git commit -m "$COMMIT_MSG"
git push -u origin main

# Print diffshub URL
SHA=$(git rev-parse HEAD)
REPO=$(git remote get-url origin | sed 's|.*github.com[:/]\(.*\)\.git|\1|' | sed 's|.*127.0.0.1:[0-9]*/git/||')
echo ""
echo "Diff: https://diffshub.com/$REPO/commit/$SHA"
