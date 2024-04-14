@echo off
title call batch file from another passing parameters
title https://stackoverflow.com/questions/5883500/call-batch-file-from-another-passing-parameters

pushd %~dp0

set param1=""
set param2=""
::SET /P PARAM1=Enter param1: %=%
::SET /P PARAM2=Enter param2: %=%
::ECHO %PARAM1%, %PARAM2% 

call :fetchParam1 %param1%
call :fetchParam2 %param2%

goto END


:fetchParam1 <first>
set param1=%~1
goto :param1Check

:param1Prompt
set /p "param1=Enter parameter 1: "
echo param1=%param1%
goto :eof

:param1Check
if "%param1%"=="" goto :param1Prompt

:fetchParam2 <first>
set param2=%~1
goto :param2Check

:param2Prompt
set /p "param2=Enter parameter 2: "
echo param1=%param1%
goto :eof

:param2Check
if "%param2%"=="" goto :param2Prompt


popd

:END