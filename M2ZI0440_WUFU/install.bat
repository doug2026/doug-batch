@echo off

for /f  %%i in ('"dir /b *.inf"') do set INF_FILE=%%i
echo Installing %INF_FILE%

pause

::pnputil -i -a %INF_FILE%
