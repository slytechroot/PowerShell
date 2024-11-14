####################################################
# GetHalfDuplex.ps1
# ed wilson, msft, 5/27/2007
#
# uses Get-EventLog to retrieve event log msg
# uses where-object for filter
# uses -mattch to use regular expression match to 
# the message portion of the event entry
# uses $strLog to hold log name
# uses $strType to hold type of event log entry
#
####################################################

$strLog = "system"
$strText = "half duplex"
Get-EventLog -LogName $strLog | 
Where-Object { $_.message -match $strText }