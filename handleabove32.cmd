@echo off

if not exist "%USERPROFILE%\Desktop\Screen Recordings\Auto" (mkdir "%USERPROFILE%\Desktop\Screen Recordings\Auto")
cd "%USERPROFILE%\Desktop\Screen Recordings\Auto"
set "FreeSpace=0"
for /F "usebackq skip=1" %%x in (`wmic logicaldisk where "DeviceID='C:'" get FreeSpace^,Size`) do (set "FreeSpace=%%x")

rem // Remove the last 6 digits to get MBytes:
set "FreeSpaceMB=%FreeSpace:~,-6%"
rem // Ensure to not leave an empty value behind:
if not defined FreeSpaceMB set "FreeSpaceMB=0"

if %FreeSpaceMB% LSS 2499522 (
    for /F "delims=" %%a in ('dir /B /A:-D /T:W /O:D "C:\Users\Fabian\Desktop\Screen Recordings\Auto\*.flv"') do (
        del "%%a"
        goto :breakLoop
    )
)
:breakLoop
exit /B