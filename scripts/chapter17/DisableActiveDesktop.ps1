###################################################################
# DisableActiveDesktop.ps1
# ed wilson, msft, 10/4/2007
#
# uses the "win32_TerminalServiceSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses ActiveDesktop
# property and the put() method
# 
###################################################################

param(
      $computer = "localhost", 
      [switch]$allow,
      [switch]$disallow,
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: DisableActiveDesktop.ps1
Configures client session settings for client
machine connecting to a local or remote terminal server

PARAMETERS: 
-computer the computer to target the script to
-disallow disallows active desktop in the current session
-allow    allows active desktop in the current session
-list     displays current configuration
-help     prints help file

SYNTAX:
DisableActiveDesktop.ps1 
Displays an error that a setting must be supplied. Prints out
the help message

DisableActiveDesktop.ps1 -list

Lists the active desktop client session settings on local 
terminal server 

DisableActiveDesktop.ps1 -allow -computer TS2

Configures the client to allow active desktop on remote 
terminal server named TS2 

DisableActiveDesktop.ps1 -disallow

Configures the client to disallow active desktop on local 
terminal server

DisableActiveDesktop.ps1 -help

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
$class = "win32_TerminalServiceSetting"

if($help)     { "Printing help now..." ; funHelp }
if($list)     { funlist }
if($allow)    { $action = 1}
if($disallow) { $action = 0 }


$objTS = get-wmiobject -class $class -namespace $namespace `
       -computername $computer
$objTS.ActiveDesktop = $action
$objTS.put()