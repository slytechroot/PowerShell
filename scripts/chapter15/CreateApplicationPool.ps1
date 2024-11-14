###################################################################
# CreateApplicationPool.ps1
# ed wilson, msft, 10/2/2007
#
# uses the iis 7 wmi classes found in root\webadministration
# uses the applicationpool class. Uses [wmiclass] to retrieve a 
# new instance of the wmi class. 
#
###################################################################
param(
      $appName, 
      $autoStart = $true, 
      $computer="localhost", 
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateApplicationPool.ps1
Creates a new application pool on a local or or remote machine. 

PARAMETERS: 
-appname   Name of the application pool
-autostart Specifies whether the application pool starts 
           automatically
-computer  Specifies the name of the computer to run the script
-help      Prints help file

SYNTAX:
CreateApplicationPool.ps1 -appname MyNewAppPool

Creates a new application pool on local computer named MyNewAppPool.
The application pool autostarts.

CreateApplicationPool.ps1 -computer "webserverII" -appname MyApp `
                          -autostart 0

Creates a new application pool named MyApp on a web server named 
webserverII. The application pool will not autostart.

CreateApplicationPool.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help) { "Printing help now..." ; funHelp }
if(!$appname) { "Missing value for -appname." ; funHelp }

$AppPool = [wmiclass]"\\$server\root\WebAdministration:applicationpool"
$appPool.Create($appName,$autostart)