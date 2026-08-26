param([string]$Action = "")

$ErrorActionPreference = "SilentlyContinue"
$pluginRoot = if ($env:PLUGIN_ROOT) { $env:PLUGIN_ROOT } else { Split-Path -Parent $PSScriptRoot }
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME ".codex" }
$pluginData = if ($env:PLUGIN_DATA) { $env:PLUGIN_DATA } else { Join-Path $codexHome "plugins/data/hook-house-hook-house" }
$pausedFile = Join-Path $pluginData "paused"

switch ($Action.ToLowerInvariant()) {
  "pause" {
    New-Item -ItemType Directory -Force -Path $pluginData | Out-Null
    New-Item -ItemType File -Force -Path $pausedFile | Out-Null
    Write-Output "Hook House sounds paused."
    exit 0
  }
  "resume" {
    Remove-Item -Force $pausedFile
    Write-Output "Hook House sounds resumed."
    exit 0
  }
  "status" {
    if (Test-Path $pausedFile) { Write-Output "Hook House is paused." } else { Write-Output "Hook House is active." }
    exit 0
  }
}

if (Test-Path $pausedFile) { exit 0 }

$payload = [Console]::In.ReadToEnd()
try { $event = ($payload | ConvertFrom-Json).hook_event_name } catch { $event = $Action }
if (-not $event) { $event = "Stop" }

$sounds = @()
switch ($event) {
  "SessionStart" {
    $message = "A Codex session has awakened."
    $sounds = @("ICanSeeYou.wav", "EerieForest.wav")
  }
  { $_ -in @("Stop", "SubagentStop") } {
    $message = "Codex finished and is waiting for you."
    $sounds = @("WelcomeToTheDarkSide.wav", "MusicBoxes.wav")
  }
  "PermissionRequest" {
    $message = "Codex needs your permission."
    $sounds = @("CreatureGrowl.wav", "Crow.wav")
  }
  "PreCompact" {
    $message = "Codex is compacting its context."
    $sounds = @("ItsTooLate.wav", "WitchLaugh.wav")
  }
  default { exit 0 }
}

$sound = Get-Random -InputObject $sounds
$soundPath = Join-Path $pluginRoot "packs/haunted-house/sounds/$sound"

if ($env:HOOK_HOUSE_TEST -eq "1") {
  @{ event = $event; sound = $sound } | ConvertTo-Json -Compress
  exit 0
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$player = New-Object System.Media.SoundPlayer $soundPath
$player.Play()
$notification = New-Object System.Windows.Forms.NotifyIcon
$notification.Icon = [System.Drawing.SystemIcons]::Information
$notification.BalloonTipTitle = "Hook House · $(Split-Path -Leaf (Get-Location))"
$notification.BalloonTipText = $message
$notification.Visible = $true
$notification.ShowBalloonTip(4000)
Start-Sleep -Milliseconds 4500
$notification.Dispose()
