################################################
# WriteToEventLog.ps1
# ed wilson, msft, 5/24/2007
#
# uses dot net framework system.diagnostics.eventlog
# creates the object, then the log
# sets source, and writes the entry
# BOTH creates the log and writes to it.
##################################################


$strLog = New-Object system.diagnostics.eventlog ("MrEdLog",".")
$strLog.source="mred"
$strLog.writeEntry("test from script")

