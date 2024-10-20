# Define the Windows API functions to import
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class User32 {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);

        public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern int ShowWindowAsync(IntPtr hWnd, int nCmdShow);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool IsWindowVisible(IntPtr hWnd);

        public const int SW_HIDE = 0; // Hide the window
        public const int SW_MINIMIZE = 6; // Minimize the window
    }
"@

# Define a function to hide or minimize all windows
$EnumFunc = [User32+EnumWindowsProc]{
    param($hWnd, $lParam)

    # Check if the window is visible
    if ([User32]::IsWindowVisible($hWnd)) {
        # Minimize the window
        [User32]::ShowWindowAsync($hWnd, [User32]::SW_MINIMIZE)
    }

    return $true # Continue enumeration
}

# Minimize all windows
[User32]::EnumWindows($EnumFunc, [IntPtr]::Zero)

# Open Task Manager
Start-Process "taskmgr.exe"
