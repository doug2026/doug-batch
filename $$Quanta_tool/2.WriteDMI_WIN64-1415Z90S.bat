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
::'First Char of BIOS Version' for LG Model
echo .Set 'First Char of BIOS Version' for LG Model . . .
NB2MFG1.exe /s FCB "G"


:: System Information (Type 1) structure

echo.
::System Information (Type 1) Manufacturer
echo .Writing System Information (Type 1) Manufacturer . . .
NB2MFG1.exe /s MAF "LG Electronics"

echo.
::System Information Product Name
echo .Writing System Information (Type 1) Product Name . . .
NB2MFG1.exe /s MT "%MODEL%-%SKU%"
rem NB2MFG1.exe /s MT "14Z90S-GPV01KB"
timeout -t 1 -nobreak>NUL

echo.
::System Information Version
echo .Writing System Information (Type 1) Version . . .
NB2MFG1.exe /S T2V "FAB1"

echo.
::System Information Serial Number
echo .Writing System Information (Type 1) Serial Number . . .
rem NB2MFG1.exe /S SN "1234567890ABCDF"

echo.
::System Information UUID
echo .Writing System Information (Type 1) UUID . . .
rem NB2MFG1.exe /s UU

echo.
::System Information SKU Number
echo .Writing System Information (Type 1) SKU Number . . .
NB2MFG1.exe /S SU1 "EVO"

echo.
::System Information Family
echo .Writing System Information (Type 1) Family . . .
NB2MFG1.exe /S FD "gram PC"


:: 2. Baseboard (or Module) Information (Type 2)

echo.
::Baseboard (or Module) Information (Type 2) Manufacturer
echo .Writing Baseboard (or Module) Product (Type 2) Manufacturer . . .
NB2MFG1.exe /S MBM "LG Electronics"

echo.
::Baseboard (or Module) Product Version
echo .Writing Baseboard (or Module) Information (Type 2) Version . . .
NB2MFG1.exe /S T2V "FAB1"

echo.
::Baseboard (or Module) Product
echo .Writing Baseboard (or Module) Information (Type 2) Product . . .
NB2MFG1.exe /S PN2 "%MODEL%"
timeout -t 1 -nobreak>NUL


:: 3. System Enclosure or Chassis (Type 3)

echo.
::System Enclosure or Chassis (Type 3) Manufacturer
echo .Writing System Enclosure or Chassis (Type 3) Manufacturer . . .
NB2MFG1.exe /s MCM "LG Electronics"

echo.
::System Enclosure or Chassis Revision
echo .Writing System Enclosure or Chassis (Type 3) Version . . .
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