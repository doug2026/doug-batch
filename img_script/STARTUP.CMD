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

echo Current model name : !Model_Suffix!

rem === 매칭 여부 플래그 초기화 ===
set "Matched=0"

rem === 모델 그룹별 처리 ===
call :CheckModel "!Model_Suffix:~0,6!" "14Z90U 15Z90U" 1415Z90U_PV1rework
call :CheckModel "!Model_Suffix:~0,7!" "14Z90RU 15Z90RU 16Z90RU 17Z90RU" 1xZ90RU_India
call :CheckModel "!Model_Suffix:~0,7!" "16Z90TR 17Z90TR" 1xZ90TR
call :CheckModel "!Model_Suffix:~0,6!" "16U50U" 16U50U

rem === 매칭 여부 확인 ===
if "!Matched!"=="1" exit /b

echo !Model_Suffix! is not listed !
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
@call 1415Z90U_26200HO_KR00.bat local
CD \
@echo Tesla copy
CD \
rem echo 원본 경로: %SOURCE%
set "SOURCE=%~dp0##LGTesla_OQA_v2.1"
rem echo 대상 경로: %TARGET%
set "TARGET=C:\##LGTesla_OQA_v2.1"
echo 폴더 복사 중...
XCOPY "%SOURCE%" "%TARGET%" /E /H /C /I /Y
@echo Full Flash....
dir .
rem CD .\$$NLKB_QB116\ME_AND_FPTW
@call fptw.bat
goto END

rem **********************************************************************************************************************
rem === Func: 1xZ90RU ===
:1xZ90RU_India
@echo install image ....
CD .\Image\1xZ90R_26100HO_KRM1
dir *.
@call 1xZ90R_26100HO_KRM1.bat local
CD \
@echo Tesla copy
CD \
@echo Full Flash....
goto END

rem **********************************************************************************************************************
rem === Func: 1xZ90TR_26100PR_KRM3 ===
:1xZ90TR
@echo install image ....
CD .\Image\1xZ90TR_26100PR_KRM3
dir *.
@call 1xZ90TR_26100PR_KRM3.bat local
CD \
@echo Tesla copy
CD \
@echo Full Flash....
goto END

rem **********************************************************************************************************************
rem === Func: 1415Z95U_26100HO_KR03_NEW ===
:16U50U
@echo install image ....
CD .\Image\1415Z95U_26100HO_KR03_NEW
dir *.
@call 1415Z95U_26100HO_KR03.bat local
CD \
@echo Tesla copy
CD \
@echo Full Flash....
CD .\BIOS_update_script\TSL_QB113\WINDOWS
TSL_QB113.EXE
goto END

rem **********************************************************************************************************************
:END
endlocal
exit /b