@echo off
pushd %~dp0

:: Regular Expression
:: %var:x,y% - x = Start position, y = 길이
echo %DATE%
echo %TIME%
set datetimef=%date:~-4%_%date:~4,2%_%date:~7,2%_%date:~0,3%_%time:~0,2%_%time:~3,2%_%time:~6,2%
echo %datetimef%

:: Nnumbers are limited to 32-bit of precision.
:: 32-bit signed ingeger numbers -> (-2,147,483,648 through 2,147,483,647)
:: Workarounds for the 32-bit limitation include:
:: 1. dividing by 1000 (or any power of 10) by chopping off the last (3) digits
:: 2. splitting up the numbers into separate decimal digits and perform all the math
::    and carry logic "manually"
:: 3. other scripting languages

:: Get total physical memory, measured in B
for /f "skip=1" %%a in ('wmic computersystem get totalphysicalmemory ^| findstr "."') do (
rem for /f "skip=1" %%a in ('wmic computersystem get totalphysicalmemory ^| findstr [0-9]') do (
    @Call :ConvtDisp "%%a"
)

@Echo %inbytes%-B
@Echo %inkb%-KB
@Echo %inmb%-MB
@Echo %ingb%-GB

goto END

:ConvtDisp <first>
@Set sizeout=%~1
rem @Set sizeout=%sizeout:bytes=%
rem @Set sizeout=%sizeout: =%
@set inbytes=%sizeout%
@set /A inkb=(%sizeout:~0,-3%)
@set /A inmb=inkb/1024
@set /A ingb=inkb/(1024*1024)
goto :EOF

popd

:END