#!/bin/sh
# Switch the IDE left pane (:.1) to a given tool.
# Usage: ide-switch.sh <tool>
tool="$1"
tmux respawn-pane -k -t :.1 "zsh --no-rcs -c \"$tool; exec zsh\"" \; \
     select-pane -t :.1
