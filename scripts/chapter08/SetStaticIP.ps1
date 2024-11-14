#################################################################################
# SetStaticIP.ps1
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

param($computer="localhost",$q,$ip,$sm,$dg,$dns,$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: SetStaticIP.ps1
Sets a static IP address on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-q            Queries all IP bound network adapters
-ip           IP address to use
-sm           Subnet mask to use
-dg           Default gateway to use
-dns          Dns server to use
-help         prints help file

SYNTAX:
SetStaticIP.ps1 -q "yes" -computer MunichServer

Lists all the network adapters bound to IP on a computer named MunichServer

SetStaticIP.ps1 

Lists all the network adapters bound to IP on local computer

SetStaticIP.ps1 -ip "10.0.0.1" -sm "255.0.0.0" -dg "10.0.0.5" -dns "10.0.0.2"

Sets the Ip address to 10.0.0.1 and the subnet mask to 255.0.0.0 and the default
Gateway to 10.0.0.5 with a dns server of 10.0.0.2 on the local machine

SetStaticIP.ps1 -help ?

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


if($help) { funhelp }

if($q)
{ 
 Get-WmiObject -Class win32_networkadapterconfiguration `
 -computer $computer -filter "ipenabled = 'true'"
exit
}

if(!$ip)  { funhelp }
if(!$sm)  { funhelp }
if(!$dg)  { funhelp }
if(!$dns) { funhelp }

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
$RTN=$objwmi.SetDNSServerSearchOrder($dns)
$strCall="Set the dns server search order"
FunEvalRTN($rtn)
