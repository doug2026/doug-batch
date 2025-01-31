
Get-CimInstance Win32_BIOS
Get-CimInstance Win32_BIOS | Select-Object SerialNumber

Get-CimInstance Win32_Computersystem
Get-CimInstance Win32_Computersystem | Select-Object -ExpandProperty model