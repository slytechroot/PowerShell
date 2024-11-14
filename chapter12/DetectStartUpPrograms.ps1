#################################################################################
# DetectStartUpPrograms.ps1
# ed wilson, msft, 8/25/2007
#
# Uses get-wmiobject cmdlet to query win32_StartUpCommand wmi class. This gives
# information about processes that start up automatically. 
# When run with no switches it produces only a list of the name
# uses [switch] to to allow a -full switch to get additional properties
# uses [switch] to turn $help into a switch instead of just a parameter
#
#################################################################################

param($computer="localhost", [switch]$full, [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: DetectStartUpPrograms.ps1 
Displays a listing of programs that automatically start

PARAMETERS: 
-computer    the name of the computer
-full        prints detailed information  
-help        prints help file

SYNTAX:
DetectStartUpPrograms.ps1 -computer munich -full

Displays name, command, location, and user information
about programs that automatically start on a computer 
named munich

DetectStartUpPrograms.ps1 -full

Displays name, command, location, and user information
about programs that automatically start on the local 
computer

DetectStartUpPrograms.ps1 -computer munich 

Displays a listing of programs that automatically start
on a computer named munich

DetectStartUpPrograms.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

if($full)
 { $property = "name", "command", "location", "user" }
else
 { $property = "name" }

Get-WmiObject -Class win32_startupcommand -computername $computer |
Sort-Object -property name  | 
format-list -property $property