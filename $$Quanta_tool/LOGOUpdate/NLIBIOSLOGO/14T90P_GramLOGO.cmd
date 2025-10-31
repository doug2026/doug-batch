@ECHO OFF
REM **********************************************************************************************************************
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
Echo.
Echo Write LG LOGO for Quanta ODM Project
Echo.
set LOGO=gram_1920_1200.jpg
Echo.
FPTW64 -f blank.bin -A 0x542000 -L 0x28000 -y
FPTW64 -f %LOGO% -A 0x542000 -L 0x28000 -y
echo.
call lock.bat
FPTW64 -greset
pause>nul
goto :eof