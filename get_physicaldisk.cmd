
$Drives=0 ; $TotalSize=0
get-physicaldisk | 
  ForEach {$_;$Drives+=1;$TotalSize+=$_.Size}|
    Format-Table -auto DeviceID,Size,BusType,MediaType,model,serialnumber
"Drives       TotalSize"
"------- --------------"
"{0,-6} {1,15}" -f $Drives,$TotalSize
