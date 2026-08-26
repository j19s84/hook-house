---
name: ping-no-bell
description: Disable or restore Codex's built-in terminal bell while leaving Hook House sounds active. Use when the user hears both the themed sound and a default bell, or asks to turn the Codex bell off or back on.
---

# ping-no-bell

Edit the user-level Codex configuration so Codex's built-in terminal
notification does not duplicate Hook House audio.

## Usage

```text
/ping-no-bell
/ping-no-bell off
```

- With no argument, set `tui.notifications = false`.
- With `off`, restore built-in notifications by setting
  `tui.notifications = true`.

## Configuration edit

1. Resolve the user config as `$CODEX_HOME/config.toml` when `CODEX_HOME` is
   set, otherwise `~/.codex/config.toml`.
2. Read the file before editing it and preserve all unrelated settings and
   comments.
3. If a `[tui]` table exists, add or replace its `notifications` key. Do not
   create a second `[tui]` table.
4. If no `[tui]` table exists, append one:

   ```toml
   [tui]
   notifications = false
   ```

5. Do not change the top-level `notify` setting, lifecycle hooks, or
   `tui.notification_method`.
6. Tell the user to restart Codex after the change.

This setting controls Codex's built-in terminal notifications. Hook House runs
through lifecycle hooks and remains active.
