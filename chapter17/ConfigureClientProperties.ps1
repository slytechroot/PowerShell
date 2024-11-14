###################################################################
# ConfigureClientProperties.ps1
# ed wilson, msft, 10/4/2007
#
# uses the "win32_TSClientSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses the 
# ConnectionSettings method
# 
###################################################################

param(
      $computer = "localhost", 
      $action,
      [switch]$enable,
      [switch]$disable,
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureClientProperties.ps1
Configures client settings for LPTPortMapping, COMPortMapping
AudioMapping, ClipboardMapping, DriveMapping, 
WindowsPrinterMapping for client machine connecting to a 
local or remote terminal server

PARAMETERS: 
-computer  the computer to target the script to
-action    type of resource mapping 
           < lpt, com, audio, clip, drive, printer >
-enable    enables the action
-disable   disables the action
-list      displays current configuration
-help      prints help file

SYNTAX:
ConfigureClientProperties.ps1 
Displays an error that a setting must be supplied. Prints out
the help message

ConfigureClientProperties.ps1 -list

Lists the current client settings on local terminal server 

ConfigureClientProperties.ps1 -action com -disable -computer TS2

Configures the client setting on remote terminal server named 
TS2 to disable client com port mapping

ConfigureClientProperties.ps1 -action lpt -enable

Configures the client setting on local terminal server
to enable client lpt port mapping

ConfigureClientProperties.ps1 -help

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
$class = "win32_TSClientSetting"

if($help) { "Printing help now..." ; funHelp }
if($list) { funlist }
if(!$action) { "You must specify an action" ; funhelp }
if($disable) { $value = 0 }
if($enable)  { $value = 1 }

switch($action)
{
 "lpt"     { $action = "LPTPortMapping" }
 "com"     { $action = "COMPortMapping" }
 "audio"   { $action = "AudioMapping" }
 "clip"    { $action = "ClipboardMapping" }
 "drive"   { $action = "DriveMapping" }
 "printer" { $action = "WindowsPrinterMapping  " }
}

$objClient=get-wmiobject -namespace $namespace -computername $computer `
          -class $class  
$objClient.SetClientProperty($action, $value)