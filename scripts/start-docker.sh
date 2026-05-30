#!/bin/bash

# Ensure we're on main and up to date before any work
echo "Switching to main and pulling latest..."
git checkout main && git pull origin main
echo "On branch: $(git branch --show-current)"

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
