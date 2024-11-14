###################################################################
# ConfigureRemoteControl.ps1
# ed wilson, msft, 10/4/2007
#
# uses the "win32_TSRemoteControlSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses the 
# RemoteControl method
# 
###################################################################

param(
      $computer = "localhost", 
      $action,
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureRemoteControl.ps1
Configures client settings for remote control for client
machine connecting to a local or remote terminal server

PARAMETERS: 
-computer  the computer to target the script to
-action    level of remote control setting 
           < disable ,input_Notify,input_No_Notify,
             no_input_Notify, no_input_no_notify >
-list      displays current configuration
-help      prints help file

SYNTAX:
ConfigureRemoteControl.ps1 
Displays an error that a setting must be supplied. Prints out
the help message

ConfigureRemoteControl.ps1 -list

Lists the current client remote control settings on local 
terminal server 

ConfigureRemoteControl.ps1 -action disable -computer TS2

Configures the client setting on remote terminal server named 
TS2 to disable remote control

ConfigureRemoteControl.ps1 -action input_notify

Configures the client setting on local terminal server
to enable remote control input after notifying the user

ConfigureRemoteControl.ps1 -help

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
$class = "Win32_TSRemoteControlSetting"
if($help) { "Printing help now..." ; funHelp }
if($list) { funlist }
if(!$action) { "You must specify an action" ; funhelp }

switch($action)
{
 "disable"            { $rc = 0 }
 "input_Notify"       { $rc = 1 }
 "input_No_Notify"    { $rc = 2 }
 "no_input_Notify"    { $rc = 3 }
 "no_input_no_notify" { $rc = 4}
}


$objClient=get-wmiobject -namespace $namespace -computername $computer `
          -class $class -filter "terminalname = 'rdp-tcp'"
 $objClient.RemoteControl($rc)