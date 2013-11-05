@echo off

echo "Starting a simple powershell webserver ..."

powershell -ExecutionPolicy bypass -File %~dp0\webserver.ps1