# Timestamp Hook

A Claude Code plugin that automatically injects the current wall-clock time into every assistant turn.

## Problem It Solves

Claude Code has **no sense of time**. Between your messages, it does not know whether 2 minutes or 2 hours have passed. This leads to three failure modes:

1. **Duration hallucination** — Claude guesses elapsed time and gets it wrong
2. **Stale process blindness** — Claude can't reason about whether a background process should have finished
3. **Log correlation failure** — Claude can't tell you "that was 3 minutes ago" when reading timestamped logs

## Features

- **6 lines of shell code** — runs `date` once per prompt
- **~2ms latency** — negligible overhead
- **~10 tokens per turn** — minimal context cost
- **Zero dependencies** — POSIX `date` only

## Installation

### Marketplace install (recommended)

**Slash commands:**
1. Add the marketplace:
   ```
   /plugin marketplace add adrianR84/claude-code-timestamp-hook
   ```
2. Install the plugin:
   ```
   /plugin install timestamp-hook
   ```
3. Reload plugins:
   ```
   /reload-plugins
   ```

**CLI commands:**
```bash
claude plugin marketplace add adrianR84/claude-code-timestamp-hook
claude plugin install timestamp-hook
claude plugin reload
```


## Usage

Once installed, the hook runs automatically on every prompt. The current time is:

- Injected into Claude's context via `additionalContext`

No further action needed.

## How It Works

The hook is a bash script that runs on every `UserPromptSubmit` hook:

```bash
#!/bin/bash
NOW=$(date '+%Y-%m-%d %H:%M:%S %Z')
echo "{\"additionalContext\":\"Current time: ${NOW}\",\"statusMessage\":\"${NOW}\"}"
```

It uses POSIX `date` with no external dependencies.

## License

MIT