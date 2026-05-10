# AI Team Template — установщик для Windows
# Использование:
#   .\install.ps1 [-Target <path>]

param(
    [string]$Target = (Get-Location).Path
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir = $ScriptDir
$TempSource = $null

if (-not (Test-Path (Join-Path $SourceDir ".ai"))) {
    $TempSource = Join-Path ([System.IO.Path]::GetTempPath()) ("ai-team-" + [System.Guid]::NewGuid().ToString("N"))
    $ArchivePath = Join-Path $TempSource "ai-team.zip"
    $ExtractPath = Join-Path $TempSource "extract"

    New-Item -ItemType Directory -Path $TempSource -Force | Out-Null
    Invoke-WebRequest "https://github.com/micrfun/ai-team/archive/refs/heads/main.zip" -OutFile $ArchivePath
    Expand-Archive -Path $ArchivePath -DestinationPath $ExtractPath -Force
    $SourceDir = Join-Path $ExtractPath "ai-team-main"
}

Write-Host "🤖 AI Team Template installer" -ForegroundColor Cyan
Write-Host "Target directory: $Target"
Write-Host ""

if (-not (Test-Path $Target)) {
    Write-Host "❌ Target directory does not exist: $Target" -ForegroundColor Red
    exit 1
}

$Dirs = @(".ai", ".claude", ".codex", ".gemini", ".cursor", ".antigravity")

# Проверка конфликтов
$Conflicts = @()
foreach ($dir in $Dirs) {
    if (Test-Path (Join-Path $Target $dir)) {
        $Conflicts += $dir
    }
}

if ($Conflicts.Count -gt 0) {
    Write-Host "⚠️  Found existing directories: $($Conflicts -join ', ')" -ForegroundColor Yellow
    $reply = Read-Host "Overwrite? [y/N]"
    if ($reply -notmatch '^[Yy]$') {
        Write-Host "Cancelled."
        exit 0
    }
}

# Копирование
foreach ($dir in $Dirs) {
    $src = Join-Path $SourceDir $dir
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $Target -Recurse -Force
        Write-Host "✓ Installed $dir" -ForegroundColor Green
    }
}

# Docs
$Docs = @(
    @{ Source = "README.md"; Target = "AI-TEAM-README.md" },
    @{ Source = "INSTALL.md"; Target = "AI-TEAM-INSTALL.md" },
    @{ Source = "AGENT_INSTALL_PROMPT.md"; Target = "AI-TEAM-AGENT-INSTALL-PROMPT.md" }
)

foreach ($doc in $Docs) {
    $sourcePath = Join-Path $SourceDir $doc.Source
    $targetPath = Join-Path $Target $doc.Target
    if ((Test-Path $sourcePath) -and (-not (Test-Path $targetPath))) {
        Copy-Item -Path $sourcePath -Destination $targetPath
        Write-Host "✓ Installed $($doc.Target)" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "✅ Installation complete." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open the project in any AI CLI (Claude Code, Codex, Gemini, Cursor, Antigravity)"
Write-Host "  2. The agent will detect the unfilled context and run /init automatically"
Write-Host "  3. Or trigger it manually: ask the agent to 'run init workflow'"
Write-Host ""
Write-Host "Read AI-TEAM-README.md and AI-TEAM-INSTALL.md for details."

if ($TempSource -and (Test-Path $TempSource)) {
    Remove-Item -Path $TempSource -Recurse -Force
}
