########################################################
# GetEventLogRetentionPolicy.ps1
# ed wilson, msft, 5/27/2007
#
# uses system.diagnostics.eventlog to retrieve settings
# uses write-host to print out results
# uses new-object to create the eventlog object
# uses $strLog to hold log name
# uses $objLog to hold the eventlog object
#
########################################################
$strLog = "application"
$objLog = New-Object system.diagnostics.eventlog("$strLog")

Write-Host `
 "
 The current settings on the $($objlog.LogDisplayName) file are: 
 max kilobytes: $($objLog.maximumKiloBYtes)
 min retention days: $($objLog.minimumRetentionDays)
 overflow policy: $($objLog.overFlowAction)
"
