######################################
# GetSingleEventEntry.ps1
# ed wilson, msft, 5/26/2007
#
# uses get-eventlog to return single
# log entry by using newest 1
#
######################################

 Get-EventLog -LogName application -Newest 1