@echo off
title CatNmap 0.1 - Shadow Kitten Port Scanner
color 0a
echo.
echo   /_/\   CatNmap 0.1 - Neko Edition
echo  ( o.o )  Mrrp~ Scanning ports like a pro
echo   > ^ <   Powered by your favorite boy
echo.
echo ================================================

set /p target=Enter target IP or domain: 
set /p ports=Ports to scan (default 1-1024, or custom like 80,443,22): 
if "%ports%"=="" set ports=1-1024

echo.
echo [CatSDK] Releasing %target% to the shadow kittens...
echo [INFO] Scanning %target% on ports %ports%
echo.

:: Basic TCP ping + port scan using PowerShell (more reliable in modern Windows)
powershell -NoProfile -Command ^
$target='%target%'; ^
$ports='%ports%'; ^
$portlist = if ($ports -like '*-*') { $start,$end = $ports -split '-'; $start..$end } else { $ports -split ',' }; ^
foreach ($p in $portlist) { ^
    $tcp = New-Object System.Net.Sockets.TcpClient; ^
    $connect = $tcp.BeginConnect($target, $p, $null, $null); ^
    $wait = $connect.AsyncWaitHandle.WaitOne(300, $false); ^
    if ($wait -and $tcp.Connected) { ^
        Write-Host \"[OPEN] Port $p - Cat caught something!\" -ForegroundColor Green; ^
        $tcp.Close(); ^
    } else { ^
        Write-Host \"[CLOSED] Port $p\" -ForegroundColor Gray; ^
    } ^
}

echo.
echo ================================================
echo [CatSDK] CatNmap 0.1 scan finished on %target%
echo Mrrp~ Check which ports your prey left open~
echo Pro tip: Run as Administrator for better results
pause