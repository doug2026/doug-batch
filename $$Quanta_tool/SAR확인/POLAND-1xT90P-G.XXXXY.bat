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
set MODEL=1xT90P
if %Res%==25601600 (set MODEL_BASE=16T90P)
if %Res%==19201200 (set MODEL_BASE=14T90P)
rem ::LG Model
rem NB2MFG1.exe /s FCB "G">NUL
echo.
set MODEL=%MODEL_BASE%-G.XXXXY
NB2MFG1.exe /s MT "%MODEL%"
timeout -t 1 -nobreak>NUL
echo.
echo Press any key to restart
pause>nul
shutdown -r -t 0
pause>nul
goto :eof