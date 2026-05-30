#!/bin/bash
# One-shot session status: branch, changes, recent commits, open PRs

BOLD='\033[1m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

BRANCH=$(git rev-parse --abbrev-ref HEAD)
REPO=$(git remote get-url origin | sed 's|.*/git/||' | sed 's|.*github.com[:/]||' | sed 's|\.git$||')

echo -e "${BOLD}=== Session Status ===${RESET}"
echo -e "${CYAN}Branch:${RESET} $BRANCH"
echo -e "${CYAN}Repo:${RESET}   $REPO"
echo ""

# Uncommitted changes
STAGED=$(git diff --cached --name-only)
UNSTAGED=$(git diff --name-only)
UNTRACKED=$(git ls-files --others --exclude-standard)

if [ -z "$STAGED" ] && [ -z "$UNSTAGED" ] && [ -z "$UNTRACKED" ]; then
  echo -e "${GREEN}Working tree clean${RESET}"
else
  echo -e "${BOLD}Uncommitted changes:${RESET}"
  [ -n "$STAGED" ]    && echo "$STAGED"    | sed 's/^/  staged:   /'
  [ -n "$UNSTAGED" ]  && echo "$UNSTAGED"  | sed 's/^/  modified: /'
  [ -n "$UNTRACKED" ] && echo "$UNTRACKED" | sed 's/^/  new:      /'
fi

echo ""
echo -e "${BOLD}Recent commits:${RESET}"
git log --oneline -8

# Notes file if it exists
if [ -f "NOTES.md" ]; then
  echo ""
  echo -e "${BOLD}Notes:${RESET}"
  tail -10 NOTES.md
fi
