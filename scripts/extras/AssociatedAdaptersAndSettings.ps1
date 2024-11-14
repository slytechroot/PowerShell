#################################################################################
# AssociatedAdaptersAndSettings.ps1
# ed wilson, msft, 7/23/2007
#  
# Uses the win32_networkadaptersetting association class
# uses the [wmi] type accelerator
# feeds the path returned by the association class to the [wmi] accelerator
# this is equivilent to doing a get query
# uses parameters to control where script will go query
# 
#
#################################################################################

Param($computer = "localhost")
function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline = $funline + "=" }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

Get-WmiObject -Class win32_NetworkAdapterSetting `
-computername $computer |
Foreach-object `
 {
  Write-Host -ForegroundColor cyan "Network adapter settings on $($_.__Server)"
  funline("Adapter: $($_.setting)")
  [wmi]$_.setting
  [wmi]$_.element
 }
 