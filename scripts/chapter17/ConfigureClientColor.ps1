###################################################################
# ConfigureClientColor.ps1
# ed wilson, msft, 10/4/2007
#
# uses the win32_TSClientSetting wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses the setcolordepth
# method
# 
###################################################################

param(
      $depth,
      $computer = "localhost", 
      [switch]$list,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureClientColor.ps1
Configures color depth settings for client machine connecting
to a local or remote terminal server

PARAMETERS: 
-depth     the desired color depth on the client machine
           < 8, 15, 16, 24 >
-list      displays current configuration
-help      prints help file

SYNTAX:
ConfigureClientColor.ps1 
Displays an error that a setting must be supplied. Prints out
the help message

ConfigureClientColor.ps1 -depth 8

Configures the client setting on local terminal server to allow
max color depth of 8 bits

ConfigureClientColor.ps1 -depth 24 -computer TS2

Configures the client setting on remote terminal server named TS2
to allow max color depth of 8 bits

ConfigureClientColor.ps1 -help

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

if($help) { "Printing help now..." ; funHelp }
if($list) { funlist }
if(!$depth) { "A depth value is required..." ; funHelp }
 switch($depth)
 {
  8  { $depth = 1 }
  15 { $depth = 2 }
  16 { $depth = 3 }
  24 { $depth = 4 }
 }


$objClient=get-wmiobject -namespace $namespace -computername $computer `
          -class $class  
$objClient.SetColorDepth($depth)