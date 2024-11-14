# SystemDriversAndDevices.ps1

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
   $str = $($_.antecedent).indexof("=")
  
  funline("Device: $($($_.Antecedent).substring($str+10))")
  [wmi]$_.Antecedent 
  
  [wmi]$_.Dependent 
   
 }