@echo off
pushd %~dp0

set /p var=Enter: 
echo %var%
:: search strings as regular expressions
:: ^[a-z][2,3]$ -> 
:: echo %var% ^| findstr /r "^[a-z][a-z]$ ^[a-z][a-z][a-z]$" > nul 2>&1
echo %var% | findstr /r "^[a-z]{2,3}$" > nul 2>&1
:: ErrorLevel은 cmd 예약어 이며,
:: 어떠한 명령어에 대해서, 
:: 성공했을때에는 0의 값을, 실패했을때에는 1의 값을 반환합니다.
:: ※ findstr has no full REGEX Support.
echo %errorlevel%
if errorlevel 1 (echo does not contain) else (echo contains)
pause

rem call :label
rem echo %errorlevel%
rem pause >nul
rem exit

rem :label
rem exit /b 1

popd

:END