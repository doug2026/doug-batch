@echo off

::
:: Initialize variables
::

set PWD=%cd%
set CWD=%~dp0
set BIOS_VERSION=%~1
set CAPSULE_GUID=%~2
set MODULE_LGE_DIR=%~3

set BUILD_BIN_DIR=%BUILD_DIR%_BIN
set TOOLS_PATH=%MODULE_LGE_DIR%\Tools
set KEYS_DIR=%MODULE_LGE_DIR%\XnoteSystemBinPkg\XnoteKeys

REM setlocal
REM FOR %%i IN (%MODULE_LGE_DIR%) DO (
REM ECHO filedrive=%%~di
REM ECHO filepath=%%~pi
REM ECHO filename=%%~ni
REM ECHO fileextension=%%~xi
REM )
REM endlocal

for %%i in ("%MODULE_LGE_DIR%") do set SCT_VERSION=%%~ni

REM echo PROJECT_WORKING_DIR=%PWD%
REM echo CURRENT_WORKING_DIR=%CWD%
cd %CWD%


::
:: Remove the header from the capsule file
::

if exist CapHeader.bin del /q CapHeader.bin
if exist SigFvCap.bin del /q SigFvCap.bin

%TOOLS_PATH%\Split.exe -f BIOS.Cap -s 80 -o CapHeader.bin -t SigFvCap.bin


::
:: Gather needed information from the capsule file
::

if exist CapsuleInfo.txt del /q CapsuleInfo.txt
%TOOLS_PATH%\WinWufuVer32.exe /file SigFvCap.bin > CapsuleInfo.txt

for /f "tokens=4,* delims= " %%i in ('"type CapsuleInfo.txt|find "Build Date""') do set build_date=%%i
for /f "tokens=4,* delims= " %%i in ('"type CapsuleInfo.txt|find "Build Version""') do set firmware_version=%%i

set firmware_version=0x%firmware_version%


::
:: Get BIOS version number and remove leading 0s
::

set bios_version1=%build_date:~8,2%%build_date:~0,2%
for /f "tokens=* delims=0" %%i in ("%bios_version1%") do set bios_version1=%%i

set bios_version2=%BIOS_VERSION:~4,4%
for /f "tokens=* delims=0" %%i in ("%bios_version2%") do set bios_version2=%%i

echo BIOS Ver.  : %bios_version2%
echo Build Date : %build_date%
echo FW Version : %firmware_version%
echo.


::
:: Create INF file (wufu.inf) using the template (wufu.txt)
::

if exist wufu.inf del /q wufu.inf

for /f "eol= tokens=1,* delims=:" %%i in ('type wufu.txt ^| findstr /n "^"') do (
  set "line=%%j"
  setlocal enabledelayedexpansion
  set "line=!line:#BIOS_VERSION1#=%bios_version1%!"
  set "line=!line:#BIOS_VERSION2#=%bios_version2%!"
  set "line=!line:#BUILD_DATE#=%build_date%!"
  set "line=!line:#CAPSULE_GUID#=%CAPSULE_GUID%!"
  set "line=!line:#FIRMWARE_VERSION#=%firmware_version%!"
  if "!line!"=="" (echo.) else (echo.!line!) >> wufu.inf
  endlocal
)


::
:: Create the catalog
::

if not exist SCT%SCT_VERSION%_wufu.inf mkdir SCT%SCT_VERSION%_wufu.inf

copy /y SigFvCap.bin SCT%SCT_VERSION%_wufu.inf\
copy /y wufu.inf SCT%SCT_VERSION%_wufu.inf\
rem copy /y %KEYS_DIR%\Capsule\lgecodesigning_2023_2026.pfx SCT%SCT_VERSION%_wufu.inf\

@echo on
%TOOLS_PATH%\Inf2Cat.exe /driver:"SCT%SCT_VERSION%_wufu.inf" /uselocaltime /os:10_X64
if not exist SCT%SCT_VERSION%_wufu.inf\catalog.cat goto EXIT
call %TOOLS_PATH%\SignCat.bat SCT%SCT_VERSION%_wufu.inf\catalog.cat
@echo off


::
:: Create cabinet file
::

if not exist x64 mkdir x64

copy /y SCT%SCT_VERSION%_wufu.inf\catalog.cat x64\
copy /y SCT%SCT_VERSION%_wufu.inf\SigFvCap.bin x64\
copy /y SCT%SCT_VERSION%_wufu.inf\wufu.inf x64\
copy /y %TOOLS_PATH%\install.bat x64\

%TOOLS_PATH%\Cabarc.exe -p -r N %BIOS_VERSION%_WUFU.cab x64\*


::
:: Copy cabinet file
::

if exist %BIOS_VERSION%_WUFU.cab copy /y %BIOS_VERSION%_WUFU.cab %BUILD_BIN_DIR%\%BIOS_VERSION%


:EXIT
cd %PWD%
