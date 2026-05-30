#!/bin/bash
# Usage: bash scripts/commit-main.sh "your commit message"
set -e

if [ -z "$1" ]; then
  echo "Usage: bash scripts/commit-main.sh \"commit message\""
  exit 1
fi

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

# Commit and push
git commit -m "$1"
git push -u origin main

# Print diffshub URL
SHA=$(git rev-parse HEAD)
REPO=$(git remote get-url origin | sed 's|.*127.0.0.1:[0-9]*/git/||')
echo ""
echo "Diff: https://diffshub.com/$REPO/commit/$SHA"
