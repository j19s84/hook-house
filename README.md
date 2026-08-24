# hook-house 🏚️

Seasonal/themed sound packs for [peon-ping](https://github.com/PeonPing/peon-ping) — the tool that plays voice lines and shows desktop notifications when Claude Code needs your attention.

Each theme lives in its own folder and is a self-contained peon-ping pack (an `openpeon.json` manifest + `sounds/` + `icons/`).

## Packs

| Pack | Folder | Status |
|---|---|---|
| Halloween Crew | [`halloween/`](./halloween) | ✅ Ready |
| Christmas | `christmas/` | 🔜 Planned |

## Installing a pack

```bash
peon packs install-local /path/to/hook-house/halloween
peon packs use halloween
```

Or copy the folder directly into `~/.claude/hooks/peon-ping/packs/`.

## Muting sounds temporarily (`/ping-snooze`, `/ping-start`)

If someone finds the sounds too much after a few hours, there are two companion Claude Code skills — [`skills/ping-snooze/SKILL.md`](./skills/ping-snooze/SKILL.md) and [`skills/ping-start/SKILL.md`](./skills/ping-start/SKILL.md) — that mute/resume peon-ping.

To install them:

```bash
mkdir -p ~/.claude/skills/ping-snooze ~/.claude/skills/ping-start
cp skills/ping-snooze/SKILL.md ~/.claude/skills/ping-snooze/SKILL.md
cp skills/ping-start/SKILL.md ~/.claude/skills/ping-start/SKILL.md
```

Then use them like:

```
/ping-snooze 3       # mute for ~3 hours
/ping-snooze off     # turn back on early
/ping-start          # same as "off" — turn sounds back on
```

Note: `/ping-snooze` is a manual-reminder snooze, not a real scheduler — it won't auto-unmute on its own; use `/ping-start` (or `/ping-snooze off`) when you're ready.

## Licensing

Code and manifests in this repo are MIT licensed (see [LICENSE](./LICENSE)). Audio and image assets are sourced from third parties under their own licenses (mostly CC0, some CC-BY / CC-BY-NC) — see each pack's `CREDITS.md` for exact sources and requirements before reusing assets outside personal use.
