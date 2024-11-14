###################################################################
# GetApplicationPoolDefaults.ps1
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
NAME: GetApplicationPoolDefaults.ps1
Gets a listing of application pool defaults on a local or or remote 
machine. 

PARAMETERS: 
-computer  Specifies the name of the computer to run the script
-help      prints help file

SYNTAX:
GetApplicationPoolDefaults.ps1

Gets a listing of application pool defaults on local computer

GetApplicationPoolDefaults.ps1 -computer "webserverII"

Gets a listing of application pool defaults on web server named 
webserverII. 

GetApplicationPoolDefaults.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help) { "Printing help now..." ; funHelp }


$server = Get-WmiObject -Namespace root\webadministration `
        -class server -computername $computer
$server.ApplicationPoolDefaults.autostart
$server.ApplicationPoolDefaults.Enable32BitAppOnWin64 
$server.ApplicationPoolDefaults.ManagedPipelineMode 
$server.ApplicationPoolDefaults.ManagedRuntimeVersion 
$server.ApplicationPoolDefaults.Name 
$server.ApplicationPoolDefaults.PassAnonymousToken 
$server.ApplicationPoolDefaults.QueueLength
$server.ApplicationPoolDefaults.cpu.Action 
$server.ApplicationPoolDefaults.cpu.limit
$server.ApplicationPoolDefaults.cpu.resetinterval
$server.ApplicationPoolDefaults.cpu.SmpAffinitized 
$server.ApplicationPoolDefaults.cpu.SmpAffinityMask