#!/bin/sh
# Bootstrap chezmoi dotfiles for devcontainer environments.
# Called automatically by `devcontainer up --dotfiles-repository`.
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Ensure ~/.local/bin is on PATH (chezmoi installs there).
export PATH="$HOME/.local/bin:$PATH"

# Install chezmoi if not already present.
if ! command -v chezmoi >/dev/null 2>&1; then
    sh -c "$(curl -fsLS get.chezmoi.io)"
fi

# Initialize and apply dotfiles from the local clone.
# --force: accept default values for template prompts (non-interactive).
# --source: point chezmoi at the already-cloned repo (avoids re-cloning).
#           chezmoi reads .chezmoiroot to find the actual source under home/.
chezmoi init --apply --force --source "$SCRIPT_DIR"
