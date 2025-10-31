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
echo.
echo DMI Writing script for PEGATRON Corp. 2024
echo.
set CMD=%~1
set STR=%~2
if "%CMD%"=="" goto USAGE
if "%STR%"=="" goto USAGE

call :SUB_SETUPIF

:: Writing DMI
echo.
echo ^ Writing DMI
WDMI64-v.321 -WMI -NOMSG %CMD% %STR%

call :SUB_DELIF
echo.
echo ^ Completed
echo.
echo ^ Press any key to restart
pause>NUL
shutdown -r -t 0
goto :eof

:::::::::::::::::::::::::::::::
:SUB_SETUPIF
:::::::::::::::::::::::::::::::
echo.
echo ^ Setup Interface in advance
PGFNEXSRV64.EXE -i
REGSVR32 /S /I PGFNEX64.dll
:: Start TDEIO
SC STOP TDEIO>NUL
SC DELETE TDEIO>NUL
SC CREATE TDEIO BINPATH=%CD%\TDEIO.SYS TYPE=KERNEL>NUL
SC START TDEIO>NUL
EXIT /B

:::::::::::::::::::::::::::
:SUB_DELIF
:::::::::::::::::::::::::::
echo.
echo ^ Delete Interface
PGFNEXSRV64.EXE -U
REGSVR32 /S /U PGFNEX64.dll
SC STOP TDEIO>NUL
timeout -t 1 -nobreak>NUL
SC DELETE TDEIO>NUL
EXIT /B

:::::::::::::::::::::::::::::::
:USAGE
:::::::::::::::::::::::::::::::
echo.
echo ^ [Usage]
echo.
echo ^ WDMI64_LG24H2 /Command "string"
echo.
echo ^ - Command -
echo.
echo ^ /SM : Type 1 Manufacturer
echo ^ /SP : Type 1 Product Name
echo ^ /SS : Type 1 Serial Number
echo ^ /SK : Type 1 SKU Number
echo ^ /SF : Type 1 Family Name
echo ^ /BM : Type 2 Baseboard Manufacturer
echo ^ /BP : Type 2 Baseboard Product Name
echo.
goto :eof
