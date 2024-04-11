@echo off

for /f "tokens=3 delims= " %%a in ('WBTOA64_BG1.exe -ncp -pwmi -pegagood ^| findstr /c:"checksum"') do (
    cls
    set CHKSUM=%%a
)

title 0~9th부터 3자리를 ID로 설정한다.
echo %CHKSUM%
set ID=%CHKSUM:~9,3%
echo %ID%

WBTOA64_BG1.exe -ncp -pwmi -ID %ID% -c SLP3 /clear
pause