@echo off
setlocal enabledelayedexpansion

rem **********************************************************************************************************************
rem 관리자 권한 확인 및 승격
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

rem **********************************************************************************************************************
echo.
echo Read Model Name
echo.
for /f "tokens=1 delims=" %%a in ('powershell "Get-CimInstance Win32_Computersystem | Select-Object -ExpandProperty model"') do (
    set "Model_Suffix=%%a"
)

echo .Current model name : !Model_Suffix!

rem === 매칭 여부 플래그 초기화 ===
set "Matched=0"

rem === 모델 그룹별 처리 ===
call :CheckModel "!Model_Suffix:~0,6!" "14Z90U 15Z90U" 1415Z90U_PV1rework
call :CheckModel "!Model_Suffix:~0,7!" "14Z90RU 15Z90RU 16Z90RU 17Z90RU" 1xZ90RU_India

rem === 매칭 여부 확인 ===
if "!Matched!"=="1" goto END

echo Not matching !Model_Suffix!
goto END

rem **********************************************************************************************************************
rem === Func: Model check ===
:CheckModel
set "prefix=%~1"
for %%m in (%~2) do (
    if /I "!prefix!"=="%%m" (
        set "Matched=1"
        call :%~3
        exit /b
    )
)
exit /b

rem **********************************************************************************************************************
rem === Func: 1415Z90U ===
:1415Z90U_PV1rework
@echo install image ....
CD .\Image\1415Z90U_26200HO_KR00
dir *.
@call 1415Z90U_26200HO_KR00.bat
CD \
@echo Tesla copy
CD \
@echo Full Flash....
goto END

rem **********************************************************************************************************************
rem === Func: 1xZ90RU ===
:1xZ90RU_India
@echo install image ....
CD .\Image\1xZ90R_26100HO_KRM1
dir *.
@call 1xZ90R_26100HO_KRM1.bat
CD \
@echo Tesla copy
CD \
@echo Full Flash....
goto END

rem **********************************************************************************************************************
:END
endlocal
exit /b