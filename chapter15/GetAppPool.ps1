###################################################################
# GetAppPool.ps1
# ed wilson, msft, 10/2/2007
#
# uses the iis 7 wmi classes found in root\webadministration
# uses the applicationpool class. Uses get-wmiobject and 
# format-table
#
###################################################################
param($computer="localhost", [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetAppPool.ps1
Gets a listing of application pools on a local or or remote machine. 

PARAMETERS: 
-computer  Specifies the name of the computer to run the script
-help      prints help file

SYNTAX:
GetAppPool.ps1

Gets a listing of application pools on local computer

GetAppPool.ps1 -computer "webserverII"

Gets a listing of application pools on a web server named webserverII. 

GetAppPool.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help) { "Printing help now..." ; funHelp }

Get-WmiObject -Namespace root\webadministration `
              -computername $computer -Class applicationpool |
format-table -property name, autostart, `
       @{ 
         Label = ".Net Version" ;
         Expression = { $_.ManagedRuntimeVersion }
        }, `
          QueueLength -autosize