@echo off

title function

set /p a=첫번쨰 값 입력: 
set /p b=두번쨰 값 입력: 
set /p c=첫번쨰 값 입력: 

call :func %a% %b% %c%

echo sum=%sum%
echo mul=%mul%

goto func2 1 2

pause > nul

:func <first> <second> <third>
set /a sum=%~1+%~2+%~3
set /a mul=%~1*%~2*%~3

:func2 <first> <second>
echo %1, %2
pause > nul


