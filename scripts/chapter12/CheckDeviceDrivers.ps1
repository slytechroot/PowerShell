#################################################################################
# CheckDeviceDrivers.ps1
# ed wilson, msft, 8/24/2007
#
# Uses get-wmiobject cmdlet to query service status and startmode
# evaluates null output and handles this and multiple service 
# uses foreach to walk through collection of services
# uses [switch] to turn $help into a switch instead of just a parameter
#
#################################################################################

param($computer="localhost", $a="h", [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CheckDeviceDrivers.ps1 
Displays a listing of system drivers that are set to 
automatic, manual, boot, system or all drivers

PARAMETERS: 
-computer    The name of the computer
-a(ction)    < a(ll), r(unning), s(topped), b(oot),
               m(anual), au(to), sy(stem), h(elp) > 
-help        prints help file

SYNTAX:
CheckDeviceDrivers.ps1 -computer munich -a b

Displays a listing of all device drivers
that are set to start on boot on a computer
named munich

CheckDeviceDrivers.ps1 -a auto

Displays a listing of all device drivers on local
computer set to start up automatically

CheckDeviceDrivers.ps1 -computer munich -a m

Displays a listing of all device drivers
that are set to start manually on a computer
named munich

CheckDeviceDrivers.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

switch($a)
{ 
 "a" { 
      "Retrieving all device drivers" 
	  $filter = "started = 'true' or started = 'false'"
	 }
 "r" { 
      "Retrieving all running device drivers"
	  $filter = "started = 'true'"
	 }
 "s" {
      "Retrieving all stopped device drivers"
	  $filter = "started = 'false'"
	 }
 "b" {
      "Retrieving boot device drivers"
	  $filter = "startmode = 'boot'"
	 }
 "m" {
      "Retrieving manual device drivers"
	  $filter = "startmode = 'manual'"
	 }
 "au" {
      "Retrieving auto device drivers"
	  $filter = "startmode = 'auto'"
	 }
 "sy" {
      "Retrieving system device drivers"
	  $filter = "startmode = 'system'"
	 }
 "h" { 
      "You need to specify an action. The -a parameter is required" 
	  "Try this: " +  $MyInvocation.MyCommand.Definition + " -h"
	  exit
	 }
 DEFAULT 
      { 
      "You need to specify an action. The -a parameter is required" 
	  "Try this: " +  $MyInvocation.MyCommand.Definition + " -h"
	  exit
	 }
}

$wmi = Get-WmiObject -Class win32_systemdriver `
     -computername $computer -filter $filter
format-table -InputObject $wmi -property `
      displayname, pathname, name  -autosize