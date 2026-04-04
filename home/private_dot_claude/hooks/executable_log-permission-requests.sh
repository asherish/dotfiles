#!/bin/bash
# Log tool calls that triggered a permission dialog.
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
[ -z "$TOOL_NAME" ] && exit 0

case "$TOOL_NAME" in
  Bash)
    COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')
    FIRST_WORD=$(echo "$COMMAND" | awk '{print $1}')
    RULE="Bash($FIRST_WORD:*)"
    DETAIL=$(printf '%.500s' "$COMMAND")
    ;;
  *)
    RULE="$TOOL_NAME"
    DETAIL=$(echo "$INPUT" | jq -r '.tool_input.file_path // (.tool_input | tostring)' 2>/dev/null)
    DETAIL=$(printf '%.500s' "$DETAIL")
    ;;
esac

LOG="$HOME/.claude/permission-log.jsonl"
jq -nc \
  --arg ts "$(date -Iseconds)" \
  --arg tool "$TOOL_NAME" \
  --arg detail "$DETAIL" \
  --arg rule "$RULE" \
  '{timestamp: $ts, tool: $tool, detail: $detail, rule: $rule}' >> "$LOG"
exit 0
