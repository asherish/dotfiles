#!/bin/bash
set -euo pipefail

echo "Installing apt packages..."

if ! command -v sudo >/dev/null 2>&1; then
    echo "Error: sudo is not installed."
    exit 1
fi

sudo apt update
sudo apt install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    openssh-server \
    tmux \
    wget \
    gh


