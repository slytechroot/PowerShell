################################################
# DeleteEventLog.ps1
# ed wilson, msft, 5/24/2007
#
# Uses .net framework system.diagnostics.eventlog
# class to delete an event log
#
##################################################
[system.diagnostics.eventlog]::delete("mredLog")