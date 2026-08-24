---
name: ping-start
description: Turn peon-ping sounds back on after a snooze or mute. Use when the user wants to resume, unmute, or restart hook-house/peon-ping sounds (e.g. "turn sounds back on", "unmute peon-ping").
user_invocable: true
---

# ping-start

Resumes peon-ping sounds. Equivalent to `/ping-snooze off` or `/peon-ping-toggle` when currently muted.

## Usage

```
/ping-start
```

## Steps

```bash
bash "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"/hooks/peon-ping/peon.sh resume
```

Report the output to the user (it will print `peon-ping: sounds resumed`).
