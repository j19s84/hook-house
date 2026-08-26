#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
plugin_root="$repo_root/plugins/hook-house"
test_data="$(mktemp -d "${TMPDIR:-/tmp}/hook-house-test.XXXXXX")"
trap 'rm -rf "$test_data"' EXIT

python3 -m json.tool "$repo_root/.agents/plugins/marketplace.json" >/dev/null
python3 -m json.tool "$plugin_root/.codex-plugin/plugin.json" >/dev/null
python3 -m json.tool "$plugin_root/hooks/hooks.json" >/dev/null
bash -n "$plugin_root/scripts/hook-house.sh"

assert_event() {
  local event="$1"
  local expected_category="$2"
  local output
  output="$(
    printf '{"hook_event_name":"%s"}' "$event" |
      PLUGIN_ROOT="$plugin_root" \
      PLUGIN_DATA="$test_data" \
      HOOK_HOUSE_TEST=1 \
      bash "$plugin_root/scripts/hook-house.sh"
  )"
  python3 - "$output" "$event" "$expected_category" <<'PY'
import json
import sys

payload = json.loads(sys.argv[1])
assert payload["event"] == sys.argv[2], payload
assert payload["category"] == sys.argv[3], payload
PY
}

assert_event SessionStart session.start
assert_event Stop task.complete
assert_event SubagentStop task.complete
assert_event PermissionRequest input.required
assert_event PreCompact resource.limit

silent_output="$(
  printf '%s' '{"hook_event_name":"UserPromptSubmit"}' |
    PLUGIN_ROOT="$plugin_root" \
    PLUGIN_DATA="$test_data" \
    HOOK_HOUSE_TEST=1 \
    bash "$plugin_root/scripts/hook-house.sh"
)"
test -z "$silent_output"

PLUGIN_ROOT="$plugin_root" PLUGIN_DATA="$test_data" bash "$plugin_root/scripts/hook-house.sh" pause >/dev/null
test -f "$test_data/paused"
paused_output="$(
  printf '%s' '{"hook_event_name":"Stop"}' |
    PLUGIN_ROOT="$plugin_root" \
    PLUGIN_DATA="$test_data" \
    HOOK_HOUSE_TEST=1 \
    bash "$plugin_root/scripts/hook-house.sh"
)"
test -z "$paused_output"
PLUGIN_ROOT="$plugin_root" PLUGIN_DATA="$test_data" bash "$plugin_root/scripts/hook-house.sh" resume >/dev/null
test ! -f "$test_data/paused"

printf '%s\n' 'Codex plugin smoke tests passed.'
