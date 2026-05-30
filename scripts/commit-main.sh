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
COMMIT_MSG=$(git diff --staged | claude --output-format text -p "You are generating a git commit message. Write a concise commit message for the following diff. Use conventional commit style (feat/fix/chore/docs etc). First line max 72 chars. Optional short body after a blank line. Output ONLY the raw commit message text with no explanation, no markdown, no quotes.")

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
