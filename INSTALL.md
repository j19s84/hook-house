# Hook House: agent install / uninstall instructions

This file is for AI coding agents. A user will tell you "install" or "uninstall" Hook House and point you at this repo. Follow the matching section below exactly. Do not improvise extra steps, and report each command's result to the user.

## Step 0: Work out which agent you are

- You are **Claude Code** if you run inside Claude Code. Use the **Claude Code** sections.
- You are **Codex** if you run inside the OpenAI Codex CLI. Use the **Codex** sections.
- If you cannot tell, ask the user which one they want.

Supported OS for sound and notifications: macOS, Linux, Windows (Codex only).

---

## Install: Claude Code

Hook House packs for Claude Code are [peon-ping](https://github.com/PeonPing/peon-ping) packs, so peon-ping must be installed first.

1. Check for peon-ping: run `command -v peon`. If the command is not found, also check for `~/.claude/hooks/peon-ping/peon.sh`.
2. If peon-ping is missing, stop and tell the user. Install it by following the README at https://github.com/PeonPing/peon-ping, then continue. Do not guess an install command.
3. Clone this repo somewhere permanent (not `/tmp`). The pack is copied at install time, so the clone can be deleted afterwards:
   ```bash
   git clone https://github.com/j19s84/hook-house.git ~/hook-house
   ```
   If `~/hook-house` already exists, run `git -C ~/hook-house pull` instead.
4. Install and activate the pack:
   ```bash
   peon packs install-local ~/hook-house/haunted-house
   peon packs use haunted-house
   ```
5. Verify: `peon packs list` must show `haunted-house`. Play one sound with `peon preview session.start`.
6. Optional: install the mute/unmute skills.
   ```bash
   mkdir -p ~/.claude/skills/ping-snooze ~/.claude/skills/ping-start
   cp ~/hook-house/skills/ping-snooze/SKILL.md ~/.claude/skills/ping-snooze/SKILL.md
   cp ~/hook-house/skills/ping-start/SKILL.md ~/.claude/skills/ping-start/SKILL.md
   ```
7. Tell the user: sounds play on the next Claude Code event. `/ping-snooze 3` mutes for about 3 hours and `/ping-start` resumes (only if you installed step 6).

## Uninstall: Claude Code

1. If `haunted-house` is the active pack, switch to another one first, for example `peon packs use peon`. Check `peon packs list` for what is installed.
2. Remove the pack: `echo y | peon packs remove haunted-house`. The command asks for confirmation and prints "Cancelled." without the `y`. If it still fails, delete the folder `~/.claude/hooks/peon-ping/packs/haunted-house`.
3. Remove the optional skills if present: delete `~/.claude/skills/ping-snooze` and `~/.claude/skills/ping-start`.
4. Optional: delete the clone at `~/hook-house` if you created it. Ask the user first.
5. Do **not** uninstall peon-ping itself unless the user asks. Other sounds and packs depend on it.
6. Verify: `peon packs list` no longer shows `haunted-house`.

---

## Install: Codex

The Codex plugin is self-contained. It does not need peon-ping.

1. Run:
   ```bash
   codex plugin marketplace add j19s84/hook-house
   codex plugin add hook-house@hook-house
   ```
2. Tell the user to do these two things, because you cannot do them yourself:
   - Restart Codex.
   - Open `/hooks` and review and trust the Hook House command hooks the first time they appear.
3. Optional: if Codex's own terminal bell plays on top of Hook House sounds, the user can run `/ping-no-bell` after the restart. `/ping-no-bell off` undoes it.

## Uninstall: Codex

1. Run `codex plugin remove hook-house@hook-house`.
2. Optional: run `codex plugin marketplace remove hook-house`.
3. If the user ran `/ping-no-bell` earlier, tell them to run `/ping-no-bell off` first, to restore their original notification settings. Do this **before** removing the plugin, because the command is part of the plugin.
4. Tell the user to restart Codex.

## Update: Codex

```bash
codex plugin marketplace upgrade hook-house
codex plugin remove hook-house@hook-house
codex plugin add hook-house@hook-house
```

---

## Rules for agents

- Never run `sudo`, and never edit files outside the paths named here.
- If any command fails, show the user the exact error and stop. Do not try workarounds.
- Audio assets have their own licenses. See `haunted-house/CREDITS.md`.
