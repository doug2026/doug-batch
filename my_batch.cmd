@REM Studying batch programming

@echo off

goto todayStudy

:: ���ڿ��� ���(���ڿ��� Space�� ���е�)
for %%c in (miku daisuki) do (
	echo %%c
)

:: ���� Directory�� ���� ��� ���
for %%d in (*) do (
	echo %%d
)

:: ���� Directory�� ���� ��ϰ� String ���
for %%d in (* miku daisuki) do (
	echo %%d
)

:: Ư���� �ɼ�(Ư�� ����, Space�� ���е�)
for %%d in (1;2 3,4) do (
	echo %%d
)

:: pause with no message
pause > nul

:: for /r c:\ %%a in (*.mp4 *.avi) do echo %%a
pause

:: /d (/D) : Directory for
for /d %%a in (*) do echo %%a

:: ���� For - ���۰� ��(Start,Delta,End)
for /L %%a in (1,3,100) do echo %%a

:: /r (/R) : Recursive for
for /r d:\ %%a in (*.tx0, *.mp4) do echo %%a

:: /f (/F) : File for
:: tokens : �����ڷ� �������� ���� ���� ��ū�̶� �Ѵ�.
:: delims(delimeters) : ���ڿ��� ������ ��ȣ ����, ������ ����(�����̽�, ��)���� ������.
:: skip :
:: eol :
:: usebackq :
for /f "tokens=3" %%a in ('type test.log') do (
	echo %%a
)

for /f "tokens=4 delims='=/'" %%a in ('type test.log') do (
	echo %%a
)

for /f "delims=: tokens=1,2,3" %%a in ("hello:world!:this is doug.") do echo %%a - %%b - %%c


type c:\Windows\System32\drivers\etc\hosts
pause
:: 15 lines�� skip�ϰ� #�� ���е� ù��° String�� ǥ���϶�.
for /f "skip=15 delims='#' tokens=1" %%a in (c:\Windows\System32\drivers\etc\hosts) do echo %%a
:: 15 lines�� skip�ϰ� �����ڰ� �����Ƿ� �� ���� ��ä�� ��ū�� �Ǿ %%a�� �����ȴ�.
for /f "skip=15 delims= tokens=1" %%a in (c:\Windows\System32\drivers\etc\hosts) do echo %%a

@REM Commenting multiple lines in DOS batch file
@REM Ctrl-Q


:todayStudy

::echo.This is batch programming sample.

:: git command
:: git clone

:: git ddd .
:: git commit -m "This is ..."
:: git push -u origin main

:: git pull origin main
:: git fetch origin

::Goto the location in the script
title studying batch programming of file
SET A=%0
SET B=%~d0
SET C=%~p0
SET D=%~n0
SET E=%~x0
SET F=%~dp0
SET G=%~d0\%~p0

echo %A%
echo %B%
echo %C%
echo %D%
echo %E%
echo %F%
echo %G%

@echo on

pushd %~dp0
cd ..\..
cd
popd
cd
pause

@echo off

goto END



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