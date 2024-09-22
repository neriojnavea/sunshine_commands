# Game Process Manager Script

This PowerShell script allows you to manage a game's process by resuming it if it's suspended or launching it if it's not running. The script checks for the presence of a running process (such as a game), resumes it if it's suspended, and focuses the game's window. If the process is not found, it launches the game using the specified launcher path.

## Features

- Check if a game process is running.
- Resume the process if it is suspended.
- Focus the game's window if it is already running.
- Launch the game if the process is not running.

## Prerequisites

- PowerShell (built-in on Windows)
- [PsSuspend](https://docs.microsoft.com/en-us/sysinternals/downloads/pssuspend) utility
- [NirCmd](https://www.nirsoft.net/utils/nircmd.html) utility

### Required Utilities

- **PsSuspend**: Used to suspend or resume a process. Place the `pssuspend64.exe` file in the `C:\sunshine_commands\` folder or update the script with your own path.
- **NirCmd**: A command-line utility to perform tasks like focusing windows. Place the `nircmd.exe` file in the `C:\sunshine_commands\` folder or update the script with your own path.

## Script Usage

### Parameters

The script takes two parameters:
- `-processName`: The name of the game's process (e.g., `Blasphemous 2.exe`).
- `-gameLauncherPath`: The full path to the game's launcher executable.

### Example

To use the script, run it from PowerShell with the following command:

```powershell
powershell -ExecutionPolicy Bypass -File "C:\sunshine_commands\start_game.ps1" -processName "Blasphemous 2.exe" -gameLauncherPath "C:\Games\Blasphemous 2\Blasphemous 2.exe"