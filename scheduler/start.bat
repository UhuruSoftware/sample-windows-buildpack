:: PORT
:: VCAP_WINDOWS_USER
:: VCAP_WINDOWS_USER_PASSWORD
:: TEMP

Get-Content /xml %~dp0\..\schedule.xml | ForEach-Object { $_ -replace "^<Command^>", "^<Command^>%HOME%\" } | Set-Content /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml
Get-Content /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml | ForEach-Object { $_ -replace "^</Command^>", "^</Command^>^<WorkingDirectory^>%HOME%^</WorkingDirectory>^" } | Set-Content /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml

schtasks /create /ru %VCAP_WINDOWS_USER% /rp %VCAP_WINDOWS_USER_PASSWORD% /xml %~dp0\..\%VCAP_WINDOWS_USER%.xml
