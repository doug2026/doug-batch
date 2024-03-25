@echo off
rem dir *.
rem This is BIOS full flash tool with backup & restore of some parameters.
rem Be carefull if DPK is not saved !!!
SET DIR_COPY=R1ZH0400
SET PRODUCT=
@echo %DIR_COPY%
pause

SET FLASH_TYPE=f_greset.bat

rem SET FLASH_TYPE=f_greset.bat
rem SET FLASH_TYPE=f_greset_dTPM.bat
rem SET FLASH_TYPE=f_greset_DMI.bat

if [%1]==[bios] (
  SET FLASH_TYPE=f_greset_bios_only.bat
  shift
)

if [%1]==[ec] (
  SET FLASH_TYPE=f_greset_ec_only.bat
  shift
)

IF NOT [%1]==[] set DIR_COPY=%1
@echo %DIR_COPY%
pause
goto END

IF [%1]==[1] (
  for /f "delims=" %%x in ('dir /od /ad /b *') do set DIR_COPY=%%x
rem   for /f "delims=" %%x in ('dir /od /ad /b T*ZF*') do set DIR_COPY=%%x
)

cmd /c "xcopy /y %~dp0%DIR_COPY%\* %userprofile%\desktop\%DIR_COPY%\"
cmd /c "copy /y %~dp0FULL_FLASH\* %userprofile%\desktop\%DIR_COPY%\"
rem cmd /c "copy /y %~dp0FULL_FLASH\* %~dp0%DIR_COPY%"
rem cmd /c "copy /y %~dp0FULL_FLASH\ECram\* %~dp0%DIR_COPY%"
rem cmd /c "xcopy /y %~dp0RepeatFlash\* %userprofile%\desktop\%DIR_COPY%\"

rem cmd /c "xcopy /y %~dp0FULL_FLASH\PlatMgr1.2.2010.2402_Signed\* %userprofile%\desktop\%DIR_COPY%\"
rem cmd /c "xcopy /y %~dp0FULL_FLASH\GD-FP188_W106_06_3.4.100.380\* %userprofile%\desktop\%DIR_COPY%\"

rem SET DIR_COPY3=Pwrtest_20H1
rem cmd /c "xcopy /y /E %~dp0%DIR_COPY3%\* %userprofile%\desktop\%DIR_COPY3%\"

rem IF EXIST %userprofile%\desktop\sxtest_fake\count.txt del %userprofile%\desktop\sxtest_fake\count.txt

echo %DIR_COPY%
echo %DIR_COPY%
echo %DIR_COPY%

cd %~dp0FULL_FLASH
for /f "tokens=6 delims== " %%i in ('"wmic cpu get Caption /value | findstr /b /c:"Caption""') do set CPU_GEN=%%i
  IF [%CPU_GEN%]==[141] SET CPU_NAME=TGL
  IF [%CPU_GEN%]==[140] SET CPU_NAME=TGL
  IF [%CPU_GEN%]==[154] SET CPU_NAME=ADL
  IF [%CPU_GEN%]==[156] SET CPU_NAME=JSL
  IF [%CPU_GEN%]==[186] SET CPU_NAME=RPL
IF NOT DEFINED CPU_NAME GOTO FAIL

IF EXIST "X:\Program Files (x86)" GOTO WINPE

C:
GOTO END

:WINPE
cd %~dp0FULL_FLASH\HECI_%CPU_NAME%
cmd /C "drvload heci.inf"

X:
GOTO END


:END
cd %userprofile%\desktop\%DIR_COPY%

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