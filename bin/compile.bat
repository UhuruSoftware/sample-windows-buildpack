@echo off
set build_path=%1
set cache_path=%2
:: do whatever is needed for the application to run
echo Copying buildpack scripts ...
xcopy %~dp0\..\scheduler %build_path% /S /E
exit /b 0