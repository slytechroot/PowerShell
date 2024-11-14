##############################################
# LastEvent.ps1
# ed wilson, msft, 5/25/2007
#
# finds the last event log entry
# uses get-eventLog and indexes the log
#
###############################################

Write-Host "The following is the latest error in the log"
(Get-EventLog application)[0] | format-list *
