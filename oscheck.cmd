echo OFF

reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

if %OS%==32BIT echo This is a 32bit operating system
if %OS%==64BIT echo This is a 64bit operating system

:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
echo 64-bit...
GOTO END

:32BIT
echo 32-bit...
GOTO END

:END

@echo off
echo Detecting OS processor type

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto 64BIT
echo 32-bit OS
\\savdaldpm01\ProtectionAgents\RA\3.0.7558.0\i386\DPMAgentInstaller_x86 /q
goto END
:64BIT
echo 64-bit OS
\\savdaldpm01\ProtectionAgents\RA\3.0.7558.0\amd64\DPMAgentInstaller_x64 /q
:END

"C:\Program Files\Microsoft Data Protection Manager\DPM\bin\setdpmserver.exe" -dpmservername sa