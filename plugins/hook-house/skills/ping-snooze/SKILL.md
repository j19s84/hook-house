---
name: ping-snooze
description: Temporarily mute Hook House sounds and notifications in Codex. Use when the user wants to snooze, pause, or silence Hook House for a while.
user_invocable: true
---

# ping-snooze

Mutes Hook House and tells the user when to turn it back on. This does not auto-resume; re-enabling requires `/ping-snooze off` or `/ping-start`.

## Usage

```
/ping-snooze 3
/ping-snooze 8
/ping-snooze off
```

Argument is hours (defaults to 1 if omitted or not a number).

## Steps

1. Parse the argument. If it's "off", skip to "Turning it back on early" below.
2. Otherwise, treat the argument as hours (default: 1). Create Hook House's pause marker.

```bash
hook_house_data="${CODEX_HOME:-$HOME/.codex}/plugins/data/hook-house-hook-house"
mkdir -p "$hook_house_data" && touch "$hook_house_data/paused"
```

On Windows PowerShell, use `$env:CODEX_HOME` when set, otherwise `$HOME/.codex`, and create `plugins/data/hook-house-hook-house/paused`.

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
hook_house_data="${CODEX_HOME:-$HOME/.codex}/plugins/data/hook-house-hook-house"
rm -f "$hook_house_data/paused"
```

## Notes

- This is a manual reminder, not a scheduler. Nothing auto-unmutes.
