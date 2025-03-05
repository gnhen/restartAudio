@echo off
:: Check for admin rights; if not, relaunch with elevation
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~0' -Verb runAs"
    exit /b
)

:: Restart audio services once admin rights are confirmed
net stop AudioEndpointBuilder /y
net stop Audiosrv /y
net start Audiosrv /y
net start AudioEndpointBuilder /y

echo Audio Restart Complete
pause
