#####################################################################
# ReportTerminalServiceSetting.ps1
# ed wilson, msft, 10/11/2007
#
# uses the "win32_TerminalServiceSetting" wmi class from the
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
NAME: ReportTerminalServiceSetting.ps1
Displays Terminal Server settings on a local or a remote 
terminal server

PARAMETERS: 
-computer the computer to target the script to
-help     prints help file

SYNTAX:
ReportTerminalServiceSetting.ps1 
Displays Terminal Server settings on local machine

ReportTerminalServiceSetting.ps1 -computer ts1

Reports Terminal Server settings on remote terminal server
named ts1

ReportTerminalServiceSetting.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)       { "Printing help now ..." ; funHelp }

$namespace = "root\cimv2\TerminalServices"
$class = "win32_TerminalServiceSetting"

get-wmiobject -namespace $namespace -computername $computer `
          -class $class  |
  format-list [a-z]*