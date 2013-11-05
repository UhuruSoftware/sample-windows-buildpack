@echo off

set logfile=%~dp0\..\..\logs\stdout.log
set errorlog=%~dp0\..\..\logs\stderr.log

echo "Setting up proper directory in the schedule xml file." >> %logfile%

Get-Content /xml %~dp0\..\schedule.xml | ForEach-Object { $_ -replace "^<Command^>", "^<Command^>%HOME%\" } | Set-Content /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml
Get-Content /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml | ForEach-Object { $_ -replace "^</Command^>", "^</Command^>^<WorkingDirectory^>%HOME%^</WorkingDirectory>^" } | Set-Content /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml

echo "Configuring the scheduled task." >> %logfile%

schtasks /create /ru %VCAP_WINDOWS_USER% /rp %VCAP_WINDOWS_USER_PASSWORD% /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml >> %logfile% 2>> %errorlog%

timeout -1