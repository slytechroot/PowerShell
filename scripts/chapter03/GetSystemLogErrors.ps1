####################################################
# GetSystemLogErrors.ps1
# ed wilson, msft, 5/27/2007
#
# uses Get-EventLog to retrieve event log msg
# uses where-object for filter
# uses -eq to match on entryType of error
# uses $strLog to hold log name
# uses $strType to hold type of event log entry
#
####################################################

$strLog ="system"
$strType="error"

Get-EventLog $strLog | 
Where-Object { $_.entryType -eq $strType }