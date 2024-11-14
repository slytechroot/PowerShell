##########################################
# GetAppLogLast60minutes.ps1
# ed wilson, msft, 5/24/2007
#
# uses get-eventlog to retrieve the
# entries from application log
# uses where to filter out on the
# timegenerated property. if it is
# greater than the time was 60 min
# ago then we print out the entry
# interesting use of addminutes method
# in using a negative number for time 
# in the past
#
#########################################

Get-EventLog -LogName application | 
where { $_.Timegenerated -ge (Get-Date).addminutes(-60) }