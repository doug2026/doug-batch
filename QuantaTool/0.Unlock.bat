@ECHO OFF
REM **********************************************************************************************************************
If exist "X:\Windows\System32" goto :ADMIN
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
::Unlock before writing LG LOGO
echo.
echo unlock before system update . . .
echo.
>NUL 2>&1 start /b /w NB2MFG1.exe /S SFD ON
shutdown /r /t 0