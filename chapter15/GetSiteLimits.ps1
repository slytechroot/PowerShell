###################################################################
# GetSiteLimits.ps1
# ed wilson, msft, 10/2/2007
#
# uses the iis 7 wmi classes found in root\webadministration
# uses the server class. Uses get-wmiobject and format-table
#
###################################################################
param($computer="localhost", [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetSiteLimits.ps1
Gets a listing of site limits on a local or or remote machine. 

PARAMETERS: 
-computer  Specifies the name of the computer to run the script
-help      prints help file

SYNTAX:
GetSiteLimits.ps1

Gets a listing of site limits on local computer

GetSiteLimits.ps1 -computer "webserverII"

Gets a listing of site limits on web server named webserverII. 

GetSiteLimits.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)      { "Printing help now..." ; funHelp }


$server = Get-WmiObject -Namespace root\webadministration `
             -computername $computer -class server
$server.SiteDefaults.limits.maxconnections
$server.SiteDefaults.limits.ConnectionTimeout
$server.SiteDefaults.limits.MaxBandwidth 
