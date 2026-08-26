#!/usr/bin/env bash

# Hook House runtime for Codex on macOS and Linux. Codex hook JSON arrives on
# stdin. The script intentionally emits no stdout so it never adds model context.

set -u

plugin_root="${PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
plugin_data="${PLUGIN_DATA:-${CODEX_HOME:-$HOME/.codex}/plugins/data/hook-house-hook-house}"
paused_file="$plugin_data/paused"

case "${1:-}" in
  pause)
    mkdir -p "$plugin_data" && touch "$paused_file"
    printf '%s\n' 'Hook House sounds paused.'
    exit 0
    ;;
  resume)
    rm -f "$paused_file"
    printf '%s\n' 'Hook House sounds resumed.'
    exit 0
    ;;
  status)
    if [ -f "$paused_file" ]; then
      printf '%s\n' 'Hook House is paused.'
    else
      printf '%s\n' 'Hook House is active.'
    fi
    exit 0
    ;;
esac

[ -f "$paused_file" ] && exit 0

payload="$(cat 2>/dev/null || true)"
event="$(printf '%s' "$payload" | sed -n 's/.*"hook_event_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"
[ -z "$event" ] && event="${1:-Stop}"

case "$event" in
  SessionStart)
    category='session.start'
    message='A Codex session has awakened.'
    icon='demon.png'
    sounds=('ICanSeeYou.wav' 'EerieForest.wav')
    ;;
  Stop|SubagentStop)
    category='task.complete'
    message='Codex finished and is waiting for you.'
    icon='skeleton.png'
    sounds=('WelcomeToTheDarkSide.wav' 'MusicBoxes.wav')
    ;;
  PermissionRequest)
    category='input.required'
    message='Codex needs your permission.'
    icon='witch-yellow.png'
    sounds=('CreatureGrowl.wav' 'Crow.wav')
    ;;
  PreCompact)
    category='resource.limit'
    message='Codex is compacting its context.'
    icon='skeleton-red.png'
    sounds=('ItsTooLate.wav' 'WitchLaugh.wav')
    ;;
  *) exit 0 ;;
esac

sound="${sounds[$((RANDOM % ${#sounds[@]}))]}"
sound_path="$plugin_root/packs/haunted-house/sounds/$sound"
icon_path="$plugin_root/packs/haunted-house/icons/$icon"
project="$(basename "$PWD")"
title="Hook House · $project"

if [ "${HOOK_HOUSE_TEST:-0}" = '1' ]; then
  printf '{"event":"%s","category":"%s","sound":"%s","icon":"%s"}\n' \
    "$event" "$category" "$sound" "$icon"
  exit 0
fi

case "$(uname -s 2>/dev/null || true)" in
  Darwin)
    if command -v afplay >/dev/null 2>&1; then
      afplay "$sound_path" >/dev/null 2>&1 &
    fi
    if command -v terminal-notifier >/dev/null 2>&1; then
      terminal-notifier -title "$title" -message "$message" -appIcon "$icon_path" >/dev/null 2>&1 &
    else
      osascript - "$title" "$message" >/dev/null 2>&1 <<'APPLESCRIPT' &
on run argv
  display notification (item 2 of argv) with title (item 1 of argv)
end run
APPLESCRIPT
    fi
    ;;
  Linux)
    if command -v paplay >/dev/null 2>&1; then
      paplay "$sound_path" >/dev/null 2>&1 &
    elif command -v aplay >/dev/null 2>&1; then
      aplay -q "$sound_path" >/dev/null 2>&1 &
    elif command -v ffplay >/dev/null 2>&1; then
      ffplay -nodisp -autoexit -loglevel quiet "$sound_path" >/dev/null 2>&1 &
    fi
    if command -v notify-send >/dev/null 2>&1; then
      notify-send -i "$icon_path" "$title" "$message" >/dev/null 2>&1 &
    fi
    ;;
esac

exit 0
