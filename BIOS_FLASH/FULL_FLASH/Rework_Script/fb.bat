@echo off

if exist .\Backup_MODEL.txt del .\Backup_MODEL.txt
for /f "tokens=2 delims==" %%i in ('"wmic csproduct get Name /value | findstr /b /c:"Name""') do set MODEL=%%i
if not "%MODEL%"=="" echo %MODEL%> Backup_MODEL.txt

if exist .\Backup_SERIAL.txt del .\Backup_SERIAL.txt
for /f "tokens=2 delims==" %%i in ('"wmic csproduct get IdentifyingNumber /value | findstr /b /c:"IdentifyingNumber""') do set SERIAL=%%i
if not "%SERIAL%"=="" echo %SERIAL%> Backup_SERIAL.txt

if exist .\Backup_OA3x.txt del .\Backup_OA3x.txt
for /f "tokens=2 delims==" %%i in ('"wmic path softwarelicensingservice get OA3xOriginalProductKey /value | findstr /b /c:"OA3xOriginalProductKey""') do set OA3X=%%i
if not "%OA3X%"=="" echo %OA3X%> Backup_OA3x.txt

echo MODEL  : %MODEL%
echo SERIAL : %SERIAL%
echo OA3x   : %OA3X%

if exist .\msdm.dat del .\msdm.dat
if exist .\Backup_MSDM.bin del .\Backup_MSDM.bin
if exist .\acpidump.exe .\acpidump.exe -b -n MSDM
if exist .\msdm.dat ren msdm.dat Backup_MSDM.bin

if not exist .\f.bat goto :eof
call f.bat
if %errorlevel%==0 (
  reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
  reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v BackupDmiDpk /t REG_SZ /d "%~dp0fr.bat"
  fptw64.exe -greset
)