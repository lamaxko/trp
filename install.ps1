$TrpPath = "C:\trp\trp.py"
$TrpExe = "C:\trp\trp.exe"
$TrpErrors = "$env:TEMP\trp_errors.txt"
$ProfilePath = $PROFILE

Write-Host "Installing trp..."

# Ensure Python is installed
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Python is not installed. Install Python and rerun this script."
    exit 1
}

# Ensure trp directory exists
if (-not (Test-Path "C:\trp")) {
    New-Item -ItemType Directory -Path "C:\trp" | Out-Null
}

# Copy trp.py
$trpScriptContent = @"
$(Get-Content -Raw -Path "$PSScriptRoot\trp.py")
"@
Set-Content -Path $TrpPath -Value $trpScriptContent -Encoding UTF8

# Make trp executable
Set-Content -Path $TrpExe -Value "@echo off`npython C:\trp\trp.py %*" -Encoding UTF8
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Add auto-run to PowerShell profile
if (!(Test-Path $ProfilePath)) {
    New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
}

$AutoRun = @"
function Prompt {
    python C:\trp\trp.py
    "PS $($executionContext.SessionState.Path.CurrentLocation)> "
}

Register-ArgumentCompleter -CommandName nvim -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    if (Test-Path "$TrpErrors") {
        Get-Content "$TrpErrors" | ForEach-Object { $_ }
    }
}
"@

if (!(Select-String -Path $ProfilePath -Pattern "trp.py")) {
    Add-Content -Path $ProfilePath -Value $AutoRun
}

Write-Host "Installation complete. Restart PowerShell and try 'nvim <TAB>'!"

