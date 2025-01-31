@echo off
if exist *.log del *.log
cd ./RW
if exist *.log del *.log
taskkill /f /im rw.exe 2>nul
Rw.exe /Command="R 0xFD6A0980" /stdout /nologo > result.log
set /p foobar=<result.log
set foobar=%foobar:~33,4%
echo %foobar%
cd ..
echo %foobar% > value.log
