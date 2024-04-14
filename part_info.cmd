@echo off
title https://stackoverflow.com/questions/42525626/windows-batch-wmic-diskdrive-get-size-where-media-type-fixed-hard-disk-media

set totalDriveSize=0
set drive=0

For /F "Skip=1 Delims=" %%A In (
    '"WMIC LogicalDisk Where (DriveType='3') Get DeviceID, Size"'
) Do For /F "Tokens=1-2" %%B In ("%%A") Do Echo %%B - %%C
Timeout -1

::for /f %%a in ('WMIC LOGICALDISK WHERE "drivetype=3" GET Size ^| findstr [0-9]') do (
for /f "Skip=1 Delims=" %%a in ('"WMIC LogicalDisk Where (DriveType='3') Get Caption, Size"') do (
    for /f "Tokens=1-2" %%b in ("%%a") do (
        call :driveSizeinMB "%%b" "%%c"
        call :totalSizeinMB "%%c"
    )
)

echo Total capacity of C+D drive = %totalDriveSize%GB
Timeout -1

for /f "usebackq tokens=2" %%a in ('"wmic logicaldisk where (drivetype='3') get caption"') do (
    echo Drive=%%a
)
for /f "usebackq delims== tokens=2" %%x in ('"wmic logicaldisk where (DeviceID='%%a') get FreeSpace /format:value"') do (
    set FreeSpace=%%x
)
for /f "usebackq delims== tokens=2" %%x in ('"wmic logicaldisk where (DeviceID='%%a') get Size /format:value"') do (
    set Size=%%x
)
echo FreeMB=%FreeSpace%
echo SizeMB=%Size%
set /a Percentage=100 * %FreeSpace% / %Size%
echo %%a is %Percentage% %% free
Timeout -1

for /f %%f in ('"wmic DiskDrive Where (MediaType='Fixed hard disk media') Get Size, SerialNumber /value"') do echo "%%f"
Timeout -1

goto END

:driveSizeinMB <first> <second>
set driveSize=%~2
set /a driveSize = %driveSize:~0,-3%/1024/1024
echo The size of Drive %~1 = %driveSize%MB
goto :eof

:totalSizeinMB <first>
set subTotal=%~1
set /a subTotal=%subTotal:~0,-3%/1024/1024
set /a totalDriveSize+=%subTotal%
goto :eof

:END

