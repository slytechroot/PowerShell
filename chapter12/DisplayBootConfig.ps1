#################################################################################
# DisplayBootConfig.ps1
# ed wilson, msft, 8/27/2007
#
# uses get-wmiobject cmdlet to query boot up settings
# uses format-list [a-z]* to remove system properties from output
# uses [switch] to turn $help into a switch instead of just a parameter
# this script works locally or remotely
#
#################################################################################

param($computer="localhost", [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: DisplayBootConfig.ps1 
Displays a boot up configuration of a Windows system

PARAMETERS: 
-computer    The name of the computer
-help        prints help file

SYNTAX:
DisplayBootConfig.ps1 -computer munich

Displays boot up configuration of a computer
named munich

DisplayBootConfig.ps1

Displays boot up configuration on local
computer 

DisplayBootConfig.ps1 -help 

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

$wmi = Get-WmiObject -Class win32_BootConfiguration `
     -computername $computer 
format-list -InputObject $wmi [a-z]*