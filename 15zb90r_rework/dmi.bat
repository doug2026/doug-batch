@echo off

Set CLR_DISK=CLEANDISK.txt

wmic diskdrive where (mediatype like 'fixed hard disk media%%') get index |find /i "1"
if not %errorlevel%==0 (
  echo.
  goto ONE_DISK
) else (
  goto TWO_DISK
)

:ONE_DISK
echo select disk 0 > %CLR_DISK%
echo Clean >> %CLR_DISK%
echo list disk >> %CLR_DISK%
echo exit >> %CLR_DISK%
DISKPART /s %CLR_DISK%
goto END

:TWO_DISK
echo select disk 0 > %CLR_DISK%
echo Clean >> %CLR_DISK%
echo select disk 1 >> %CLR_DISK%
echo Clean >> %CLR_DISK%
echo list disk >> %CLR_DISK%
echo exit >> %CLR_DISK%
DISKPART /s %CLR_DISK%
goto END

:END
IF EXIST %CLR_DISK% DEL %CLR_DISK%

WinFlash64.exe /dps 15ZB90R-GP5ZL /bcp RegularBcp.evs /patch /nodelay
