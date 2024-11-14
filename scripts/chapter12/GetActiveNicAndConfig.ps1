#################################################################################
# GetActiveNicAndConfig.ps1
# ed wilson, msft, 8/24/2007
#
# Uses get-wmiobject cmdlet to query 
# uses [switch] to turn $help into a switch instead of just a parameter
#
#################################################################################

param($computer = $env:computername, [switch]$full, [switch]$help)

function funline ($strIN)
{
 $strLine= "=" * $strIn.length
 Write-Host -ForegroundColor yellow $strIN 
 Write-Host -ForegroundColor darkYellow $strLine
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetActiveNicAndConfig.ps1 
Displays 

PARAMETERS: 
-computer    the name of the computer
-full        prints complete information
-help        prints help file

SYNTAX:
GetActiveNicAndConfig.ps1 -computer munich

Displays network adapter info and network
adapter configuration info on a computer
named munich

GetActiveNicAndConfig.ps1 

Displays network adapter info and network
adapter configuration info on the local 
machine

GetActiveNicAndConfig.ps1 -computer munich -full

Displays full network adapter info and full
network adapter configuration info on a computer
named munich

GetActiveNicAndConfig.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

New-Variable -Name c_netConnected -value 2 -option constant
$nic = Get-WmiObject -Class win32_networkadapter -computername $computer `
          -filter "NetConnectionStatus  = $c_netConnected"
$nicConfig = Get-WmiObject -Class win32_networkadapterconfiguration `
                -filter "interfaceindex = $($nic.interfaceindex)"

if($full)
  {
   funline("Full Network adapter information for $($computer)")
   format-list -InputObject $nic -property [a-z]*
   funline("Full Network adapter configuration for $($computer)")
   format-list -InputObject $nicConfig -property [a-z]*
  }
ELSE
{
   funline("Basic Network adapter information for $($computer)")
   format-list -InputObject $nic 
   funline("Basic Network adapter configuration for $($computer)")
   format-list -InputObject $nicConfig 
  }