#################################################################################
# GroupedDirectoryListing.ps1
# ed wilson, msft, 7/24/2007
#
# Uses get-wmiobject and the win32_networkadapterconfiguration wmi class
# uses the funline function
# Uses foreach-object cmdlet
# uses if statement, and the write-host cmdlet, and `n for new line `t for tab
# uses -match to perform regex match in the if statement
# uses psobject.properties to return the properties of the wmi properties
# examines the value property of the property, and if it exists, return the name
# and the value pair
#
#################################################################################

param($dir="c:\fso", $help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureFWLogging.ps1
Produces a listing of firewall logging settings. Allows config also

PARAMETERS: 
-action Specifies action to perform when the script is run
-help   prints help file

SYNTAX:
ConfigureFWLogging.ps1 
Lists all the firewall logging settings

ConfigureFWLogging.ps1 -action EnableDropped
Configures firewall to log dropped packets

ConfigureFWLogging.ps1 -action EnableConnect
Configures firewall to log connections

ConfigureFWLogging.ps1 -action show
Lists all the firewall logging settings

ConfigureFWLogging.ps1 -action setLogFolder -path "c:\fso\pfirewall.log"
Configures firewall to log to the c:\fso\pfirewall.log file

ConfigureFWLogging.ps1 -action SetLogSize -size 4096"
Configures firewall to a maximum size of 4096 kilobytes


ConfigureFWLogging.ps1 -help ?
Displays the help topic for the script

"@
$helpText
exit
}


Get-ChildItem $dir |
Group-Object Extension | 
Sort-Object -desc Count
