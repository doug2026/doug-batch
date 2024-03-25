@echo off

rem cmd /c "Enabling_Manual_crash_and_full_dump_UAC_WinXcmd"

rem cmd /c "devcon remove *VID_27C6*PID_6A94*"
rem cmd /c "install_gd.cmd"
rem cmd /c "install.bat"

for /f "tokens=2 delims==" %%i in ('"wmic csproduct get Name /value | findstr /b /c:"Name""') do set PRODUCT=%%i
if "%PRODUCT%"=="TigerLake Platform" (
  echo Use defulat Product Name
  for /f "tokens=2 delims==" %%i in ('"wmic baseboard get Product /value | findstr /b /c:"Product""') do set PRODUCT=%%i-VPV21KB
)
 
for /f "tokens=2 delims==" %%i in ('"wmic csproduct get IdentifyingNumber /value | findstr /b /c:"IdentifyingNumber""') do set SERIAL=%%i
if "%SERIAL%"=="System Serial Number" (
  echo Use defulat Serial Number
  set SERIAL=1234123412345
)

if exist .\msdm.dat del .\msdm.dat
if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin

for /f "tokens=2 delims==" %%i in ('"wmic path softwarelicensingservice get OA3xOriginalProductKey /value | findstr /b /c:"OA3xOriginalProductKey""') do set OA3X=%%i
if "%OA3X%"=="" (
  echo OA3X is not found
  if exist .\dm100.bin copy /y .\dm100.bin .\Backup_MSDM.bin
) else (
  if exist .\acpidump.exe .\acpidump.exe -b -n MSDM
  if exist .\msdm.dat ren msdm.dat Backup_MSDM.bin
)


echo.
echo.
echo BIOS    : %DIR_COPY%
echo PRODUCT : %PRODUCT%
echo SERIAL  : %SERIAL%
echo OA3x    : %OA3X%
echo.
echo.
rem 
rem fptw64.exe -bios -f %1.rom -noverify -y
rem IF NOT %ERRORLEVEL%==0 (
rem   GOTO END_FAIL    
rem )

fptw64.exe -ec -f %1.rom -noverify -y
IF NOT %ERRORLEVEL%==0 (
  GOTO END_FAIL    
)

rem cmd /C "WinFlash64.exe /dps %PRODUCT% /dss %SERIAL% /dus /slp Backup_MSDM.bin /patch /exit /nodelay"
cmd /C "WinFlash64.exe /dps %PRODUCT% /dss %SERIAL% /dus /patch /exit /nodelay"
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

SET DIR_COPY2=sxtest
cd %userprofile%\desktop\%DIR_COPY2%
rem cmd /c "Enabling_Manual_crash_and_full_dump_UAC_WinXcmd"
rem cmd /c "sxtest_d"
rem cmd /c "s5"

SET DIR_COPY3=Pwrtest_20H1
rem cmd /c "xcopy /y /E %~dp0%DIR_COPY3%\* %userprofile%\desktop\%DIR_COPY3%\"
rem cmd /c "s4"
GOTO END

:END_FAIL
ECHO FAIL !!!
ECHO FAIL !!!
ECHO FAIL !!!

:END

PAUSE