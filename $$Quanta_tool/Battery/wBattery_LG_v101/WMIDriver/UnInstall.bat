@echo off

@echo off
if %processor_architecture% == x86   goto E_X86_uninstall
if %processor_architecture% == AMD64 goto E_AMD64_uninstall
if %processor_architecture% == IA64  goto E_AMD64_uninstall

goto unknowm

:E_X86_uninstall
GFNEXSrv.exe -u
Regsvr32 /s /u GFNEX.dll
pGFNEXSrv.exe -u
Regsvr32 /s /u pGFNEX.dll

:E_AMD64_uninstall
echo E_AMD64_uninstall
GFNEXSrv64.exe -u
Regsvr32 /s /u GFNEX.dll
Regsvr32 /s /u GFNEX64.dll
pGFNEXSrv64.exe -u
Regsvr32 /s /u pGFNEX.dll
Regsvr32 /s /u pGFNEX64.dll
goto endd

:unkown
echo unkown

:endd
@echo on
