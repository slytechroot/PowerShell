############################################################################
# ListPrinterDrivers.ps1
# ed wilson, msft, 7/3/2007
#
# uses named arguments (parameters) to allow to specify different computer
# uses here string for help text
# uses win32_PrinterDriver class to retrieve listing of printer drivers
#
############################################################################

param($strComputer="localhost", $help, $printer)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ListPrinterDrivers.ps1
Produces a listing of printer drivers on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-help         prints help file
-printer      printer name
SYNTAX:
ListPrinterDrivers.ps1 -computerName MunichServer

Lists all the printer drivers on a computer named MunichServer

ListPrinterDrivers.ps1 -help ?

Prints the help topic for the script

"@
$helpText
exit
}

if($help) { "Printing help now..." ; funHelp }

$class = "Win32_PrinterDriver"
Get-WmiObject -Class $class -computername $strcomputer | 
format-list [a-z]*