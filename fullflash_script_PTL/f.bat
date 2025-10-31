@echo off

IF EXIST "X:\Program Files (x86)" GOTO START_F
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:START_F

SET DIR_COPY=P2ZK1220_PreProd
SET PRODUCT=

SET FLASH_TYPE=f_greset.bat
SET FLASH_BIOS_ONLY=
SET FLASH_EC_ONLY=
SET NO_DMI=

if [%1]==[bios] (
rem  SET FLASH_TYPE=f_greset_bios_only.bat
  SET FLASH_BIOS_ONLY=TRUE
  shift
)

if [%1]==[ec] (
rem  SET FLASH_TYPE=f_greset_ec_only.bat
  SET FLASH_EC_ONLY=TRUE
  shift
)

if [%1]==[nodmi] (
rem  SET FLASH_TYPE=f_greset_ec_only.bat
  SET NO_DMI=TRUE
  shift
)

IF NOT [%1]==[] set DIR_COPY=%1
IF [%1]==[1] (
  for /f "delims=" %%x in ('dir /od /ad /b *') do set DIR_COPY=%%x
rem   for /f "delims=" %%x in ('dir /od /ad /b T*ZF*') do set DIR_COPY=%%x
)

CMD /c "xcopy /y %~dp0%DIR_COPY%\* "%userprofile%\%DIR_COPY%\""
CMD /c "copy /y %~dp0FULL_FLASH\* "%userprofile%\%DIR_COPY%\""
rem cmd /c "copy /y %~dp0FULL_FLASH\* %~dp0%DIR_COPY%"
rem cmd /c "copy /y %~dp0FULL_FLASH\ECram\* %~dp0%DIR_COPY%"
rem cmd /c "xcopy /y %~dp0RepeatFlash\* %userprofile%\desktop\%DIR_COPY%\"

rem cmd /c "xcopy /y %~dp0FULL_FLASH\PlatMgr1.2.2010.2402_Signed\* %userprofile%\desktop\%DIR_COPY%\"
rem cmd /c "xcopy /y %~dp0FULL_FLASH\GD-FP188_W106_06_3.4.100.380\* %userprofile%\desktop\%DIR_COPY%\"

rem SET DIR_COPY3=Pwrtest_20H1
rem cmd /c "xcopy /y /E %~dp0%DIR_COPY3%\* %userprofile%\desktop\%DIR_COPY3%\"

rem IF EXIST %userprofile%\desktop\sxtest_fake\count.txt del %userprofile%\desktop\sxtest_fake\count.txt

for %%a in ("%DIR_COPY%") do set FILE_DATE=%%~ta
echo %DIR_COPY% : %FILE_DATE%
echo %DIR_COPY% : %FILE_DATE%
echo %DIR_COPY% : %FILE_DATE%

rem BSK - get CPU ID to use proper FPTW64.bat
cd %~dp0FULL_FLASH
IF EXIST "X:\Program Files (x86)" GOTO WINPE

C:
GOTO END

:WINPE
call "Get_CPU_Name.bat"
IF NOT DEFINED CPU_NAME GOTO FAIL

pushd
cd HECI_driver\HECI_%CPU_NAME%
rem cmd /C "drvload heci.inf" || GOTO FAIL
cmd /C "drvload heci.inf" 

X:
GOTO END


:END
cd "%userprofile%\%DIR_COPY%"

rem cmd /c "f_greset_bios_only.bat %DIR_COPY%"
rem cmd /c "f_greset.bat %DIR_COPY%"
rem cmd /c "f_greset_bios_only.bat %DIR_COPY%"
rem cmd /c "RepeatFlash_reg.bat"
rem cmd /c "fb.bat"

rem cmd /c "Enabling_Manual_crash_and_full_dump_UAC_WinXcmd_SetVol0"
cmd /c "%FLASH_TYPE% %DIR_COPY%"


pushd %~dp0


:FAIL
echo %CPU_GEN%
echo %CPU_NAME%
echo BSK - FAIL !!!
echo BSK - FAIL !!!
echo BSK - FAIL !!!