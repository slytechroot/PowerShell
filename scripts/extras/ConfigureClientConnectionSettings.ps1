###################################################################
# ConfigureClientConnectionSettings.ps1
# ed wilson, msft, 10/4/2007
#
# uses the "win32_TSClientSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses the 
# ConnectionSettings method
# 
###################################################################

param(
      $computer = "localhost", 
      [switch]$drives,
      [switch]$printer,
      [switch]$clientPrinter,
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureClientConnectionSettings.ps1
Configures connection settings for drives, printer, and client
printer for client machine connecting to a local or remote 
terminal server

PARAMETERS: 
-computer      The computer to target the script to
-drives        causes the terminal server to map the client 
               drives
-printer       causes the terminal server to automatically
               map local printer to the terminal session
-clientPrinter Causes the terminal server set the default
               printer to the users locally attached printer 
-list          displays current configuration
-help          prints help file

SYNTAX:
ConfigureClientConnectionSettings.ps1 
Displays an error that a setting must be supplied. Prints out
the help message

ConfigureClientConnectionSettings.ps1 -drives

Configures the client setting on local terminal server map the
client drives to the local session

ConfigureClientConnectionSettings.ps1 -drives -printer 
 -computer TS2

Configures the client setting on remote terminal server named 
TS2 to automatically map the client drives and local attached
printer

ConfigureClientConnectionSettings.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

Function funlist()
{
 get-wmiobject -namespace $namespace -computername $computer `
    -class $class  |
 format-list [a-z]*
 exit
}

$namespace = "root\cimv2\TerminalServices"
$computer = "localhost"
$class = "win32_TSClientSetting"
$disable = 0
$enable = 1

if($help) { "Printing help now..." ; funHelp }
if($list) { funlist }
if(!$drives) { "drive mapping will be disabled" }
If($printer) { "Printer maping will be disabled" }
If(!$clientprinter) { "Default printer is not local" }
  
if($drives) 
  { $cdrives = $enable }
else
  { $cdrives = $disable }
if($printer) 
  { $cprinter = $enable }
else
  { $cprinter = $disable }
if($clientPrinter) 
  { $cclientPrinter = $enable }
else
  { $cclientPrinter = $disable }


$objClient=get-wmiobject -namespace $namespace -computername $computer `
          -class $class  
$objClient.ConnectionSettings($cdrives,$cprinter,$cclientPrinter)