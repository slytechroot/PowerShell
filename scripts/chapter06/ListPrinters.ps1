##################################
# listPrinters.ps1
# ed wilson, msft, 6/29/2007
#
# produces a list of printers
#
# uses get-wmiobject cmdlet
# uses win32_printer class
#
###################################

$class = "win32_printer"
$computer = "localhost"
$wmi = Get-WmiObject -Class $class -computername $computer
format-table -Property name, systemName, shareName -groupby driverName `
-inputobject $wmi -autosize