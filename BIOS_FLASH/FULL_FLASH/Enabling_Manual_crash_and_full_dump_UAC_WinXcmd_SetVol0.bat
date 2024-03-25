@echo Enable manual crash
reg add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters" /v CrashOnCtrlScroll /t REG_DWORD /d 0x1 /f

@echo Enable Full memory dump 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 0x1 /f

@echo Check "Do not remove dump" option
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v AlwaysKeepMemoryDump /t REG_DWORD /d 0x1 /f

@echo Uncheck "Auto reboot after BSOD" option
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /v AutoReboot /t REG_DWORD /d 0x0 /f

@echo Disable UAC
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f

@echo Replace CMD with PowerShell on WIN+X
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v DontUsePowerShellOnWinX /t REG_DWORD /d 1 /f

@echo disable power settings
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
 
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0

powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP UNATTENDSLEEP 0
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP UNATTENDSLEEP 0

@echo Set Volume 0
cmd /c "SetVol.exe 0"