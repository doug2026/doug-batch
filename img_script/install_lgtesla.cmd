@REM @echo off
:: 관리자 권한 확인
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 관리자 권한으로 다시 실행합니다...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: 현재 디렉토리를 SOURCE로 설정
set "SOURCE=%~dp0##LGTesla_OQA_v2.1"
set "TARGET=C:\##LGTesla_OQA_v2.1"

echo 원본 경로: %SOURCE%
echo 대상 경로: %TARGET%

echo 폴더 복사 중...
XCOPY "%SOURCE%" "%TARGET%" /E /H /C /I /Y

color 4F
echo Install.bat 실행 중...
cd /d "%TARGET%"
call Install.cmd

echo 작업 완료.
pause