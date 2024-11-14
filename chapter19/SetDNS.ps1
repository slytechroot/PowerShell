#########################################################
# SetDNS.ps1
# ed wilson, msft, 10/14/2007
#
# Configures DNS settings on a local or remote machine
# uses win32_networkadapter and 
# win32_networkadapterconfiguration
#
########################################################
param(
      $computer="localhost",
      $dnsdomain,
      $dnsServer,
      $dnsSuffix,
      [switch]$list,
      [switch]$help
      )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: SetDNS.ps1
Sets DNS configuration on a local or remote machine.

PARAMETERS: 
-computer  Specifies the name of the computer upon which to run the script
-list      Queries all IP bound network adapters
-dnsserver Dns server
-dnsDomain DNS domain name
-dnsSuffix The dns suffix
-help      prints help file

SYNTAX:
SetDNS.ps1 

Displays a message an action is required and calls help

SetDNS.ps1 -list -computer MunichServer

Lists all the network adapters and configuration on a computer
named MunichServer

SetDNS.ps1 -dnsServer "10.0.0.2" -dnsDomain "nwtraders.com" `
           -dnsSuffix "nwtraders.com"

Sets the dns server to 10.0.0.2, the dnsDomain to nwtraders.com
the dns search suffix to nwtraders.com on the local machine

SetDNS.ps1 -dnsServer "10.0.0.2" -dnsDomain "nwtraders.com" `
           -dnsSuffix "nwtraders.com" -computer munichServer

Sets the dns server to 10.0.0.2, the dnsDomain to nwtraders.com
the dns search suffix to nwtraders.com on a remote computer
named munichserver


SetDNS.ps1 -help

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
if(!$dnsdomain -or !$dnsServer -or !$dnsSuffix) 
  { "An action is required ... " ; funhelp }

$global:RTN = $null
$class = "win32_networkadapterconfiguration"
$namespace = "root\cimv2"
$objWMI = Get-WmiObject -Class $class `
        -namespace $namespace -computer $computer `
        -filter "ipenabled = 'true'"

$RTN=$objwmi.SetDNSDomain($dnsdomain)
$strCall="Setting the DNS domain name"
FunEvalRTN($rtn)

$RTN=$objwmi.SetDNSServerSearchOrder($dnsServer)
$strCall="Set the dns server search order"
FunEvalRTN($rtn)

$wmiclass = "\\$computer" + "\" + $namespace + ":" + $class
$wmi = [wmiclass]"$wmiclass"
$rtn = $wmi.SetDNSSuffixSearchOrder($dnsSuffix)
$strCall="Set the dns suffix search order"
FunEvalRTN($rtn)

