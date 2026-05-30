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
    echo "Doppler CLI installed: $(doppler --version)"
else
    echo "Doppler CLI already installed: $(doppler --version)"
fi

if ! docker info > /dev/null 2>&1; then
    dockerd > /tmp/dockerd.log 2>&1 &
    echo "Waiting for Docker daemon..."
    for i in $(seq 1 10); do
        sleep 1
        docker info > /dev/null 2>&1 && echo "Docker is ready." && exit 0
    done
    echo "Docker failed to start. Check /tmp/dockerd.log"
    exit 1
else
    echo "Docker is already running."
fi
