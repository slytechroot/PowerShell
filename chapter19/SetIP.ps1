#########################################################
# SetIP.ps1
# ed wilson, msft, 10/14/2007
#
# Configures IP address on a local or remote machine
# uses win32_networkadapter and 
# win32_networkadapterconfiguration
#
########################################################

param(
      $computer="localhost",
      $ip,
      $sm,
      $dg,
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: SetIP.ps1
Sets a static IP address on a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-ip       IP address to configure
-sm       Subnet mask to configure
-dg       Default gateway to configure
-list     Queries all network adapters and reports their configuration
-help     prints help file

SYNTAX:
SetIP.ps1 

Displays message an action is required, and calls help

SetIP.ps1 -list -computer MunichServer

Lists all the network adapters and their configuration on a computer 
named MunichServer

SetIP.ps1 -ip "10.0.0.1" -sm "255.0.0.0" -dg "10.0.0.5" 

Sets the Ip address to 10.0.0.1 and the subnet mask to 255.0.0.0 and the default
Gateway to 10.0.0.5 on the local machine

SetIP.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

function FunEvalRTN($rtn)
{ 
Switch ($rtn.returnvalue) 
  { 
   0 { Write-Host -foregroundcolor green "No errors for $strCall" }
   66 { Write-Host -foregroundcolor red "$strCall reports" `
       " invalid subnetMask" }
   67 { Write-Host -foregroundcolor red "$strCall reports" `
       " an error occurred processing request" }
   70 { Write-Host -ForegroundColor red "$strCall reports" `
       " invalid IP" }
   71 { Write-Host -ForegroundColor red "$strCall reports" `
         " invalid gateway" }
   91 { Write-Host -ForegroundColor red "$strCall reports" `
         " access denied"}
   96 { Write-Host -ForegroundColor red "$strCall reports" `
         " unable to contact dns server"}
   DEFAULT { Write-Host -ForegroundColor red "$strCall service reports" `
             " ERROR $($rtn.returnValue)" }
  }
  $rtn=$strCall=$null
}

Function funlist()
{ 
 Write-host "Listing Network adapters on $($computer) `n"

 Get-WmiObject -Class win32_networkadapter `
 -computername $computer | format-list [a-z]*

 Write-host "Listing network adapter configuration on " `
 "$($computer) `n"

 Get-WmiObject -Class win32_networkadapterconfiguration `
 -computername $computer | format-list [a-z]*
 exit
}



if($help) { funhelp }
if($list) { funlist }

if(!$ip -or !$sm -or !$dg) { "An action is required ... " ; funhelp }

$global:RTN = $null
$metric = [int32[]]1
$objWMI = Get-WmiObject -Class win32_networkadapterconfiguration `
 -computer $computer -filter "ipenabled = 'true'"

$RTN=$objwmi.EnableStatic($ip, $sm)
$strCall="enable static IP and subnet mask"
FunEvalRTN($rtn)

$RTN=$objwmi.SetGateways($dg, $metric)
$strCall="enable set default gateway and metric"
FunEvalRTN($rtn)
