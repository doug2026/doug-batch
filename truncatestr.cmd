title Batch: Truncate String before saving to variable

@echo off
setlocal
pushd %~dp0
title https://stackoverflow.com/questions/28514826/batch-truncate-string-before-saving-to-variable

:: only lines with number only
:: for /f %%a in ('wmic os get freephysicalmemory ^| findstr [0-9]') do (
:: skip 1st line
:: for /f "skip=1" %%a in ('wmic os get freephysicalmemory') do (
:: all lines
for /f %%a in ('wmic os get freephysicalmemory') do (
    if %%a "" (echo %%a) else (echo xxx)
)

for /f "skip=1" %%a in ('wmic os get freephysicalmemory ^| findstr "."') do (
    echo %%a
)

:: Get free physical memory, measured in KB
for /f "skip=1" %%a in ('wmic os get freephysicalmemory') do (
    for %%b in (%%a) do (
        set free_KB=%%b
    )
)
echo The free physical memory size in KB is %free_KB%KB

:: Get total physical memory, measured in B
for /f "skip=1" %%a in ('wmic computersystem get totalphysicalmemory') do (
    for %%b in (%%b) do (
        set total_B=%%b
    )
)
echo The free physical memory size in B is %free_KB%B

:: Compute values in MB
for /f "tokens=1-3" %%a in (
  'powershell -command "& {[int]$total=%total_B%/1MB;[int]$free=%free_KB%/1KB;$used=$total-$free;echo $total' '$used' '$free}"'
) do (
  set total_MB=%%a
  set used_MB=%%b
  set free_MB=%%c
)

:: Print the results
echo Total: %total_MB% MB
echo  Used: %used_MB% MB
echo  Free: %free_MB% MB

popd

:END