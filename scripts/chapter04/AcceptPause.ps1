##############################################
# AcceptPause.ps1
# ed wilson, msft, 6/8/2007
#
# lists services that accept a pause command
#
#############################################

Get-WmiObject -Class win32_service | 
Where-Object { $_.acceptpause -eq "true" } | 
Select-Object name