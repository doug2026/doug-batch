@echo off
setlocal enabledelayedexpansion

rem 관리자 권한 확인
if exist "X:\Windows\System32\startnet.cmd" goto ADMIN
>NUL 2>&1 "%SYSTEMROOT%\SYSTEM32\CACLS.EXE" "%SYSTEMROOT%\SYSTEM32\CONFIG\SYSTEM"
IF '%ERRORLEVEL%' EQU '0' GOTO ADMIN
ECHO SET UAC = CREATEOBJECT^("SHELL.APPLICATION"^) > "%TEMP%\GETADMIN.VBS"
SET PARAMS = %*:"="
ECHO UAC.SHELLEXECUTE "CMD.EXE", "/C %~S0 %PARAMS%", "", "RUNAS", 1 >> "%TEMP%\GETADMIN.VBS"
"%TEMP%\GETADMIN.VBS"
DEL "%TEMP%\GETADMIN.VBS"
EXIT /B

:ADMIN
PUSHD "%CD%"
CD /D "%~DP0"

rem 현재 모델 읽기
for /f "tokens=1 delims=" %%a in ('powershell "Get-CimInstance Win32_Computersystem | Select-Object -ExpandProperty model"') do (
    set "Model_Suffix=%%a"
)
echo .Current model name : !Model_Suffix!

set "Matched=0"
set "MODEL="
set "SKU="

rem CSV 파일에서 매핑 읽기
for /f "tokens=1,2 delims=," %%A in (model_map.csv) do (
    if /I "!Model_Suffix:~0,len=%%A!"=="%%A" (
        set "MODEL=%%A"
        set "SKU=%%B"
        set "Matched=1"
        goto Found
    )
)

:Found
if "!Matched!"=="0" (
    echo .Model name : 예) 14Z90U
    set /p MODEL=.Please input new model name :
    echo .SKU name : 예) GPV01KB
    set /p SKU=.Please input new SKU name :
) else (
    echo .Detected MODEL: !MODEL!
    echo .Detected SKU: !SKU!
)

set /p SERIALNUMBER=.Please input the serial number :

echo.
echo Writing DMI Info...

rem BIOS Version 첫 글자
rem echo .Set 'First Char of BIOS Version' for LG Model . . .
NB2MFG1.exe /s FCB "G"

rem System Information (Type 1) structure
rem echo .Writing System Information (Type 1) Manufacturer . . .
NB2MFG1.exe /s MAF "LG Electronics"
rem echo .Writing System Information (Type 1) Product Name . . .
NB2MFG1.exe /s MT "%MODEL%-%SKU%"
timeout -t 1 -nobreak >nul
rem echo .Writing System Information (Type 1) Version . . .
NB2MFG1.exe /S T2V "FAB1"
rem echo .Writing System Information (Type 1) Serial Number . . .
NB2MFG1.exe /S SN "%SERIALNUMBER%"
rem echo .Writing System Information (Type 1) UUID . . .
rem NB2MFG1.exe /s UU
rem echo .Writing System Information (Type 1) SKU Number . . .
NB2MFG1.exe /S SU1 "BASE"
rem echo .Writing System Information (Type 1) Family . . .
NB2MFG1.exe /S FD "gram"

rem 2. Baseboard (or Module) Information (Type 2)
rem echo .Writing Baseboard (or Module) Product (Type 2) Manufacturer . . .
NB2MFG1.exe /S MBM "LG Electronics"
rem echo .Writing Baseboard (or Module) Information (Type 2) Version . . .
NB2MFG1.exe /S T2V "FAB1"
rem echo .Writing Baseboard (or Module) Information (Type 2) Product . . .
NB2MFG1.exe /S PN2 "%MODEL%"
timeout -t 1 -nobreak >nul

rem 3. System Enclosure or Chassis (Type 3)
rem echo .Writing System Enclosure or Chassis (Type 3) Manufacturer . . .
NB2MFG1.exe /s MCM "LG Electronics"
rem echo .Writing System Enclosure or Chassis (Type 3) Version . . .
NB2MFG1.exe /S T3V "FAB1"

echo.
rem pause
shutdown -r -t 0
goto :eof