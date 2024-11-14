###################################################################
# ConfigureSessionSettings.ps1
# ed wilson, msft, 10/4/2007
#
# uses the "win32_TSSessionSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses
# TimeLimit, and BrokenConnection
# 
###################################################################

param(
      $computer = "localhost", 
      $state,
      $value,
      [switch]$disconnect,
      [switch]$terminate,
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureSessionSettings.ps1
Configures client session settings for client
machine connecting to a local or remote terminal server

PARAMETERS: 
-computer   the computer to target the script to
-state      property to modify
-Value      time out in milliseconds
-disconnect disconnect the current session
-terminate  terminate the current session
-list       displays current configuration
-help       prints help file

SYNTAX:
ConfigureSessionSettings.ps1 
Displays an error that a setting must be supplied. Prints out
the help message

ConfigureSessionSettings.ps1 -list

Lists the current client session settings on local 
terminal server 

ConfigureSessionSettings.ps1 -state idle -value 5 -terminate  
-computer TS2

Configures the client session setting on remote terminal server 
named TS2 to terminate the session if it is idle for 5 
minutes

ConfigureSessionSettings.ps1 -state active -value 60 -disconnect

Configures the client session setting on local terminal server
to disconnect an active session after it has been active for 60
minutes

ConfigureSessionSettings.ps1 -help

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

new-variable -name Convert_to_minutes -value 60000 -option readonly
$namespace = "root\cimv2\TerminalServices"
$computer = "localhost"
$class = "win32_TSSessionSetting"

if($help) { "Printing help now..." ; funHelp }
if($list) { funlist }
if(!$state) { "You must specify an action" ; funhelp }

switch ($state)
{
 "Active" { $prop = "ActiveSessionLimit" }
 "Disconnect" { $prop = "DisconnectedSessionLimit" }
 "Idle" { $prop = "'IdleSessionLimit'" }
}

$value = $value*$convert_to_minutes

If($disconnect) { $action = 0 }
If($terminate)  { $action = 1 }

$objClient=get-wmiobject -namespace $namespace -computername $computer `
          -class $class  
$objClient.TimeLimit($prop,$value)
$objClient.BrokenConnection($action)