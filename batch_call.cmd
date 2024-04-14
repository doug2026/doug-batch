@echo off

title function

set /p a=첫번쨰 값 입력(a): 
set /p b=두번쨰 값 입력(b): 
set /p c=첫번쨰 값 입력(c): 

call :func %a% %b% %c%
call :calc %a% %b% %c%

echo Sum(%a%,%b%,%c%) = %sum%
echo Mul(%a%,%b%,%c%) = %mul%

goto END

:func <first> <second> <third>
echo a=%~1, b=%~2, c=%~3
goto :eof

:calc <first> <second> <third>
set /a sum=%~1+%~2+%~3
set /a mul=%~1*%~2*%~3
goto :eof

:END