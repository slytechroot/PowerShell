########################################
# ListPrintersFromMultipleComputers.ps1
# ed wilson, msft, 6/29/2007
#
# produces a list of printers from 
# multiple computers
# uses get-wmiobject cmdlet
# uses win32_printer class to retrieve
# name, systemname, sharename and driver
# name.
########################################

$class = "win32_printer"
$arycomputer = "localhost", "loopback"
foreach( $computer in $aryComputer)
{
 Write-Host "Retrieving printers from $computer ..."
 $wmi = Get-WmiObject -Class $class -computername $computer
 format-table -Property name, systemName, shareName -groupby driverName `
 -inputobject $wmi -autosize
}