<#
.SYNOPSIS
    Re-formats (pretty-prints) all .object files in a directory tree as indented JSON.

.DESCRIPTION
    Recursively finds *.object files, parses them as JSON, and rewrites them with
    consistent indentation. Files that fail to parse as JSON are skipped and reported.

.PARAMETER Path
    Root folder to search for .object files. Defaults to the script's directory.

.PARAMETER WhatIf
    Preview which files would be reformatted without writing changes.

.EXAMPLE
    .\Format-ObjectFiles.ps1 -Path D:\PEL\40.ml300-bs.rts_Attila
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$Path = $PSScriptRoot
)

$objectFiles = Get-ChildItem -Path $Path -Filter '*.object' -Recurse -File

if (-not $objectFiles) {
    Write-Host "No .object files found under '$Path'."
    return
}

$formatted = 0
$skipped = 0
$failed = 0

foreach ($file in $objectFiles) {
    try {
        $raw = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
        if ([string]::IsNullOrWhiteSpace($raw)) {
            Write-Warning "Skipping empty file: $($file.FullName)"
            $skipped++
            continue
        }

        $jsonObject = $raw | ConvertFrom-Json
        $prettyJson = $jsonObject | ConvertTo-Json -Depth 100

        # Normalize the already-pretty raw text for comparison to avoid rewriting unchanged files
        if ($prettyJson -eq $raw) {
            $skipped++
            continue
        }

        if ($PSCmdlet.ShouldProcess($file.FullName, 'Reformat as indented JSON')) {
            Set-Content -LiteralPath $file.FullName -Value $prettyJson -Encoding UTF8 -NoNewline
            $formatted++
        }
    }
    catch {
        Write-Warning "Failed to format '$($file.FullName)': $($_.Exception.Message)"
        $failed++
    }
}

Write-Host "Done. Formatted: $formatted, Skipped (already formatted/empty): $skipped, Failed: $failed"
