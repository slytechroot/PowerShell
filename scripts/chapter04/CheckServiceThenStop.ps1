####################################################
# CheckServiceThenStop.ps1
# ed wilson, msft, 6/9/2007
#
# uses Get-WmiObject to retrieve win32_service
# uses write-host to write out messages
# calls the stopService() wmi method
# uses if to evaluate true
# uses switch to parse rtn code
#
####################################################
$strService = "bits"         #replace with service to stop, OR with $args for cmdline argument
$strComputer = "localhost"   #leave for current computer, or replace to remote to another 
$strClass = "win32_service"  #leave alone for current script!
$objWmiService = Get-Wmiobject -Class $strClass -computer $strComputer `
  -filter "name = '$strService'"

if( $objWMIService.Acceptstop )
 { 
  Write-Host "stopping the $strService service now ..." 
  $rtn = $objWMIService.stopService()
  Switch ($rtn.returnvalue) 
  { 
   0 { Write-Host -foregroundcolor green "$strService stopped" }
   2 { Write-Host -foregroundcolor red "$strService service reports" `
       " access denied" }
   5 { Write-Host -ForegroundColor red "$strService service can not" `
       " accept control at this time" }
   10 { Write-Host -ForegroundColor red "$strService service is already" `
         " stopped" }
   DEFAULT { Write-Host -ForegroundColor red "$strService service reports" `
             " ERROR $($rtn.returnValue)" }
  }
 }
ELSE
 { 
  Write-Host "$strService will not accept a stop request"
 }

