# hook-house 🛎️🏭

Thematic pings for multitasking in your epic AI sessions. Themed sound packs and desktop notifications for Claude Code (via [peon-ping](https://github.com/PeonPing/peon-ping)) and Codex.

## Packs

| Pack | Folder | Status |
|---|---|---|
| Haunted House | [`haunted-house/`](./haunted-house) | ✅ Ready |
| Christmas | `christmas/` | 🔜 Planned |

## Install / uninstall

Tell your agent: **"Read https://github.com/j19s84/hook-house/blob/main/INSTALL.md and install Hook House"** (or "uninstall"). It covers Claude Code and Codex, including updates.

- **Claude Code:** needs peon-ping. Each pack folder is a self-contained peon-ping pack.
- **Codex:** self-contained plugin in [`plugins/hook-house/`](./plugins/hook-house), no peon-ping needed. See its [README](./plugins/hook-house/README.md) for event mapping and `/ping-no-bell`.

## Muting

`/ping-snooze <hours>` mutes for a while and `/ping-start` resumes. It's a manual reminder, not a scheduler, so it won't unmute on its own. Skills live in [`skills/`](./skills) for Claude Code and ship with the Codex plugin.

## Development

The Haunted House pack is stored twice on purpose: `haunted-house/` for Claude Code and `plugins/hook-house/packs/haunted-house/` so the Codex plugin is self-contained. Keep them identical. Smoke test from the repo root:

```bash
bash tests/test-codex-plugin.sh
```

## Licensing

Code and manifests are MIT ([LICENSE](./LICENSE)). Audio and image assets come from third parties under their own licenses (mostly CC0, some CC-BY / CC-BY-NC); see each pack's `CREDITS.md` before reusing them outside personal use.
