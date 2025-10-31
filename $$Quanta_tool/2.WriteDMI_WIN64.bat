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
for /f "skip=2 tokens=2-3 delims=," %%A in  ('"wmic path Win32_VideoController  get CurrentHorizontalResolution,CurrentVerticalResolution /format:csv"') do (
  set HoriRes=%%A
  set VertRes=%%B
  set Res=%%A%%B
)
echo.
set MODEL=14T90P
if %Res%==25601600 (set MODEL=16T90Q)
if %Res%==19201200 (set MODEL=14T90Q)
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
set FLAG=%~1
if not "%FLAG%"=="" (exit /b)
echo Press any key to exit
pause>nul
shutdown -r -t 0
goto :eof
