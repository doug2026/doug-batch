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
echo Read Model Name
echo.
for /f "tokens=1 delims=" %%a in ('powershell "Get-CimInstance Win32_Computersystem | Select-Object -ExpandProperty model"') do ( set NAME=%%a )
echo .Current model name :%NAME%
set /p MODEL=.Please input new model name :
echo .SKU name : GPV01KB (KR) or H.APV03KB (US/...)
set /p SKU=.Please input new SKU name :

echo.
echo Writing DMI Info

echo.
::LG Model
echo .Set LG Model . . .
NB2MFG1.exe /s FCB "G"

echo.
::System Manufacturer
echo .Writing manufacturer information . . .
NB2MFG1.exe /s MAF "LG Electronics"

echo.
::Model Name
echo .Writing model name . . .
NB2MFG1.exe /s MT "%MODEL%-%SKU%"
rem NB2MFG1.exe /s MT "14Z90S-GPV01KB"
timeout -t 1 -nobreak>NUL

echo.
::Serial Number
echo .Writing Serial Number . . .
rem NB2MFG1.exe /S SN "1234567890ABCDF"

echo.
::UUID
echo .Writing UUID . . .
rem NB2MFG1.exe /s UU

echo.
::System SKU No.
echo .Writing SKU number . . .
NB2MFG1.exe /S SU1 " "

echo.
::Family name
echo .Writing System Family . . .
NB2MFG1.exe /S FD "gram PC"

echo.
::Baseboard Manufacturer
echo .Writing baseboard manufacturer . . .
NB2MFG1.exe /S MBM "LG Electronics"
NB2MFG1.exe /s MCM "LG Electronics"
echo.
::Baseboard Product Name
echo .Writing baseboard product name . . .
NB2MFG1.exe /S PN2 "%MODEL%"
timeout -t 1 -nobreak>NUL

echo.
::Baseboard Version
echo .Writing baseboard version . . .
NB2MFG1.exe /S T2V "FAB1"
NB2MFG1.exe /S T1V "FAB1"
NB2MFG1.exe /S T3V "FAB1"

rem if %MODEL:~0,3%==16T (
rem  echo .Write flag for 16T90P to assign different SSID for Audio subsystem.
rem   NB2MFG1.exe /S KB A>NUL
rem ) else (
rem   NB2MFG1.exe /S KB a>NUL
rem )

echo.
set FLAG=%~1
if not "%FLAG%"=="" (exit /b)
echo Press any key to exit
pause>nul
rem shutdown -r -t 0
goto :eof
