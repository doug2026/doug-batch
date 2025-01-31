[CmdletBinding()]
Param(
    [Parameter()]
    [string]$path = ".\computer-info.txt"
)
$bios = Get-CimInstance Win32_BIOS | Select-Object -Property Manufacturer,Name,SerialNumber,Version
$os = Get-CimInstance Win32_OperatingSystem | Select-Object -Property Version,BuildNumber,RegisteredUser,SerialNumber
$qfe = Get-CimInstance Win32_QuickFixEngineering | Select-Object -Property Description,HotFixID,InstalledOn
$products = Get-CimInstance Win32_Product | Select-Object -Property Name,Vendor,Version,Caption | Format-List

$session = New-Object -ComObject Microsoft.Update.Session
$searcher = $session.CreateUpdateSearcher()
$updates = @($searcher.Search("IsHidden=0 and IsInstalled=0").Updates) | Select-Object Title

if ([System.IO.File]::Exists($path)) { Remove-Item $path -Force }

New-Item $path -ItemType "file" -Force | Out-Null
Add-Content $path -Value "BIOS" -Force
Out-File $path -InputObject $bios -Append -Encoding utf8
Add-Content $path -Value "OS"
Out-File $path -InputObject $os -Append -Encoding utf8
Add-Content $path -Value "UPDATES" -Force
Out-File $path -InputObject $qfe -Append -Encoding utf8
Add-Content $path -Value "MISSING UPDATES" -Force
Out-File $path -InputObject $updates -Append -Encoding utf8
Add-Content $path -Value "APPLICATIONS" -Force
Out-File $path -InputObject $products -Append -Encoding utf8
Write-Host $path' successfully generated'