#####################################################################
# ReportClientSettings.ps1
# ed wilson, msft, 10/8/2007
#
# uses the "win32_TSClientSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. 
#
#####################################################################

param(
      $computer = "localhost", 
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ReportClientSettings.ps1
Displays client configuration settings on a local or a remote 
terminal server

PARAMETERS: 
-computer the computer to target the script to
-help     prints help file

SYNTAX:
ReportClientSettings.ps1 
Displays client configuration settings on local machine

ReportClientSettings.ps1 -computer ts1

Reports client configuration settings on remote terminal server
named ts1

ReportClientSettings.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)       { "Printing help now ..." ; funHelp }

$namespace = "root\cimv2\TerminalServices"
$class = "win32_TSClientSetting"

get-wmiobject -namespace $namespace -computername $computer `
          -class $class  |
  format-list [a-z]*