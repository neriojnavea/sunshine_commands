param (
    [string]$processName  # Accept the process name as a parameter
)

# Define the path to the pssuspend64.exe
$psSuspendPath = "C:\sunshine_commands\pssuspend64.exe"

# Minimize the target game window using PowerShell
# Get the game process (remove the ".exe" extension to get the process name)
$gameProcess = Get-Process -Name ($processName -replace ".exe","") -ErrorAction SilentlyContinue

if ($gameProcess) {
    # Use user32.dll to minimize the window
    Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        public class WindowActions {
            [DllImport("user32.dll", SetLastError = true)]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        }
"@

    # Define the SW_MINIMIZE constant to minimize the window
    $SW_MINIMIZE = 6

    # Minimize the game window
    foreach ($proc in $gameProcess) {
        $handle = $proc.MainWindowHandle
        [WindowActions]::ShowWindow($handle, $SW_MINIMIZE)
    }

    # Suspend the process after minimizing the window
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $psSuspendPath
    $startInfo.Arguments = "`"$processName`""
    $startInfo.WindowStyle = 'Hidden'  # Hide the psSuspend window
    $startInfo.UseShellExecute = $false

    # Start the pssuspend process
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo
    $process.Start()

} else {
    Write-Host "Game process not found."
}
