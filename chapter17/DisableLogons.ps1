###################################################################
# DisableLogons.ps1
# ed wilson, msft, 10/7/2007
#
# uses the "win32_TerminalServiceSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses logons
# property and the put() method
# Specifies whether new sessions are allowed. This setting will 
# not affect existing settings. 
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
NAME: DisableLogons.ps1
Configures client session settings for client
machine connecting to a local or remote terminal server

PARAMETERS: 
-computer the computer to target the script to
-disallow disallows new logons to the terminal server
-allow    allows new logons to the terminal server
-list     displays current configuration
-help     prints help file

SYNTAX:
DisableLogons.ps1 
Displays an error that a setting must be supplied. Prints out
the help message

DisableLogons.ps1 -list

Lists the client session settings on local terminal server 

DisableLogons.ps1 -allow -computer TS2

Configures the remote terminal server named TS2 to allow
new connections

DisableLogons.ps1 -disallow

Configures the local terminal server to disallow
new connections

DisableLogons.ps1 -help

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

Function Funchange()
{
 $objTS = get-wmiobject -class $class -namespace $namespace `
            -computername $computer
 $objTS.logons = $action
 $objTS.put()
 exit
}

$namespace = "root\cimv2\TerminalServices"
$class = "win32_TerminalServiceSetting"

if($help)     { "Printing help now..." ; funHelp }
if($list)     { funlist }
if($allow)    { $action = 1 ; funchange }
if($disallow) { $action = 0 ; funchange }

"No action specified. Try DisableLogons.ps1 -help"



