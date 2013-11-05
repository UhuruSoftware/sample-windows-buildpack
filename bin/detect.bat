@echo off
set app_dir=%1
:: detect if buildpack supports this application

if exist { %app_dir%\index.html } (
    echo "Windows Static HTML"
	exit /b 0
) else (
    exit /b 1
)
