#!/bin/bash
# Claude Code hook: injects wall-clock time into assistant context.
# Configured in settings.json as UserPromptSubmit hook type.
# Zero dependencies. ~2ms overhead per prompt.

NOW=$(date '+%Y-%m-%d %H:%M:%S %Z')
echo "{\"continue\":true,\"hookSpecificOutput\":{\"hookEventName\":\"UserPromptSubmit\",\"additionalContext\":\"Current time: ${NOW}\",\"statusMessage\":\"${NOW}\"}}"