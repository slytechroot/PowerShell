####################################################
# ChangeModeThenStart.ps1
# ed wilson, msft, 6/9/2007
#
# uses Get-WmiObject to retrieve win32_service
# uses write-host to write out messages
# calls the startService() wmi method
# calls the changeStartMode() wmi method
# uses a function to evaluate rtn code
# uses variable to hold method name
# uses if to evaluate true
# uses switch to parse rtn code
# this script requires admin rights
#
####################################################
function FunEvalRTN($rtn)
{
Switch ($rtn.returnvalue) 
  { 
   0 { Write-Host -foregroundcolor green "No errors for $strCall" }
   2 { Write-Host -foregroundcolor red "$strService service reports" `
       " access denied" }
   5 { Write-Host -ForegroundColor red "$strService service can not" `
       " accept control at this time" }
   10 { Write-Host -ForegroundColor red "$strService service is already" `
         " running" }
   14 { Write-Host -ForegroundColor red "$strService service is disabled" }
   DEFAULT { Write-Host -ForegroundColor red "$strService service reports" `
             " ERROR $($rtn.returnValue)" }
  }
  $rtn=$strCall=$null
}


$strService = "bits"         #replace with service to stop, OR with $args for cmdline argument
$strComputer = "localhost"   #leave for current computer, or replace to remote to another 
$strClass = "win32_service"  #leave alone for current script!
$objWmiService = Get-Wmiobject -Class $strClass -computer $strComputer `
  -filter "name = '$strService'"

if( $objWMIService.state -ne 'running' -AND $objWMIService.startMode -eq 'Disabled')
  { 
   Write-Host "The $strService service is disabled. Changing to manual ..."
   $rtn = $objWmiService.ChangeStartMode("Manual")
   $strCall = "Changing service to Manual"

   FunEvalRTN($rtn)

   if($rtn.returnValue -eq 0)
     {
      Write-Host "The $strService service is not running. Attempting to start ..." 
      $rtn = $objWMIService.StartService()
      $strCall = "Starting service"

   FunEvalRTN($rtn)

      }

   }
ELSEIF($objWMIService.state -ne 'running')
  { 
   Write-Host "The $strService service is not running. Attempting to start ..." 
   $rtn = $objWMIService.StartService()
   $strCall = "Starting service"

   FunEvalRTN($rtn)

  }
ELSEIF($objWMIService.state -eq 'running')
  { 
   Write-Host "The $strService service is already running" 
  }
ELSE
  { 
   Write-Host "$strService is indeterminent"
  }
