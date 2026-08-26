---
name: ping-start
description: Turn Hook House sounds and notifications back on in Codex. Use when the user wants to resume, unmute, or restart Hook House.
user_invocable: true
---

# ping-start

Resumes Hook House. Equivalent to `/ping-snooze off`.

## Usage

```
/ping-start
```

## Steps

```bash
hook_house_data="${CODEX_HOME:-$HOME/.codex}/plugins/data/hook-house-hook-house"
rm -f "$hook_house_data/paused"
```

On Windows PowerShell, use `$env:CODEX_HOME` when set, otherwise `$HOME/.codex`, and remove `plugins/data/hook-house-hook-house/paused`.

Report `Hook House sounds resumed.` to the user.
