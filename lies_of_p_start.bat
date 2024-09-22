@echo off
REM Define variables for the process name and the game launcher path
SET "PROCESS_NAME=LOP-WinGDK-Shipping.exe"
SET "GAME_LAUNCHER_PATH=C:\XboxGames\Lies of P\Content\gamelaunchhelper.exe"

REM Check if the process is running
for /f "tokens=2" %%a in ('tasklist /FI "IMAGENAME eq %PROCESS_NAME%" /NH') do (
    SET "PID=%%a"
)

IF NOT "%PID%"=="" (
    echo %PROCESS_NAME% is running with PID %PID%.
    echo Attempting to resume the process if it is suspended...
    C:/Windows/system32/pssuspend64.exe -r "%PROCESS_NAME%"
    
    REM Wait for a brief moment to ensure the process resumes
    timeout /T 2 /NOBREAK >NUL

    REM Focus the window using the PID
    nircmd win activate process %PROCESS_NAME%
) ELSE (
    echo %PROCESS_NAME% is not running, launching the game...
    start "" "%GAME_LAUNCHER_PATH%"
)

pause