@echo off

@set total=0
for /f %%a in ('WMIC LOGICALDISK WHERE "drivetype=3" GET Size ^| findstr [0-9]') do (
    echo %%a
    @call :inMB "%%a"
)

echo Total capacity of C+D drive : %total%GB

:END

:inMB <first>
set subTotal=%~1
set /a subTotal=%subTotal:~0,-3%/1024/1024
set /a total+=%subTotal%
goto :eof

