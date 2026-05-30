#!/usr/bin/env bash
# Source this script to load secrets from Doppler into the current shell.
# Usage: source scripts/setup.sh

set -euo pipefail

DOPPLER_PROJECT="${DOPPLER_PROJECT:-claude-mobilr}"
DOPPLER_CONFIG="${DOPPLER_CONFIG:-dev}"

# Install Doppler CLI if missing
if ! command -v doppler &>/dev/null; then
    echo "[setup] Installing Doppler CLI..."
    curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh | sudo sh
fi

# Authenticate
if [ -n "${DOPPLER_TOKEN:-}" ]; then
    echo "[setup] Authenticating with DOPPLER_TOKEN..."
    doppler configure set token "$DOPPLER_TOKEN" --scope /
else
    echo "[setup] No DOPPLER_TOKEN found — starting interactive login..."
    doppler login
fi

# Set project/config scope
doppler configure set project="$DOPPLER_PROJECT" config="$DOPPLER_CONFIG" --scope /

# Download secrets
echo "[setup] Loading secrets from Doppler ($DOPPLER_PROJECT/$DOPPLER_CONFIG)..."
doppler secrets download --no-file --format env > .env

# Export into the current shell (effective only when sourced)
set -o allexport
# shellcheck disable=SC1091
source .env
set +o allexport

echo "[setup] Done — secrets written to .env and exported to current shell."
echo "[setup] For subsequent commands use: doppler run -- <command>"
