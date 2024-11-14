#################################################################################
# WorkWithDHCP.ps1
# ed wilson, msft, 7/23/2007
#
# uses param for command line arguments
# uses funhelp function to display help
# uses funstatus function to get status of the network adapter
# uses get-wmiobject cmdlet, and the win32_networkadapterconfiguration wmi class
# uses here string in the function. NOTE: DO NOT have a space when using here 
# string: $helpText=@" (works) $helpText = @" (does not work)
# must be run with admin rights to set the IP address stuff
#################################################################################

param($computer="localhost",$action,$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: WorkWithDHCP.ps1
Works with DHCP settings on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-action <q(uery) e(nable) r(elease) rr(release/renew)  action to perform
-help   prints help file

SYNTAX:
WorkWithDHCP.ps1 -q "yes" -computer MunichServer

Queries DHCP settings on a computer named MunichServer

WorkWithDHCP.ps1 -action e

enables DHCP on local computer

WorkWithDHCP.ps1 -action r

Releases the DHCP address on the local machine

WorkWithDHCP.ps1 -action rr

Releases and then renews the DHCP address on the local machine

WorkWithDHCP.ps1 -help ?

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
   82 { Write-Host -foregroundcolor red "$strCall reports" `
       " Unable to renew DHCP lease" }
   83 { Write-Host -ForegroundColor red "$strCall reports" `
       " Unable to release DHCP lease" }
   91 { Write-Host -ForegroundColor red "$strCall reports" `
         " access denied"}
   DEFAULT { Write-Host -ForegroundColor red "$strCall service reports" `
             " ERROR $($rtn.returnValue)" }
  }
  $rtn=$strCall=$null
}


if($help) { funhelp }
$global:RTN = $null
if(!$action) { $action="q" }

$objWMI = Get-WmiObject -Class win32_networkadapterconfiguration `
 -computer $computer -filter "ipenabled = 'true'"

Switch($action)
{ 
 "e" { 
      $rtn = $objWMI.EnableDHCP() ; 
	  $strCall = "Enable DHCP" ; 
	  FunEvalRTN($rtn) 
     }
  "r" { 
      $rtn = $objWMI.ReleaseDHCPLease() ; 
	  $strCall = "Release DHCP address" ; 
	  FunEvalRTN($rtn) 
     }
 "rr" { 
      $rtn = $objWMI.RenewDHCPLease() ; 
	  $strCall = "Release and Renew DHCP address" ; 
	  FunEvalRTN($rtn) 
     }
 "q" {
      "DHCP Server: $($objWMI.dhcpserver)"
	   "Lease obtained: " + [Management.ManagementDatetimeConverter]::`
	    todatetime($objWMI.DHCPleaseObtained)
	   "Lease expires: " + [Management.ManagementDatetimeConverter]::`
	   todatetime($objWMI.DHCPleaseExpires)
	 }
	
}

