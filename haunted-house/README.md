# Haunted House

A peon-ping pack built from CC0/CC-BY Halloween sound clips (see [CREDITS.md](./CREDITS.md)), processed locally with [sox](http://sox.sourceforge.net/) reverb, and paired with pixel-art icons.

| Event | Sound | Icon |
|---|---|---|
| `session.start` | "I can see you" / "Eerie forest" | demon, green (default) |
| `task.complete` | "Welcome to the dark side" / "33 music boxes" | skeleton, green |
| `task.error` | "No" / "Horror laugh" | demon, orange |
| `input.required` | Threatening creature growl / Crow | witch, yellow |
| `resource.limit` | "It's too late, he is already dead" / "Witch laugh" | skeleton, red |
| `user.spam` | "Can you feel it?" / "Nightmare soundscape" | witch, orange |

Icon colors are a simple severity scale: green = normal, yellow = needs your attention, orange = warning, red = critical.

## Install

```bash
peon packs install-local /path/to/hook-house/haunted-house
peon packs use haunted-house
```
