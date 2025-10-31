@echo OFF
@REM for /f "tokens=6 delims== " %%i in ('"wmic cpu get Caption /value | find "Caption""') do set CPU_GEN=%%i

for /f "tokens=*" %%i in ('"powershell -ExecutionPolicy Bypass -command (Get-WmiObject -Class Win32_Processor).Caption"') do set CPU_INFO=%%i
@ECHO CPU_INFO: %CPU_INFO%

for /f "tokens=5 delims== " %%i in ('"echo %CPU_INFO%"') do set CPU_GEN=%%i
@ECHO CPU_GEN: %CPU_GEN%

IF [%CPU_GEN%]==[141] SET CPU_NAME=TGL
IF [%CPU_GEN%]==[140] SET CPU_NAME=TGL
IF [%CPU_GEN%]==[154] SET CPU_NAME=ADL
IF [%CPU_GEN%]==[156] SET CPU_NAME=JSL
IF [%CPU_GEN%]==[186] SET CPU_NAME=RPL
IF [%CPU_GEN%]==[170] SET CPU_NAME=MTL
IF [%CPU_GEN%]==[189] SET CPU_NAME=LNL
IF [%CPU_GEN%]==[197] SET CPU_NAME=ARL
IF [%CPU_GEN%]==[204] SET CPU_NAME=PTL

@echo CPU_NAME: %CPU_NAME%
