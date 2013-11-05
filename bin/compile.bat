@echo off
set build_path=%1
set cache_path=%2
:: do whatever is needed for the application to run
echo Copying buildpack scripts ...
mkdir %build_path%\scheduler
xcopy %~dp0\..\scheduler %build_path%\scheduler\ /E
echo Done.
exit /b 0
