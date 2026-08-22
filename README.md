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

## Licensing

Code and manifests in this repo are MIT licensed (see [LICENSE](./LICENSE)). Audio and image assets are sourced from third parties under their own licenses (mostly CC0, some CC-BY / CC-BY-NC) — see each pack's `CREDITS.md` for exact sources and requirements before reusing assets outside personal use.
