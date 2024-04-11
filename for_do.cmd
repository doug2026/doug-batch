@echo off
pushd %~dp0

title for in () do ~
title ("문자열"), (파일명), (명령어)가 올수 있음

goto startStudy

title Get a string (문자열)
for %%a in (miku daisuki) do (
    echo %%a
)

pause > null

title file name (파일명) in the current directory
for %%c in (g* *.cmd *.bak) do echo %%c

pause > null

title a string (문자열), file name (파일명) in the current directory
title 구분 - 공백( ),콤마(,), 세미콜론(:)
for %%c in (miku:daisuki,g* *.cmd,*.bak) do echo %%c

pause > null

title
for %%d in (1;2 3,4) do echo %%d

pause > null

title (시작,단계,끝)
for /l %%n in (1,3,10) do echo %%n

pause > nul

title /r (resursive)
for /r D:\tools %%a in (*.mp4 *.avi) do echo %%a

pause > nul

title /d (폴더명) - output the current directories
for /d %%a in (*) do echo %%a

pause > null

goto END


:startStudy

title /f (옵션)
title (옵션) = (파일명) : 파일 내용을 한줄씩 for문을 돌려 파싱한다.
title        = (문자열) : 문자열을 파싱한다.
title        = (명령어) : 명령어 결과값을 파싱한다.
title delims (delimeters) : 문자열을 나누는 기호 문자, 생략 시 공백(스페이스, 탭)으로 나눈다.
title tokens : 구분자로 나뉘어진 것을 각각 토근이라한다.
title          토큰들과 루프 변수에 1:1로 대응하도록 한다.
title          이 때 루프변수의 다음 알파벳으로 자동 대응된다.
title skip : 생략할 행 번호 설정
title eol : 시작 문자로 생략할 행 설정, 생략 시 ;(세미콜론)으로 시작하는 행은 생략한다.
title usebackq : 대체 인용, 파일명에 공백이 들어 갈때 문자열로 처리하는걸 막거나
title            명령문에 특수문자가 들어갈때 오류 방지

for /f "delims=: tokens=1" %%a in ("hello:world!") do echo %%a
for /f "delims=: tokens=1,2" %%a in ("hello:world!") do echo %%a-%%b

pause > null
popd

:END