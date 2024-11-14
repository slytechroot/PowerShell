########################################
# GetNewestLogEntriesAllLogs.ps1
# ed wilson, msft, 5/26/2007
#
# Uses get-eventlog -list to get logs
# Uses get-eventlog to get the most 
# recent log entries. Uses a number
# Uses an array to hold the event logs
########################################


$aryLogs = Get-EventLog -List
$intNew = 5
foreach ($strLog in $aryLogs) 
{
  Write-Host -ForegroundColor green `
        " 
         $($strLog.log) Log Newest $intNew entries 
		"
  Get-EventLog -LogName $strLog.log -newest $intNew

}