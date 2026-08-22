# Halloween Crew

A peon-ping pack built from CC0/CC-BY Halloween sound clips (see [CREDITS.md](./CREDITS.md)), processed locally with [sox](http://sox.sourceforge.net/) reverb, and paired with pixel-art icons.

| Event | Sound | Icon |
|---|---|---|
| `session.start` | "I can see you" | demon (default) |
| `task.acknowledge` | "Zombie moan" / "Welcome to the dark side" (alternating) | witch |
| `task.complete` | "Welcome to the dark side" | skeleton |
| `task.error` | "No" | demon (default) |
| `input.required` | Threatening creature growl | demon (default) |
| `resource.limit` | "It's too late, he is already dead" | demon (default) |
| `user.spam` | "Can you feel it?" | demon (default) |

## Install

```bash
peon packs install-local /path/to/hook-house/halloween
peon packs use halloween
```
