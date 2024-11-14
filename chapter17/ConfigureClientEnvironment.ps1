################################################################### 
# ConfigureClientEnvironment.ps1
# ed wilson, 10/6/2007
#
# uses the win32_TSEnvironmentSetting in the 
# root\cimv2\TerminalService wmi namespace
#
###################################################################

param(
      $action,
      $value,
      $computer = "localhost",
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureClientEnvironment.ps1
Configures Terminal Server Environment settings for the client on
either a local or remote Terminal server. 

PARAMETERS: 
-action    the action to perform < ip(initial program) >
-value     modifies the action to perform
-computer  the computer upon which the script is to operate
-list      lists client environment settings
-help      prints help file

SYNTAX:
ConfigureClientEnvironment.ps1 
Dispays an error that an action must be selected. Displays help

ConfigureClientEnvironment.ps1 -list

Lists Terminal Server Environment settings for the client on
either a local Terminal server. 

ConfigureClientEnvironment.ps1 -action wp -value 1

Configures the local Terminal server to not display wall paper on terminal
services client machines

ConfigureClientEnvironment.ps1 -action wp -value 0

Configures the local Terminal server to display wall paper on terminal
services client machines

ConfigureClientEnvironment.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

Function funlist()
{ 
 get-wmiobject -namespace $namespace -computername $computer `
    -class $class |
 format-list [a-z]*
 exit
}


Function funpaper($strin)
{
 $objClient=get-wmiobject -namespace $namespace -computername $computer `
          -class $class  -filter "terminalname = 'rdp-tcp'"
 $objClient.SetClientWallPaper($strin)
 exit
}

$namespace = "root\cimv2\TerminalServices"
$class = "win32_TSEnvironmentSetting"

if($help) { "Printing help now..." ; funHelp }
if($list) { funlist }
if(!$action -and !$list) { "You must select an action ..." ; funhelp }


switch($action)
{
  "wp" { funPaper($value) }
}