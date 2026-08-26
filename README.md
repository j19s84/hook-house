# hook-house 🛎️🏭 

Seasonal/themed sound packs for [peon-ping](https://github.com/PeonPing/peon-ping) — the tool that plays voice lines and shows desktop notifications when Claude Code needs your attention.

Each theme lives in its own folder and is a self-contained peon-ping pack (an `openpeon.json` manifest + `sounds/` + `icons/`).

## Packs

| Pack | Folder | Status |
|---|---|---|
| Haunted House | [`haunted-house/`](./haunted-house) | ✅ Ready |
| Christmas | `christmas/` | 🔜 Planned |

## Claude installation

```bash
peon packs install-local /path/to/hook-house/haunted-house
peon packs use haunted-house
```

Or copy the folder directly into `~/.claude/hooks/peon-ping/packs/`.

## Codex installation

Hook House is also a self-contained Codex plugin. Add this repository as a
marketplace, then install the plugin:

```bash
codex plugin marketplace add j19s84/hook-house
codex plugin add hook-house@hook-house
```

Restart Codex after installation. The first time the command hooks are seen,
open `/hooks` and review/trust them. Hook House then plays a themed sound and
shows a desktop notification for session start, turn completion, permission
requests, context compaction, and subagent completion.

See the [official Codex hooks documentation](https://developers.openai.com/codex/hooks)
for hook review, event payloads, and plugin hook discovery.

The Codex plugin is self-contained and does not require peon-ping. It supports
macOS (`afplay` plus `terminal-notifier` or Notification Center), Linux
(`paplay`, `aplay`, or `ffplay` plus `notify-send`), and Windows PowerShell.

### Disable Codex's default bell

If Codex plays its built-in terminal bell alongside the Hook House sound, run
`/ping-no-bell` after installing the plugin. Alternatively, add this to your
user-level `~/.codex/config.toml` (add only the key if `[tui]` already exists):

```toml
[tui]
notifications = false
```

This disables Codex's built-in terminal notification while leaving Hook House
sounds and desktop notifications active. Run `/ping-no-bell off` to restore it.

To update later:

```bash
codex plugin marketplace upgrade hook-house
codex plugin remove hook-house@hook-house
codex plugin add hook-house@hook-house
```

## Development

Run the Codex plugin smoke tests from the repository root:

```bash
bash tests/test-codex-plugin.sh
```

## Muting sounds temporarily (`/ping-snooze`, `/ping-start`) for Claude

If someone finds the sounds too much after a few hours, there are two companion Claude Code skills — [`skills/ping-snooze/SKILL.md`](./skills/ping-snooze/SKILL.md) and [`skills/ping-start/SKILL.md`](./skills/ping-start/SKILL.md) — that mute/resume peon-ping.

To install those extra skills:

```bash
mkdir -p ~/.claude/skills/ping-snooze ~/.claude/skills/ping-start
cp skills/ping-snooze/SKILL.md ~/.claude/skills/ping-snooze/SKILL.md
cp skills/ping-start/SKILL.md ~/.claude/skills/ping-start/SKILL.md
```

Then use those skills like:

```
/ping-snooze 3       # mute for ~3 hours
/ping-start           # turn sounds back on
```

Note: `/ping-snooze` is a manual-reminder snooze, not a real scheduler — it won't auto-unmute on its own; run `/ping-start` when you're ready.

## Licensing

Code and manifests in this repo are MIT licensed (see [LICENSE](./LICENSE)). Audio and image assets are sourced from third parties under their own licenses (mostly CC0, some CC-BY / CC-BY-NC) — see each pack's `CREDITS.md` for exact sources and requirements before reusing assets outside personal use.
