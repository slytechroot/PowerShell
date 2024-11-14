#################################################
# countErrors.ps1
# ed wilson, msft, 5/25/2007
#
# counts the errors in the specified event log
#
#################################################
$strLog = "application"
Get-EventLog application |
foreach { if ($_.entryType -eq "error") { $i++ } } 
Write-Host "There are $i errors recorded in the $strLog log"