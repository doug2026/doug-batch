@ECHO OFF
REM **********************************************************************************************************************
IF EXIST "X:\Windows\system32\startnet.cmd" goto ADMIN
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

set BIN=NLK_18.0.5.2028_FWUpdate.bin

FWUpdLcl64.exe -f %BIN% -allowsv
timeout /t 5
FPTW64.exe -greset