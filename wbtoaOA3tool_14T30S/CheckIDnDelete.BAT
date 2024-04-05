@echo off
for /f "tokens=3 delims= " %%a in ('WBTOA64_BG1.exe -ncp -pwmi -pegagood ^| findstr /c:"checksum"') do (set CHKSUM=%%a)
cls
set ID=%CHKSUM:~9,3%

WBTOA64_BG1.exe -ncp -pwmi -ID %ID% -c SLP3 /clear
pause