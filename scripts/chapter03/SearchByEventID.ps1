######################################
# SearchByEventID.ps1
# ed wilson, msft 5/26/2007
#
# searches system log by event ID
# uses the get-eventlog cmdlet
# uses the eventID property
# uses a where-object for filter
#
#######################################


Get-EventLog -LogName system |
Where-Object { $_.eventID -eq 1129 }