# Set paths to user's home directory instead of C:\
$TrpDir = "$env:USERPROFILE\trp"
$TrpPath = "$TrpDir\trp.py"
$TrpExe = "$TrpDir\trp.bat"
$TrpErrors = "$env:TEMP\trp_errors.txt"
$ProfilePath = $PROFILE
$RepoURL = "https://raw.githubusercontent.com/lamaxko/trp/main/trp.py"

Write-Host "Installing trp..."

# Ensure Python is installed
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: Python is not installed. Install Python and rerun this script."
    exit 1
}

# Ensure trp directory exists in the user's home folder
if (-not (Test-Path $TrpDir)) {
    New-Item -ItemType Directory -Path $TrpDir | Out-Null
}

# Download trp.py from GitHub
Write-Host "Downloading trp.py..."
Invoke-WebRequest -Uri $RepoURL -OutFile $TrpPath

# Create a batch script for easier execution
Set-Content -Path $TrpExe -Value "@echo off`npython `"$TrpPath`" %*" -Encoding UTF8
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Ensure the auto-run function is added to PowerShell profile
if (!(Test-Path $ProfilePath)) {
    New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
}

$AutoRun = @"
# Auto-run trp after every command
function Prompt {
    python $TrpPath
    "PS $($executionContext.SessionState.Path.CurrentLocation)> "
}

# Enable nvim autocompletion using trp errors
Register-ArgumentCompleter -CommandName nvim -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    if (Test-Path "$TrpErrors") {
        Get-Content "$TrpErrors" | ForEach-Object { $_ }
    }
}
"@

if (!(Select-String -Path $ProfilePath -Pattern "trp.py" -Quiet)) {
    Add-Content -Path $ProfilePath -Value $AutoRun
}

Write-Host "Installation complete. Restart PowerShell and try 'nvim <TAB>'!"
