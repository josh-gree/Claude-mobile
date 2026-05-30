#!/bin/bash
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
