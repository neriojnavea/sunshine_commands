# Custom Resume-Process function using Windows API
function Resume-Process {
    param([int]$ProcessID)

    $ntdll = Add-Type -Name 'NtDll' -Namespace 'Win32' -MemberDefinition @"
        [DllImport("ntdll.dll", SetLastError = true, ExactSpelling = true)]
        public static extern uint NtResumeProcess(IntPtr processHandle);
"@ -PassThru

    $processHandle = (Get-Process -Id $ProcessID).Handle
    $ntdll::NtResumeProcess($processHandle)
}

# Function to resume Steam and related services
function Resume-SteamServices {
    # Get Steam and its related processes
    $steamProcesses = Get-Process -Name 'Steam', 'steamwebhelper' -ErrorAction SilentlyContinue

    # Resume each process
    foreach ($process in $steamProcesses) {
        Write-Output "Resuming process: $($process.Name) (ID: $($process.Id))"
        Resume-Process -ProcessID $process.Id
    }

    Write-Output "Steam and its services have been resumed."
}

# Run the function
Resume-SteamServices
