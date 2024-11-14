# DriversAndDevices.ps1

Param($computer = "localhost")

function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline = $funline + "=" }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}


Get-WmiObject -Class Win32_SystemDriverPNPEntity -computername $computer |

Foreach-object `
 {
  Write-Host -ForegroundColor cyan "Drivers and Devices on $($_.__Server)"
  funline("Device: $($_.Antecedent )")
  [wmi]$_.Antecedent 
  [wmi]$_.Dependent 
 }
 

