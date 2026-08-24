---
name: ping-snooze
description: Temporarily mute peon-ping sounds for a set number of hours, with a reminder of when to turn it back on. Use when the user wants to snooze, pause, or silence peon-ping / hook-house sounds for a while (e.g. "mute this for 3 hours", "snooze sounds overnight").
user_invocable: true
---

# ping-snooze

Mutes peon-ping (same as `/peon-ping-toggle` pause) and tells the user when to turn it back on. This does NOT auto-resume — peon-ping has no built-in scheduler, so re-enabling requires a manual `/ping-snooze off` (or `/peon-ping-toggle`) after the snooze period.

## Usage

```
/ping-snooze 3
/ping-snooze 8
/ping-snooze off
```

Argument is hours (defaults to 1 if omitted or not a number).

## Steps

1. Parse the argument. If it's "off", skip to "Turning it back on early" below.
2. Otherwise, treat the argument as hours (default: 1). Mute sounds:

```bash
bash "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"/hooks/peon-ping/peon.sh pause
```

3. Compute the resume time (current time + N hours) and report it to the user, e.g.:

```bash
date -v+${HOURS}H "+%-I:%M %p" 2>/dev/null || date -d "+${HOURS} hours" "+%-I:%M %p"
```

4. Tell the user:

```
Sounds snoozed for ~[N] hours.
Run /ping-snooze off when you're ready to turn it back on — around [TIME].
```

## Turning it back on early

```bash
bash "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"/hooks/peon-ping/peon.sh resume
```

## Notes

- This is a manual-reminder snooze, not a real scheduler — peon-ping doesn't run in the background, so nothing will auto-unmute. If the user wants true auto-resume, that requires a separate companion hook (bigger change, not what this skill does).
