@echo off
setlocal enabledelayedexpansion

SET RETRY_COUNT=20
SET SKU_CMD=

@rem cmd /c "pre.bat"
	
@rem cmd /c "devcon remove *VID_27C6*PID_6A94*"
@rem cmd /c "install_gd.cmd"
@rem cmd /c "install.bat"

@rem for /f "tokens=2 delims==" %%i in ('"wmic csproduct get Name /value | findstr /b /c:"Name""') do set PRODUCT=%%i
for /f "delims=" %%i in ('powershell -ExecutionPolicy Bypass -command "Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty Name"') do set PRODUCT=%%i
@rem if "%PRODUCT%"=="TigerLake Platform" (
if "%PRODUCT:~-8%"=="Platform" (
  echo Use defulat Product Name
@rem  for /f "tokens=2 delims==" %%i in ('"wmic baseboard get Product /value | findstr /b /c:"Product""') do set PRODUCT=%%i-GPV21KB
  for /f %%i in ('powershell -ExecutionPolicy Bypass -command "Get-WmiObject -Class Win32_BaseBoard | Select-Object -ExpandProperty Product"') do set PRODUCT=%%i-GPV21KB
)
 
@rem for /f "tokens=2 delims==" %%i in ('"wmic csproduct get IdentifyingNumber /value | findstr /b /c:"IdentifyingNumber""') do set SERIAL=%%i
for /f "delims=" %%i in ('powershell -ExecutionPolicy Bypass -command "Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty IdentifyingNumber"') do set SERIAL=%%i
if "%SERIAL%"=="System Serial Number" (
  echo Use defulat Serial Number
  set SERIAL=1234123412345
)

@rem for /f "tokens=2 delims==" %%i in ('"wmic computersystem get SystemSKUNumber /value | findstr /b /c:"SystemSKUNumber""') do set SKUNumber=%%i
for /f %%i in ('powershell -ExecutionPolicy Bypass -command "Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty SystemSKUNumber"') do set SKUNumber=%%i
if "%SKUNumber%"=="" (
  echo Use defulat SKU Number
) else (
  echo will set SKU number
  set SKU_CMD=/dks %SKUNumber%
)

del .\POAT*.TXT
del .\POAT*.BIN
del .\MSDM*.TXT
del .\MSDM*.BIN
if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin
rem if exist .\acpidump.exe .\acpidump.exe -b -n MSDM

rem IF NOT EXIST Backup_MSDM.bin copy /y .\dm100.bin .\Backup_MSDM.bin
rem GOTO GET_MSDM_AFTER

:GET_MSDM_BEFORE
SET /A RETRY_COUNT-=1
IF %RETRY_COUNT% LEQ 0 GOTO GET_MSDM_AFTER

IF EXIST "X:\Program Files (x86)" (
  if exist .\asl.exe .\asl.exe /tab=POAT /c  
) ELSE (
  if exist .\acpidump.exe .\acpidump.exe -n POAT > 1&
)

IF %ERRORLEVEL%==0 (
  ECHO POAT Found !!! keep going without MSDM
  GOTO GET_MSDM_AFTER
) 
  
IF EXIST "X:\Program Files (x86)" (
  if exist .\asl.exe .\asl.exe /tab=MSDM /c
rem  if exist .\MSDM0000.BIN ren MSDM0000.BIN Backup_MSDM.bin
  for /f "delims=" %%x in ('dir /od /b MSDM*.bin') do set MSDM_NAME=%%~nx
  ECHO MSDM file name = %MSDM_NAME%
  ren %MSDM_NAME%.BIN Backup_MSDM.bin
) ELSE (
  if exist .\acpidump.exe .\acpidump.exe -b -n MSDM
  if exist .\MSDM.DAT ren MSDM.DAT Backup_MSDM.bin
)

IF NOT EXIST .\Backup_MSDM.bin (
  ECHO GET_MSDM error !!! try again
  GOTO GET_MSDM_BEFORE
)

rem for /f "delims=" %%x in ('dir /od /b MSDM*.bin') do set MSDM_NAME=%%~nx
rem ECHO MSDM file name = %MSDM_NAME%

rem if exist .\%MSDM_NAME%.BIN ren %MSDM_NAME%.BIN Backup_MSDM.bin || GOTO GET_MSDM_BEFORE
rem IF NOT EXIST .\Backup_MSDM.bin GOTO GET_MSDM_BEFORE

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
echo SKU No. : %SKUNumber%
echo.
echo.

ECHO %PRODUCT% > Product.txt
ECHO %SERIAL% > Serial.txt
ECHO %SKUNumber% > Sku.txt

SET ERRORLEVEL=
rem IF NOT DEFINED FLASH_BIOS_ONLY (
rem   fptw64.exe -f %1.rom -noverify -y || GOTO END_FAIL
rem ) ELSE (
rem   fptw64.exe -bios -f %1.rom -noverify -y || GOTO END_FAIL
rem 
rem   fptw64.exe -ec -f %1.rom -noverify -y || GOTO END_FAIL
rem )

rem fptw64.exe -d bios.bin || GOTO END_FAIL

IF [%FLASH_BIOS_ONLY%]==[TRUE] (
  fptw64.exe -bios -f %1.rom -noverify -y || GOTO END_FAIL
  fptw64.exe -ec -f %1.rom -noverify -y || GOTO END_FAIL
) ELSE IF [%FLASH_EC_ONLY%]==[TRUE] (
  fptw64.exe -ec -f %1.rom -noverify -y || GOTO END_FAIL
  fptw64.exe -greset || GOTO END_FAIL
  pause
) ELSE (
  fptw64.exe -f %1.rom -noverify -y || GOTO END_FAIL
)

IF [%NO_DMI%]==[] (
  if exist .\Backup_MSDM.bin (
    ECHO MSDM Exists !!!
    cmd /C "WinFlash64.exe /dps %PRODUCT% /dss %SERIAL% %SKU_CMD% /dus /slp Backup_MSDM.bin /patch /exit /nodelay"
  ) else (
    ECHO NO MSDM !!!
    cmd /C "WinFlash64.exe /dps %PRODUCT% /dss %SERIAL% %SKU_CMD% /dus /patch /exit /nodelay"
  )
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

fptw64.exe -greset || GOTO END_FAIL

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
rem if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin

ECHO FAIL !!!
ECHO FAIL !!!
ECHO FAIL !!!

:END
rem if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin

PAUSE