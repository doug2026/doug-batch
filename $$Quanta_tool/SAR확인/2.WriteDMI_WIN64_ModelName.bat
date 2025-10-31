@ECHO OFF
REM **********************************************************************************************************************
if exist "X:\Windows\System32\startnet.cmd" goto ADMIN
>NUL 2>&1 "%SYSTEMROOT%\SYSTEM32\CACLS.EXE" "%SYSTEMROOT%\SYSTEM32\CONFIG\SYSTEM"
::::: If error flag set, we do not have admin.
IF '%ERRORLEVEL%' EQU '0' GOTO ADMIN
::::: Elevate to Administrator
ECHO SET UAC = CREATEOBJECT^("SHELL.APPLICATION"^) > "%TEMP%\GETADMIN.VBS"
SET PARAMS = %*:"="
ECHO UAC.SHELLEXECUTE "CMD.EXE", "/C %~S0 %PARAMS%", "", "RUNAS", 1 >> "%TEMP%\GETADMIN.VBS"
"%TEMP%\GETADMIN.VBS"
DEL "%TEMP%\GETADMIN.VBS"
EXIT /B
:ADMIN
PUSHD "%CD%"
CD /D "%~DP0"
REM **********************************************************************************************************************
::::: ENTER YOUR CODE BELOW
::LG Model
NB2MFG1.exe /s FCB "G">NUL
echo.
set MODEL=14T90P
for /f "tokens=2 delims==" %%a in ('wmic CSPRODUCT get NAME -value') do ( set NAME=%%a )
echo .Current model name :%NAME%
set /p MODEL=.Please input new name:
echo.
NB2MFG1.exe /s MT "%MODEL%">NUL
timeout -t 1 -nobreak>NUL
echo.
echo Press any key to restart
pause>nul
shutdown -r -t 0
pause>nul
goto :eof