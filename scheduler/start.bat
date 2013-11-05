@echo off

echo "Setting up proper directory in the schedule xml file."

powershell "Get-Content '%~dp0\..\schedule.xml' | ForEach-Object { $_ -replace '^<Command^>', '^<Command^>%HOME%\' } | Set-Content '%~dp0\..\%VCAP_WINDOWS_USER%.aux'"
powershell "Get-Content '%~dp0\..\%VCAP_WINDOWS_USER%.aux' | ForEach-Object { $_ -replace '^</Command^>', '^</Command^>^<WorkingDirectory^>%HOME%^</WorkingDirectory>^' } | Set-Content '%~dp0\..\%VCAP_WINDOWS_USER%.xml'"
del "%~dp0\..\%VCAP_WINDOWS_USER%.aux"

echo "Configuring the scheduled task."

schtasks /create /ru %VCAP_WINDOWS_USER% /rp %VCAP_WINDOWS_USER_PASSWORD% /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml /tn %VCAP_WINDOWS_USER%

timeout -1