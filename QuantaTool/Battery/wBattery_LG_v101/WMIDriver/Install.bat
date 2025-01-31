@echo off
if %processor_architecture% == x86   goto E_X86_install
if %processor_architecture% == AMD64 goto E_AMD64_install
if %processor_architecture% == IA64  goto E_AMD64_install

goto unknowm

:E_X86_install
echo E_X86_install
PGFNEXSrv.exe -u
Regsvr32 /s /i PGFNEX.dll
PGFNEXSrv.exe -i
goto endd

:E_AMD64_install
echo E_AMD64_install
PGFNEXSrv64.exe -u
PGFNEXSrv64.exe -i
Regsvr32 /s /i PGFNEX.dll
Regsvr32 /s /i PGFNEX64.dll
goto endd

:unkown
echo unkown

:endd
@echo on