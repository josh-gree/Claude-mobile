#!/bin/bash
# Usage: bash scripts/note.sh "your note here"
# Appends a timestamped note to NOTES.md

if [ -z "$1" ]; then
  echo "Usage: bash scripts/note.sh \"your note here\""
  exit 1
fi

NOTES_FILE="NOTES.md"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Create file with header if it doesn't exist
if [ ! -f "$NOTES_FILE" ]; then
  echo "# Notes" > "$NOTES_FILE"
  echo "" >> "$NOTES_FILE"
fi

echo "- **[$TIMESTAMP]** ($BRANCH) $1" >> "$NOTES_FILE"
echo "Note saved to $NOTES_FILE"
