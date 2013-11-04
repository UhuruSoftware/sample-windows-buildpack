@echo off
set app_dir=%1
:: detect if buildpack supports this application

if exist {%app_dir%\schedule.xml} (
    echo "Windows Scheduled Task"
	exit /b 0
) else (
    exit /b 1
)
