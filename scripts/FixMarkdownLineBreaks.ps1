<#
.SYNOPSIS
    Adds a Markdown line break (two trailing spaces) to lines that continue
    into the next line of the same paragraph.

.DESCRIPTION
    Without trailing spaces, Markdown joins consecutive lines into one line.
    The script skips lines where a break is not needed or would change the
    content: headings, table rows, list starts, raw HTML lines, fenced code
    blocks and <script>/<style> blocks.
    Files are written as UTF-8 without BOM; line endings are kept.

.PARAMETER Path
    A Markdown file to process. Without it, the script processes every .md
    file in the docs folder of the repository.

.EXAMPLE
    pwsh scripts/FixMarkdownLineBreaks.ps1
    pwsh scripts/FixMarkdownLineBreaks.ps1 docs/Study/Numbrid.md
#>
param(
    [string]$Path
)

$ErrorActionPreference = 'Stop'

function Test-FenceLine([string]$Line) {
    return $Line.TrimStart() -match '^(```|~~~)'
}

function Test-BlockStartLine([string]$Line) {
    # Lines that start a new block; a line break before them is not needed.
    $trimmed = $Line.TrimStart()
    return ($trimmed -match '^#{1,6}\s') -or      # heading
           ($trimmed -match '^([-*+]|\d+\.)\s') -or # list item
           ($trimmed -match '^\|') -or             # table row
           ($trimmed -match '^>') -or              # block quote
           ($trimmed -match '^<') -or              # raw HTML
           (Test-FenceLine $Line)
}

function Update-MarkdownFile([string]$FilePath) {
    $text = [System.IO.File]::ReadAllText($FilePath)  # detects and drops a BOM
    $newLine = if ($text.Contains("`r`n")) { "`r`n" } else { "`n" }
    $endsWithNewLine = $text.EndsWith("`n")
    $lines = @($text -split "`r?`n")
    if ($endsWithNewLine) {
        $lines = @($lines[0..($lines.Count - 2)])
    }

    $changed = @()
    $inFence = $false
    $inRawBlock = $false

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        if (Test-FenceLine $line) {
            $inFence = -not $inFence
            continue
        }
        if ($inFence) { continue }

        if ($line -match '<(script|style)\b') { $inRawBlock = $true }
        if ($inRawBlock) {
            if ($line -match '</(script|style)>') { $inRawBlock = $false }
            continue
        }

        if ($i -eq $lines.Count - 1) { continue }
        $next = $lines[$i + 1]

        if ($line.Trim() -eq '' -or $next.Trim() -eq '') { continue }
        if ($line.EndsWith('  ')) { continue }
        if ($line.TrimStart() -match '^(#{1,6}\s|<)') { continue }  # heading, raw HTML
        if ($line.TrimEnd().EndsWith('|')) { continue }
        if (Test-BlockStartLine $next) { continue }

        $lines[$i] = $line.TrimEnd(' ') + '  '
        $changed += $i + 1
    }

    if ($changed.Count -gt 0) {
        $output = $lines -join $newLine
        if ($endsWithNewLine) { $output += $newLine }
        [System.IO.File]::WriteAllText($FilePath, $output, [System.Text.UTF8Encoding]::new($false))
        Write-Host "${FilePath}: added line breaks on lines $($changed -join ', ')"
    }
}

if ($Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "File not found: $Path"
    }
    Update-MarkdownFile (Resolve-Path -LiteralPath $Path).Path
} else {
    $docs = Join-Path (Split-Path $PSScriptRoot -Parent) 'docs'
    Get-ChildItem -LiteralPath $docs -Recurse -Filter *.md -File |
        Where-Object { $_.FullName -notmatch '[\\/]\.' } |
        ForEach-Object { Update-MarkdownFile $_.FullName }
}
