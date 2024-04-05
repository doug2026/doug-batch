@ECHO OFF
REM **********************************************************************************************************************
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
REM **********************************************************************************************************************
::::: ENTER YOUR CODE BELOW
if not exist "C:\Tools" (MD C:\Tools)
Xcopy %CD%\Tools C:\Tools /s /r /h /k /y
Echo.
Echo You can remove USB memory...
Echo.
::Copy BurnIn Test and Rebooter Config
if not exist "%userprofile%\Documents\PassMark\BurnInTest" MD %userprofile%\Documents\PassMark\BurnInTest
xcopy C:\Tools\BIT\*.bitcfg %userprofile%\Documents\PassMark\BurnInTest /y
if not exist "%userprofile%\Documents\PassMark\Rebooter" MD %userprofile%\Documents\PassMark\Rebooter
copy C:\Tools\Rebooter\RebooterConfig_C500D60.ini %userprofile%\Documents\PassMark\Rebooter\RebooterConfig.ini /y

::Copy miscellaneous shortcuts to desktop
Xcopy C:\Tools\ShortCut\Stress\*.* %userprofile%\desktop /s /r /h /k /y
Xcopy C:\Tools\ShortCut\ETC\*.* %userprofile%\desktop /s /r /h /k /y
C:
POPD
call C:\Tools\Install_BIT_Heaven.cmd
call C:\Tools\PinCMD2Taskbar.cmd
echo.
exit
