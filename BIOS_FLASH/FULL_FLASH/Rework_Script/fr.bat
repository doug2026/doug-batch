@echo off

set DPS=TRUE
set DSS=TRUE

for /f %%i in (%~dp0Backup_MODEL.txt) do set MODEL=%%i
if "%MODEL%"=="" set DPS=FALSE

for /f %%i in (%~dp0Backup_SERIAL.txt) do set SERIAL=%%i
if "%SERIAL%"=="" set DSS=FALSE

if "%DPS%"=="TRUE" if "%DSS%"=="TRUE" (
  %~dp0WinFlash64.exe /patch /dus /dps "%MODEL%" /dss "%SERIAL%" /nodelay /exit
  goto DPK
)
if "%DPS%"=="TRUE" (
  %~dp0WinFlash64.exe /patch /dus /dps "%MODEL%" /nodelay /exit
  goto DPK
)
if "%DSS%"=="TRUE" (
  %~dp0WinFlash64.exe /patch /dus /dss "%SERIAL%" /nodelay /exit
  goto DPK
)

:DPK
if not exist %~dp0Backup_MSDM.bin goto QUIT
%~dp0WinFlash64.exe /patch /slp %~dp0Backup_MSDM.bin /nodelay /exit

:QUIT
reg delete HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v BackupDmiDpk /f
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
shutdown -r -t 0
