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

for /f "tokens=6 delims== " %%i in ('"wmic cpu get Caption /value | findstr /b /c:"Caption""') do set CPU_GEN=%%i
  wmic cpu get Caption /value
  IF [%CPU_GEN%]==[141] SET CPU_NAME=TGL
  IF [%CPU_GEN%]==[140] SET CPU_NAME=TGL
  IF [%CPU_GEN%]==[154] SET CPU_NAME=ADL
  IF [%CPU_GEN%]==[156] SET CPU_NAME=JSL
  IF [%CPU_GEN%]==[186] SET CPU_NAME=RPL
  IF [%CPU_GEN%]==[170] SET CPU_NAME=MTL
@echo %CPU_GEN%
@echo %CPU_NAME%

goto END

::Goto the location in the script
title studying batch programming of file
SET A=%0
SET B=%~d0
SET C=%~p0
SET D=%~n0
SET E=%~x0
SET F=%~dp0
SET G=%~dpnx0
SET H=%~d0\%~p0

echo %A%
echo %B%
echo %C%
echo %D%
echo %E%
echo %F%
echo %G%
echo %H%

::set TESTDIR=%~dp0%..
set TESTDIR=%~dp0%test_dir
@echo %TESTDIR%
::cd %TESTDIR%
::@call test.bat
@call "%~dp0test.bat"

@echo off
cd
echo %0
echo %~0
echo %~d0
echo %~p0
echo %~dp0
cd %~dp0
cd
@echo off
pause

@echo on
pushd %~dp0
cd ..\..
cd
popd
cd
pause
@echo off

::@echo off

:todayStudy

title batch programming ...
@echo on
pushd %~dp0


title studying git ...
:: git clone
:: git remote -v
:: git branch
:: git checkout -b <branch_name>  	:: branch_name branch ���� �� �̵�
:: git checkout <branch_name> 		:: branch_name branch�� �̵�
:: git checkout <commit_hask_key> 	:: �귣ġ �̸� ��� Ŀ�� �ؽ�Ű�� ����Ͽ� üũ�ƿ��� ���� �ֽ��ϴ�.


:: ��or create a new repository on the command line
::echo "# dh2110-lg" >> README.md
::git init
::git add README.md
::git commit -m "first commit"
::git branch -M main
::git remote add origin https://github.com/doug2026/dh2110-lg.git
::git push -u origin main
:: ��or push an existing repository from the command line
::git remote add origin https://github.com/doug2026/dh2110-lg.git
::git branch -M main
::git push -u origin main

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