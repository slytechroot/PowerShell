#uses the Get-EventLog cmdlet to retrieve all error messages from
#the last 200 events written to the application log

$strLog = 'application'
Get-EventLog -LogName $strLog -Newest 200 | 
Where-Object { $_.entryType -eq "error" } | 
format-list time, source, eventID, message, data