@echo off
rem **********************************************************************************************************************
if exist "X:\Windows\System32\startnet.cmd" goto ADMIN
>NUL 2>&1 "%SYSTEMROOT%\SYSTEM32\CACLS.EXE" "%SYSTEMROOT%\SYSTEM32\CONFIG\SYSTEM"
::::: If error flag set, we do not have admin.
IF '%ERRORLEVEL%' EQU '0' GOTO ADMIN
::::: Elevate to Administrator
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
::::: ENTER YOUR CODE BELOW
setlocal enabledelayedexpansion
echo.
echo Read Model Name
echo.
for /f "tokens=1 delims=" %%a in ('powershell "Get-CimInstance Win32_Computersystem | Select-Object -ExpandProperty model"') do (
    set "Model_Suffix=%%a"
)

echo .Current model name : !Model_Suffix!
rem set "Model=!Model_Suffix:~0,6!"
rem echo .Current model name : !Model!

rem === Call: Model/Group/Do ===
call :CheckModel "!Model_Suffix:~0,6!" "14Z90U 15Z90U" 1415Z90U_PV1rework
call :CheckModel "!Model_Suffix:~0,7!" "14Z90RU 15Z90RU 16Z90RU 17Z90RU" 1xZ90RU_India

echo Not !Model_Suffix!
goto END

rem === Func: Model check ===
:CheckModel
set "prefix=%~1"
for %%m in (%~2) do (
    if /I "!prefix!"=="%%m" (
        echo !Model_Suffix!
        goto %~3
    )
)
exit /b


:1415Z90U_PV1rework
@echo install image ....
CD .\1415Z90U\PV1st_rework\1415Z90U_26100HO_KR02
dir *.
@call 1415Z90U_26100HO_KR02.bat
rem ECHO la > "W:\Windows\LGPS\lgpslog\LocalAccount.txt"
rem ECHO reboot > "W:\Windows\LGPS\lgpslog\AutoReboot.txt"

CD \

@echo Tesla copy
md W:\1415Z90U_PV1_rework
XCOPY .\1415Z90U\PV1st_rework\rework W:\1415Z90U_PV1_rework /E /I /V

CD \

@echo Full Flash....
CD .\1415Z90U\PV1st_rework\NLKB_QB115\ME_AND_FPTW
@call fptw.bat

goto END


:1xZ90RU_India
@echo install image ....
CD .\Image\1xZ90R_26100PR_KRM1
dir *.
@call 1xZ90R_26100PR_KRM1.bat
rem ECHO la > "W:\Windows\LGPS\lgpslog\LocalAccount.txt"
rem ECHO reboot > "W:\Windows\LGPS\lgpslog\AutoReboot.txt"

CD \

@echo Tesla copy
rem md W:\1415Z90U_PV1_rework
rem XCOPY .\1415Z90U\PV1st_rework\rework W:\1415Z90U_PV1_rework /E /I /V

CD \

@echo Full Flash....
CD .\BIOS_update_script
@call f.bat

goto END

:END
endlocal


rem 
rem Define model groups
rem set "1415Z90U=14Z90U 15Z90U"
rem set "1xZ90RU=14Z90RU 15Z90RU"
rem 
rem Check 1415Z90U
rem for %%m in (%1415Z90U%) do (
rem     if /I "!Model_Suffix:~0,6!"=="%%m" (
rem         echo !Model_Suffix!
rem         goto 1415Z90U_PV1rework
rem     )
rem )
rem 
rem Check 1xZ90RU
rem for %%m in (%1xZ90RU%) do (
rem     if /I "!Model_Suffix:~0,7!"=="%%m" (
rem         echo !Model_Suffix!
rem         goto 1416Z90RU_India
rem     )
rem )
rem 
rem echo Not !Model_Suffix!
rem goto END

rem echo .Check first 6 or 7 characters as model name
rem if /I "!Model_Suffix:~0,6!"=="14Z90U" (
rem     echo !Model_Suffix!
rem     goto 1415Z90U_PV1rework
rem ) else if /I "!Model_Suffix:~0,6!"=="15Z90U" (
rem     echo !Model_Suffix!
rem     goto 1415Z90U_PV1rework
rem ) else if /I "!Model_Suffix:~0,7!"=="14Z90RU" (
rem     echo !Model_Suffix!
rem     goto 1416Z90RU_India
rem ) else if /I "!Model_Suffix:~0,7!"=="15Z90RU" (
rem     echo !Model_Suffix!
rem     goto 1416Z90RU_India
rem ) else (
rem     echo Not !Model_Suffix!
rem     goto END
rem )
rem 