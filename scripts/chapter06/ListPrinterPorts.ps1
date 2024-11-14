############################################################################
# ListPrinterPorts.ps1
# ed wilson, msft, 7/3/2007
#
# uses named arguments (parameters) to allow to specify different computer
# uses here string for help text
# uses win32_tcpipprinterport class to retrieve listing of printer ports
#
############################################################################
param($strComputer="localhost", $help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ListPrinterPorts.ps1
Produces a listing of printer ports on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-help         prints help file

SYNTAX:
ListPrinterPorts.ps1 -comptuerName MunichServer
Lists all the printer ports on a computer named MunichServer

ListPrinterPorts.ps1 -help ?
Prints the help topic for the script

"@
$helpText
exit
}

if($help) { "Printing help now..." ; funHelp }

$class = "Win32_TcpIpPrinterPort"
Get-WmiObject -Class $class -computername $strcomputer | 
format-list [a-z]*