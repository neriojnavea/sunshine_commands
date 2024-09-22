param (
    [string]$processName,
    [string]$gameLauncherPath
)

# Define paths for pssuspend and nircmd
$pssuspendPath = "C:\sunshine_commands\pssuspend64.exe"
$nircmdPath = "C:\sunshine_commands\nircmd.exe"

# Check if the process is running
$process = Get-Process -Name ($processName -replace '.exe$', '') -ErrorAction SilentlyContinue

if ($process) {
    $pid = $process.Id
    Write-Host "$processName is running with PID $pid."
    
    # Attempt to resume the process if it is suspended
    Write-Host "Attempting to resume the process if it is suspended..."
    & $pssuspendPath -r $processName
    
    # Wait for a brief moment to ensure the process resumes
    Start-Sleep -Seconds 2
    
    # Focus the window using the process name
    & $nircmdPath win activate process $processName
} else {
    Write-Host "$processName is not running, launching the game..."
    
    # Start the game
    Start-Process $gameLauncherPath
}
