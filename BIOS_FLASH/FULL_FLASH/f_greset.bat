@echo off

cmd /c "pre.bat"
	
rem cmd /c "devcon remove *VID_27C6*PID_6A94*"
rem cmd /c "install_gd.cmd"
rem cmd /c "install.bat"

for /f "tokens=2 delims==" %%i in ('"wmic csproduct get Name /value | findstr /b /c:"Name""') do set PRODUCT=%%i
rem if "%PRODUCT%"=="TigerLake Platform" (
if "%PRODUCT:~-9%"=="Platform" (
  echo Use defulat Product Name
  for /f "tokens=2 delims==" %%i in ('"wmic baseboard get Product /value | findstr /b /c:"Product""') do set PRODUCT=%%i-GPV21KB
)
 
for /f "tokens=2 delims==" %%i in ('"wmic csproduct get IdentifyingNumber /value | findstr /b /c:"IdentifyingNumber""') do set SERIAL=%%i
if "%SERIAL%"=="System Serial Number" (
  echo Use defulat Serial Number
  set SERIAL=1234123412345
)

if exist .\asl.exe .\asl.exe /tab=MSDM /c
if exist .\MSDM0000.BIN ren MSDM0000.BIN Backup_MSDM.bin
rem  IF NOT EXIST Backup_MSDM.bin copy /y .\dm100.bin .\Backup_MSDM.bin

del .\POAT*.BIN
del .\MSDM*.BIN
if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin
rem if exist .\acpidump.exe .\acpidump.exe -b -n MSDM


:GET_MSDM_BEFORE
if exist .\asl.exe .\asl.exe /tab=POAT /c
IF %ERRORLEVEL%==0 (
  ECHO POAT Found !!! keep going without MSDM
  GOTO GET_MSDM_AFTER
) 

if exist .\asl.exe .\asl.exe /tab=MSDM /c
IF NOT %ERRORLEVEL%==0 (
  ECHO GET_MSDM error !!! try again
  GOTO GET_MSDM_BEFORE
) 

for /f "delims=" %%x in ('dir /od /b MSDM*.bin') do set MSDM_NAME=%%~nx
ECHO MSDM file name = %MSDM_NAME%

if exist .\%MSDM_NAME%.BIN ren %MSDM_NAME%.BIN Backup_MSDM.bin


:GET_MSDM_AFTER
if exist .\Backup_MSDM.bin (
  ECHO MSDM Exists !!!
) ELSE (
  ECHO NO MSDM !!!
) 


echo.
echo.
echo BIOS    : %DIR_COPY%
echo PRODUCT : %PRODUCT%
echo SERIAL  : %SERIAL%
echo.
echo.

fptw64.exe -f %1.rom -noverify -y
IF NOT %ERRORLEVEL%==0 (
  GOTO END_FAIL    
)

if exist .\Backup_MSDM.bin (
  ECHO MSDM Exists !!!
  cmd /C "WinFlash64.exe /dps %PRODUCT% /dss %SERIAL% /dus /slp Backup_MSDM.bin /patch /exit /nodelay"
) else (
  ECHO NO MSDM !!!
  cmd /C "WinFlash64.exe /dps %PRODUCT% /dss %SERIAL% /dus /patch /exit /nodelay"
)

IF NOT %ERRORLEVEL%==0 (
  GOTO END_FAIL    
) 

rem cmd /c "ECram.bat"
rem IF NOT %ERRORLEVEL%==0 (
rem   GOTO END_FAIL    
rem ) 

rem del /F/S *
rem rmdir /S/Q FULL_FLASH

if exist .\DM100.bin del .\DM100.bin
if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin

fptw64.exe -greset
IF NOT %ERRORLEVEL%==0 (
  GOTO END_FAIL    
) 

rem SET DIR_COPY2=sxtest
rem cd %userprofile%\desktop\%DIR_COPY2%
rem cmd /c "Enabling_Manual_crash_and_full_dump_UAC_WinXcmd"
rem cmd /c "sxtest_d"
rem cmd /c "s5"

rem SET DIR_COPY3=Pwrtest_20H1
rem cmd /c "xcopy /y /E %~dp0%DIR_COPY3%\* %userprofile%\desktop\%DIR_COPY3%\"
rem cmd /c "s4"
GOTO END

:END_FAIL
if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin
ECHO FAIL !!!
ECHO FAIL !!!
ECHO FAIL !!!

:END
if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin

PAUSE