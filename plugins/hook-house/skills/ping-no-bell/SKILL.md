---
name: ping-no-bell
description: Suspend or restore other Codex notification sounds while leaving Hook House active. Use when the user hears both the themed sound and a default bell or custom completion sound.
---

# ping-no-bell

Edit the user-level Codex configuration so built-in terminal notifications and
custom `notify` commands do not duplicate Hook House audio.

## Usage

```text
/ping-no-bell
/ping-no-bell off
```

- With no argument, suspend Codex's built-in terminal notifications and any
  top-level custom `notify` command.
- With `off`, restore the exact settings previously suspended by this command.

## Configuration edit

1. Resolve the user config as `$CODEX_HOME/config.toml` when `CODEX_HOME` is
   set, otherwise `~/.codex/config.toml`.
2. Read the file before editing it and preserve all unrelated settings and
   comments.
3. With no argument:
   - If `[tui]` contains an active one-line `notifications = ...` assignment,
     comment it as `# hook-house-suspended-notifications: notifications = ...`
     and add `notifications = false` immediately below it. Preserve the exact
     original assignment after the marker.
   - If `[tui]` has no `notifications` key, add the following inside that table.
     If no `[tui]` table exists, append the table and key. Do not create a
     second `[tui]` table.

     ```toml
     # hook-house-added-notifications
     notifications = false
     ```

   - If there is an active one-line top-level `notify = ...` assignment before
     the first TOML table, comment it as
     `# hook-house-suspended-notify: notify = ...`, preserving the exact
     assignment after the marker.
   - Treat existing Hook House markers plus `notifications = false` as already
     suspended; do not add duplicate keys or markers.
4. With `off`:
   - Remove the Hook House-managed `notifications = false`. Restore the exact
     assignment after `# hook-house-suspended-notifications: `, or remove
     `# hook-house-added-notifications` when there was no prior value.
   - Restore the exact top-level assignment after
     `# hook-house-suspended-notify: `.
   - If an active replacement assignment conflicts with a saved setting, do
     not overwrite it. Report the conflict and leave that marker intact.
5. Only edit one-line assignments. If a target assignment spans multiple
   lines, do not guess; explain that it must be converted to one line first.
6. Do not change lifecycle hooks or `tui.notification_method`.
7. Report what was suspended or restored and tell the user to restart Codex
   after the change.

Hook House runs through lifecycle hooks and remains active throughout.
