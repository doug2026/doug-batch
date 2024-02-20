@REM Studying batch programming

@echo off

goto todayStudy

for /f "tokens=3" %%a in ('type test.log') do (
	echo %%a
)

for /f "tokens=4 delims='=/'" %%a in ('type test.log') do (
	echo %%a
)

:: 문자열을 출력
for %%c in (miku daisuki) do (
	echo %%c
)

:: 현재 Directory의 파일 목록 출력
for %%d in (*) do (
	echo %%d
)

:: 현재 Directory의 파일 목록 출력
for %%d in (* miku daisuki) do (
	echo %%d
)

:: 특수한 옵션
for %%d in (1;2 3,4) do (
	echo %%d
)

:: 시작과 끝
for /L %%a in (1,2,100) do echo %%a

pause > nul

:: for /r c:\ %%a in (*.mp4 *.avi) do echo %%a
pause

for /d %%a in (*) do echo %%a

for /f "delims=: tokens=1,2" %%a in ("hello:world") do echo %%a-%%b

for /f "skip=15 delims='#' tokens=1" %%a in (c:\Windows\System32\drivers\etc\hosts) do echo %%a
for /f "skip=15 delims= tokens=1" %%a in (c:\Windows\System32\drivers\etc\hosts) do echo %%a

@REM Commenting multiple lines in DOS batch file
@REM Ctrl-Q

:todayStudy

::echo.This is batch programming sample.

::Goto the location in the script
pushd %~dp0

echo.LCD Firmware update tool 2024/02/20
echo.
for /f "tokens=2 delims=\" %%a in ('wmic desktopmonitor get PNPDeviceID -value') do (
	set PnPID=%%a
)
echo.
echo.PnPID:%PnPID%

if %PnPID% == LGD0755 goto LCD16_Z90R_VRR
if %PnPID% == LGD0756 goto LCD17_Z90R_VRR
goto failToFinePanel

:LCD16_Z90R_VRR
goto END

:LCD16_Z90R_VRR
echo.LCD 16 Model (VRR)
:: ...
:: ...
:: ...
goto END

:LCD17_Z90R_VRR
echo.LCD 17 Model (VRR)
:: ...
:: ...
:: ...
goto END

:failToFinePanel
echo *** ERROR : No proper LCD found ****


:END
