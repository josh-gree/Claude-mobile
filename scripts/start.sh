#!/bin/bash

# Ensure we're on main and up to date before any work
echo "Switching to main and pulling latest..."
git checkout main && git pull origin main
echo "On branch: $(git branch --show-current)"

if ! command -v doppler &> /dev/null; then
    echo "Installing Doppler CLI..."
    apt-get update -qq && apt-get install -y apt-transport-https ca-certificates curl gnupg > /dev/null 2>&1
    curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list > /dev/null
    apt-get update -qq && apt-get install -y doppler > /dev/null 2>&1
    DOPPLER_STATUS="installed $(doppler --version)"
else
    DOPPLER_STATUS="ready $(doppler --version)"
fi

if ! docker info > /dev/null 2>&1; then
    dockerd > /tmp/dockerd.log 2>&1 &
    echo "Waiting for Docker daemon..."
    DOCKER_STATUS="starting"
    for i in $(seq 1 10); do
        sleep 1
        if docker info > /dev/null 2>&1; then
            DOCKER_STATUS="ready"
            break
        fi
    done
    if [ "$DOCKER_STATUS" != "ready" ]; then
        echo "Docker failed to start. Check /tmp/dockerd.log"
        DOCKER_STATUS="FAILED"
    fi
else
    DOCKER_STATUS="already running"
fi

# ── Session Summary ──────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║              SESSION READY — SUMMARY                ║"
echo "╠══════════════════════════════════════════════════════╣"
printf "║  %-20s %-31s ║\n" "Branch:"  "$(git branch --show-current)"
printf "║  %-20s %-31s ║\n" "Git:"     "$(git status --short | wc -l | xargs -I{} echo '{} uncommitted files' | sed 's/^0 uncommitted files/clean/')"
printf "║  %-20s %-31s ║\n" "Doppler:" "$DOPPLER_STATUS"
printf "║  %-20s %-31s ║\n" "Docker:"  "$DOCKER_STATUS"
echo "╠══════════════════════════════════════════════════════╣"
echo "║  Recent commits:                                     ║"
git log --oneline -5 | while read line; do
    printf "║    %-48s ║\n" "${line:0:48}"
done
if [ -f "NOTES.md" ]; then
    echo "╠══════════════════════════════════════════════════════╣"
    echo "║  Latest note:                                        ║"
    tail -1 NOTES.md | while IFS= read -r line; do
        printf "║    %-48s ║\n" "${line:0:48}"
    done
fi
echo "╚══════════════════════════════════════════════════════╝"
echo ""
echo "AGENT: Share the summary above with the user as your first message."
