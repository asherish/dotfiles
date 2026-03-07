#!/bin/sh
# Claude Code hook script for mandatory skill evaluation.
# Injects skill evaluation instructions before every user prompt.

# Claude Code preserves the original user prompt separately, so we discard stdin here.
cat > /dev/null

cat <<'EOF'
INSTRUCTION: MANDATORY SKILL ACTIVATION SEQUENCE
Step 1 - EVALUATE:
For each skill in <available_skills>, state: [skill-name] - YES/NO - [reason]
Step 2 - ACTIVATE:
IF any skills are YES → Use Skill(skill-name) tool for EACH relevant skill NOW
IF no skills are YES → State "No skills needed" and proceed
Step 3 - IMPLEMENT:
Only after Step 2 is complete, proceed with implementation.
CRITICAL: You MUST call Skill() tool in Step 2. Do NOT skip to implementation.
EOF
