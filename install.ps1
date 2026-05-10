# AI Team installer for Windows / PowerShell
# Usage:
#   .\install.ps1 [-Target <path>] [-Ref <branch-or-tag>] [-Force] [-DryRun]

param(
    [string]$Target = (Get-Location).Path,
    [string]$Ref = "main",
    [switch]$Force,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir = $ScriptDir
$TempSource = $null

function Write-Action {
    param([string]$Message)
    if ($DryRun) {
        Write-Host "[dry-run] $Message"
    } else {
        Write-Host $Message
    }
}

function Copy-AiTeamFile {
    param(
        [string]$SourcePath,
        [string]$TargetPath
    )

    $targetParent = Split-Path -Parent $TargetPath

    if ($Force -or -not (Test-Path -LiteralPath $TargetPath)) {
        Write-Action "Install $TargetPath"
        if (-not $DryRun) {
            if (-not (Test-Path -LiteralPath $targetParent)) {
                New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
            }
            Copy-Item -LiteralPath $SourcePath -Destination $TargetPath -Force
        }
        return
    }

    $conflictPath = "$TargetPath.ai-team-new"
    Write-Action "Keep existing $TargetPath; write update to $conflictPath"
    if (-not $DryRun) {
        if (-not (Test-Path -LiteralPath $targetParent)) {
            New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
        }
        Copy-Item -LiteralPath $SourcePath -Destination $conflictPath -Force
    }
}

function Copy-AiTeamDirectory {
    param(
        [string]$SourcePath,
        [string]$TargetPath
    )

    if (-not (Test-Path -LiteralPath $SourcePath)) {
        return
    }

    if (-not (Test-Path -LiteralPath $TargetPath)) {
        Write-Action "Create directory $TargetPath"
        if (-not $DryRun) {
            New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
        }
    }

    Get-ChildItem -LiteralPath $SourcePath -Recurse -File -Force | ForEach-Object {
        $relativePath = $_.FullName.Substring($SourcePath.Length).TrimStart('\', '/')
        $destination = Join-Path $TargetPath $relativePath
        Copy-AiTeamFile -SourcePath $_.FullName -TargetPath $destination
    }
}

try {
    if (-not (Test-Path (Join-Path $SourceDir ".ai"))) {
        $TempSource = Join-Path ([System.IO.Path]::GetTempPath()) ("ai-team-" + [System.Guid]::NewGuid().ToString("N"))
        $ArchivePath = Join-Path $TempSource "ai-team.zip"
        $ExtractPath = Join-Path $TempSource "extract"
        if ($Ref -match '^refs/(heads|tags)/(.+)$') {
            $ArchiveKind = $Matches[1]
            $ArchiveRef = $Matches[2]
        } elseif ($Ref -match '^(heads|tags)/(.+)$') {
            $ArchiveKind = $Matches[1]
            $ArchiveRef = $Matches[2]
        } elseif ($Ref -match '^v[0-9]') {
            $ArchiveKind = "tags"
            $ArchiveRef = $Ref
        } else {
            $ArchiveKind = "heads"
            $ArchiveRef = $Ref
        }
        $ArchiveUrl = "https://github.com/micrfun/ai-team/archive/refs/$ArchiveKind/$ArchiveRef.zip"

        Write-Action "Download AI Team archive ref $Ref"
        New-Item -ItemType Directory -Path $TempSource -Force | Out-Null
        Invoke-WebRequest $ArchiveUrl -OutFile $ArchivePath
        Expand-Archive -Path $ArchivePath -DestinationPath $ExtractPath -Force
        $SourceDir = (Get-ChildItem -LiteralPath $ExtractPath -Directory | Select-Object -First 1).FullName
        if (-not $SourceDir -or -not (Test-Path (Join-Path $SourceDir ".ai"))) {
            throw "Downloaded AI Team archive does not contain .ai/"
        }
    }

    Write-Host "AI Team installer"
    Write-Host "Target directory: $Target"
    if ($Force) { Write-Host "Mode: force overwrite" }
    elseif ($DryRun) { Write-Host "Mode: dry run, no files will be changed" }
    else { Write-Host "Mode: safe merge, existing files are preserved" }
    Write-Host "Source ref: $Ref"
    Write-Host ""

    if (-not (Test-Path $Target)) {
        Write-Host "Target directory does not exist: $Target" -ForegroundColor Red
        exit 1
    }

    $Dirs = @(".ai", ".claude", ".codex", ".gemini", ".cursor", ".antigravity")

    foreach ($dir in $Dirs) {
        $sourcePath = Join-Path $SourceDir $dir
        $targetPath = Join-Path $Target $dir
        Copy-AiTeamDirectory -SourcePath $sourcePath -TargetPath $targetPath
    }

    $Docs = @(
        @{ Source = "README.md"; Target = "AI-TEAM-README.md" },
        @{ Source = "INSTALL.md"; Target = "AI-TEAM-INSTALL.md" },
        @{ Source = "AGENT_INSTALL_PROMPT.md"; Target = "AI-TEAM-AGENT-INSTALL-PROMPT.md" },
        @{ Source = "AI_TEAM_BOOTSTRAP.md"; Target = "AI-TEAM-BOOTSTRAP.md" }
    )

    foreach ($doc in $Docs) {
        $sourcePath = Join-Path $SourceDir $doc.Source
        $targetPath = Join-Path $Target $doc.Target
        if (Test-Path -LiteralPath $sourcePath) {
            Copy-AiTeamFile -SourcePath $sourcePath -TargetPath $targetPath
        }
    }

    Write-Host ""
    if ($DryRun) {
        Write-Host "Dry run complete. No files were changed." -ForegroundColor Cyan
    } else {
        Write-Host "Installation complete." -ForegroundColor Green
    }
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "  1. Open the project in any AI CLI."
    Write-Host "  2. Ask the agent to read AI-TEAM-BOOTSTRAP.md."
    Write-Host "  3. Run the AI Team init workflow for this project."
    Write-Host ""
    Write-Host "Use -Force only when you intentionally want to overwrite existing AI Team files."
} finally {
    if ($TempSource -and (Test-Path $TempSource)) {
        Remove-Item -Path $TempSource -Recurse -Force
    }
}
