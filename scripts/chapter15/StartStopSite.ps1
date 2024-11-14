###################################################################
# StartStopSite.ps1
# ed wilson, msft, 10/3/2007
#
# uses the iis 7 wmi classes found in root\webadministration
# uses the site class. Uses get-wmiobject and where-object
# uses the start and the stop method
#
###################################################################
param(
      $site, 
      $computer="localhost", 
      [switch]$start,
      [switch]$stop,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: StartStopSite.ps1
Starts or stops a web site on a local or or remote machine. 

PARAMETERS: 
-site      name of the site to start or to stop
-computer  specifies the name of the computer to run the script
-start     starts the web site
-stop      stops the web site
-help      prints help file

SYNTAX:
StartStopSite.ps1

Gets a listing of web sites on local computer

StartStopSite.ps1 -computer "webserverII"

Gets a listing of web sites on web server named webserverII

StartStopSite.ps1 -site mysite -stop

Stops a web site named mysite on local computer

StartStopSite.ps1 -site mysite -start -computer "webserverII"

Starts a web site named mysite on web server named webserverII

StartStopSite.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help) { "Printing help now..." ; funHelp }
if($start -and $stop) { 
                       "You cannot start and stop the $site"
                       "See help for allowed options" ;
                       funHelp
                      }
if(!$start -or !$stop)
 {
  "No action specified. Querying wmi sites. See help for options."
   Get-WmiObject -Namespace root\webadministration `
                 -computername $computer -class site |
   format-table -property name
   exit
 }

if($start)
 {
  $objSite = Get-WmiObject -Namespace root\webadministration -class site 
                           -computername $computer |
             Where-object { $_.name -eq $site }
  $objSite.Start()
  exit
 }
if($stop)
 {
  $objSite = Get-WmiObject -Namespace root\webadministration -class site 
                           -computername $computer |
             Where-object { $_.name -eq $site }
  $objSite.Stop()
  exit
 }