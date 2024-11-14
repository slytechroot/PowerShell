#########################################################
# ConfigureDNSLogging.ps1
# ed wilson, msft, 9/23/2007
#
# Configures DNS logging level
#
########################################################

param(
      $computer="localhost", $change, [switch]$query, $restart, 
     [switch]$stop, [switch]$start, [switch]$help
     )
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureDNSLogging.ps1
Configures DNS Server logging information on a local 
or remote machine. 

PARAMETERS: 
-computer Specifies the name of the computer to run the script
-change   Property to configure on the DNS server < LogLevel, 
          LogPath, LogSize, LogIPFilter, EventLogLevel >
-query    List current logging configuration
-stop     Stops the DNS server service
-start    Starts the DNS server service
-restart  Stops the DNS server service and waits for a specified
          interval prior to starting the service backup
-help     prints help file

SYNTAX:
ConfigureDNSLogging.ps1 -change loglevel,107009

Changes diagnostic logging to record all DNS queries 
and responses, using TCP that are incoming to local computer 

ConfigureDNSLogging.ps1 -computer MunichServer -change 
logPath, "C:\fso"

Changes default DNS Server diagnostic logging directory
on a remote server named MunichServer to the c:\fso directory

ConfigureDNSLogging.ps1 -computer MunichServer -query

Queries a remote server named MunichServer to for all logging settings

ConfigureDNSLogging.ps1 -computer MunichServer -change eventloglevel, 4

Configures a remote server named MunichServer to record all events in 
the system event log related to DNS

ConfigureDNSLogging.ps1 -computer MunichServer -restart 5

Causes a remote server named MunichServer restart the DNS service. 
Waits For 5 seconds between stopping and starting the DNS service


ConfigureDNSLogging.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

function funchange($change)
{
  $class="MicrosoftDNS_Server"
  $dnsServer=Get-WmiObject -class $class -computername $computer `
	        -namespace root\microsoftDNS
  switch($change[0])
   {
    "LogLevel" { $dnsServer.logLevel = $change[1] ; $dnsServer.put() }
    "LogPath" { $dnsServer.logFilePath = $change[1] ; $dnsServer.put() }
    "LogSize" { $dnsServer.LogFileMaxSize = $change[1] ; $dnsServer.put() }
    "LogIPFilter" { $dnsServer.LogIPFilterList = $change[1] ; $dnsServer.put() }
    "EventLogLevel" { $dnsServer.EventLogLevel = $change[1] ; $dnsServer.put() }
    DEFAULT { "You must specify an action" ; funhelp }
   }
}

function funQuery()
{
 $class="MicrosoftDNS_Server"
 Get-WmiObject -class $class -computername $computer `
			-namespace root\microsoftDNS | 
			format-list -property Log*, *log*
 exit

}

function funStart()
{ 
 $class="MicrosoftDNS_Server"
 $dnsServer = Get-WmiObject -class $class -computername $computer `
			  -namespace root\microsoftDNS
 $dnsServer.StartService()
 exit
}

function funStop()
{
 $class="MicrosoftDNS_Server"
 $dnsServer = Get-WmiObject -class $class -computername $computer `
			  -namespace root\microsoftDNS
 $dnsServer.StopService()
 exit
}

function funRestart($restart)
{ 
 $class="MicrosoftDNS_Server"
 $dnsServer = Get-WmiObject -class $class -computername $computer `
			  -namespace root\microsoftDNS
 "Stopping service ..."
 $dnsServer.StopService()
 for($i = 0 ; $i -le $restart ; $i++)
 {
  Start-Sleep -Seconds 1
  Write-Host "." -NoNewline
 }
  "Starting service ..."
  $dnsServer.StartService()
 exit
}

if($help)   { "Printing help now..." ; funHelp }
if($query)  { "Printing the current DNS server log settings" ; funQuery }
if($change) 
  { 
    "Change $($change[0]) to $($change[1]) now ..." ; 
    funChange($change) 
  }
if($start)   { "Starting DNS service now..." ; funStart }
if($stop)    { "Stopping DNS service now..." ; funStop }
if($restart) { "Restarting DNS service in $($restart) seconds..." ; funRestart($restart) }
ELSE
  { "No action was specified..." ; funhelp }