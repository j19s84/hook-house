# Hook House for Codex

This plugin turns Codex lifecycle events into Haunted House sounds and desktop
notifications. It is self-contained; peon-ping is not required.

## Event mapping

| Codex hook | Hook House category |
|---|---|
| `SessionStart` (`startup`, `resume`, `clear`) | `session.start` |
| `Stop` / `SubagentStop` | `task.complete` |
| `PermissionRequest` | `input.required` |
| `PreCompact` | `resource.limit` |

Codex has no failure-only tool hook, so `task.error` is not enabled; running a
hook after every successful tool call would be noisy and wasteful. Likewise,
`user.spam` has no direct Codex lifecycle equivalent.

Use `/ping-snooze` and `/ping-start` to mute or resume the plugin. Hook state is
stored in the plugin data directory, so it survives plugin upgrades.
