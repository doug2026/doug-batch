@echo off
pushd %~dp0

goto findStr1
:: [파일명 or 폴더명 찾기.제목 찾기]
:: 특정 문자열이 존재하는 행 찾기
:: find.exe /i "string" - /i (ignore case)
echo %1라는 이름을 가진 파일 또는 디렉토리를 찾아주세요.
set fileName=%1
dir /s /b | find /i "%fileName%"
if not %errorlevel%==0 (
    echo fail %fileName%라는 파일명을 가진 파일 또는 디렉토리가 없어요.
) else (
    echo pass %fileName%라는 파일명을 가진 파일 또는 디렉토리가 있군요.
)

:findStr1

:: [파일 내용 찾기.원하는 문자열 찾기]
:: findstr /s "원하는 문자열" *.txt (/s : 하위 경로)
echo "abcdef" | findstr /i /c:"fg"
echo %errorlevel%
:: findstr /n "원하는문자열입력" *mobile.log* -> /n을 붙이면 라인수가 같이 표기됨
$ findstr.exe /s /n /c:"git fetch" *.*
echo %errorlevel%

:: [특정단어 포함 + 특정단어 미포함 찾기. 원하는문자열찾기]
:: type *.java | findstr "Mid" | findstr /v "setMid"
type *.cmd | findstr "fetch" | findstr /v "first"
findstr /s /n "fetch" *.cmd | findstr /v "first"


popd

:END