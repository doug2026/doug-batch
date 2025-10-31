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
for /f "skip=1 tokens=1-2 delims= " %%A in  ('Powershell "Get-CimInstance Win32_VideoController | Select-Object -Property  CurrentHorizontalResolution,CurrentVerticalResolution | Format-table"') do (
  set HoriRes=%%A
  set VertRes=%%B
  set Res=%%A_%%B
)

if %Res%==2560_1600 (
  set MODEL=16T90Q
  set LOGO=gram_3840_1600.jpg
)
if %Res%==1920_1200 (
  set MODEL=14T90Q
  set LOGO=gram_1920_1200.jpg
)

echo.
echo Writing DMI for %MODEL%
echo.
::LG Model
echo .Set LG Model
NB2MFG1.exe /s FCB "G"
echo.
::System Manufacturer
echo .Writing manufacturer information . . .
NB2MFG1.exe /s MAF "LG Electronics"
echo.
::Model Name
echo .Writing model name . . .
rem NB2MFG1.exe /s MT "%MODEL%-G.XXXXK"
NB2MFG1.exe /s MT "%MODEL%-XXXXK"
rem NB2MFG1.exe /s SN "LGATFQS18378093"
echo.
::UUID
echo .Writing UUID . . .
NB2MFG1.exe /s UU
echo.
::System SKU No.
echo .Writing SKU number . . .
NB2MFG1.exe /S SU1 " "
echo.
::Family name
echo .Writing System Family . . .
NB2MFG1.exe /S FD "gram360"
echo.
::Baseboard Manufacturer
echo .Writing baseboard manufacturer . . .
NB2MFG1.exe /S MBM "LG Electronics"
echo.
::Baseboard Name
echo .Writing baseboard product name . . .
NB2MFG1.exe /S PN2 "%MODEL%"
timeout -t 1 -nobreak>NUL
echo.
if %MODEL:~0,3%==16T (
  echo .Write flag for 16T90P to assign different SSID for Audio subsystem.
  NB2MFG1.exe /S KB A>NUL
) else (
  NB2MFG1.exe /S KB a>NUL
)
echo.
set FLAG=%~1
if not "%FLAG%"=="" (exit /b)
echo Press any key to exit
pause>nul
shutdown -r -t 0
goto :eof
