#################################################################################
# AutoServicesNotRunning.ps1
# ed wilson, msft, 8/23/2007
#
# Uses get-wmiobject cmdlet to query service status and startmode
# evaluates null output and handles this and multiple service 
# uses foreach to walk through collection of services
# uses [switch] to turn $help into a switch instead of just a parameter
#
#################################################################################

param($computer="localhost", [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: AutoServicesNotRunning.ps1 
Displays a listing of services that are set to 
automatic, but are not presently running

PARAMETERS: 
-computer    The name of the computer
-help        prints help file

SYNTAX:
AutoServicesNotRunning.ps1 -computer munich

Displays a listing of all non running services
that are set to automatically start on a computer
named munich

AutoServicesNotRunning.ps1 

Displays a listing of all services that are set
to automatic, but are not presently running on 
the local machine

AutoServicesNotRunning.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

$wmi = Get-WmiObject -Class win32_service -computername $computer `
   -filter "state <> 'running' and startmode = 'auto'"
if($wmi -eq $null) 
  { "No automatic services are stopped" }
Else
  {
   "There are $($wmi.count) automatic services stopped.
          The list follows ... "
	foreach($service in $wmi) { $service.name }
   }
	
