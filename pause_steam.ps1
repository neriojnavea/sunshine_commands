# Custom Suspend-Process function using Windows API
function Suspend-Process {
    param([int]$ProcessID)

    $ntdll = Add-Type -Name 'NtDll' -Namespace 'Win32' -MemberDefinition @"
        [DllImport("ntdll.dll", SetLastError = true, ExactSpelling = true)]
        public static extern uint NtSuspendProcess(IntPtr processHandle);
"@ -PassThru

    $processHandle = (Get-Process -Id $ProcessID).Handle
    $ntdll::NtSuspendProcess($processHandle)
}

# Function to suspend Steam and related services
function Suspend-SteamServices {
    # Get Steam and its related processes (Steam.exe and SteamWebHelper.exe)
    $steamProcesses = Get-Process -Name 'Steam', 'steamwebhelper' -ErrorAction SilentlyContinue

    # Suspend each process
    foreach ($process in $steamProcesses) {
        Write-Output "Suspending process: $($process.Name) (ID: $($process.Id))"
        Suspend-Process -ProcessID $process.Id
    }

    Write-Output "Steam and its services have been suspended."
}

# Run the function
Suspend-SteamServices
