###################################################################
# GetSites.ps1
# ed wilson, msft, 10/2/2007
#
# uses the iis 7 wmi classes found in root\webadministration
# uses the site class. Uses get-wmiobject and format-table
#
###################################################################
param($computer="localhost", [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetSites.ps1
Gets a listing of web sites on a local or or remote machine. 

PARAMETERS: 
-computer  Specifies the name of the computer to run the script
-help      prints help file

SYNTAX:
GetSites.ps1

Gets a listing of web sites on local computer

GetSites.ps1 -computer "webserverII"

Gets a listing of web sites on web server named webserverII. 

GetSites.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help) { "Printing help now..." ; funHelp }

Get-WmiObject -Namespace root\webadministration `
              -computername $computer -class site |
format-table -property name
