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
Echo.
rem Identifying target model information
for /f "tokens=2 delims==" %%a in ('wmic baseboard get PRODUCT -value') do (set targetMDL=%%a)
set targetMDL=%targetMDL: =%
rem goto FLASH_LOGO
NB2MFG1 /R SFD | FIND /I "">NUL
if %errorlevel%==0 goto FLASH_LOGO
echo.

echo Run unlock first before system update . . .
echo.
rem echo Press any key to run unlock . . .
rem echo.
rem pause>nul
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v LGLOGO /t REG_SZ /d "%CD%"\1.WriteLGLOGO.cmd /f > NUL
timeout -t 1 -nobreak>NUL
start /b /w NB2MFG1.exe /S SFD ON
timeout -t 1 -nobreak>NUL
shutdown -r -t 0
goto :eof

:FLASH_LOGO
echo.
Echo Write LG LOGO for Quanta ODM Project
set DEFAULT_LOGO=GRAM_1920_1200.jpg
for /f "skip=2 tokens=2-3 delims=," %%A in  ('"wmic path Win32_VideoController  get CurrentHorizontalResolution,CurrentVerticalResolution /format:csv"') do (
  set HoriRes=%%A
  set VertRes=%%B
  set Res=%%A%%B
)
echo LCD Resolution : %HoriRes% * %VertRes%
timeout -t 1 -nobreak>NUL
echo.
set LOGO=%DEFAULT_LOGO%
if %Res%==25601600 (set LOGO=GRAM_3840_1600.jpg)
if %Res%==19201200 (set LOGO=GRAM_1920_1200.jpg)
if %Res%==19201080 (set LOGO=GRAM_1920_1080.jpg)
if %Res%==1366768  (set LOGO=GRAM_1366_768.jpg)
rem if %Res%==25601600 (set LOGO=LG_3840_1600.jpg)
rem if %Res%==19201200 (set LOGO=LG_1920_1200.jpg)
rem if %Res%==19201080 (set LOGO=LG_1920_1080.jpg)
rem if %Res%==1366768  (set LOGO=LG_1366_768.jpg)

echo.
echo Flash LG LOGO image . . . %LOGO%
pause
echo.
if "%targetMDL:~-4%"=="T90P" goto T90P
if "%targetMDL:~-4%"=="T90Q" goto T90Q
if "%targetMDL:~-4%"=="T90R" goto T90R
if "%targetMDL:~-4%"=="Z90S" goto Z90S
echo.
echo ERROR : Target model information is wrong
echo Press any key exit
pause>NUL
goto :eof

:T90Q
:T90R
:Z90S
AFUWINx64.EXE BLANK.bin /k2 /jbc
AFUWINx64.EXE %LOGO% /k2 /jbc
goto SFD_OFF

:T90P
FPTW64 -f blank.bin -A 0x542000 -L 0x28000 -y
FPTW64 -f %LOGO% -A 0x542000 -L 0x28000 -y

:SFD_OFF
::lock system update
start /b /w NB2MFG1.exe /S SFD OFF
timeout -t 1 -nobreak>NUL
FPTW64 -greset
pause>nul
goto :eof