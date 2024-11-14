########################################
# getNewestLogEntries.ps1
# ed wilson, msft, 5/26/2007
#
# Uses get-eventlog to get the most 
# recent log entries. Uses a number
#
########################################

$strLog = "application"
$intNew = 50
Get-EventLog -LogName $strLog -newest $intNew