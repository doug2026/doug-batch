
::FOR 구문은 각 행별로 분석하는데 
::이때 token은 각 행의 몇 번째 문자열을 전달해줄지 지정함.
::문자열의 기본 구분단위는 공백임.
@echo off

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
