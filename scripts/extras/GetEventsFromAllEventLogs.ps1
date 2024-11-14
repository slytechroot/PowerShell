#GetEventsFromAllEventLogs.ps1
# Ed Wilson

$erroractionpreference = "SilentlyContinue"
$error.clear()

clear-host
$colLogs = Get-EventLog -List
foreach ($log in $colLogs) 
  {
   Write-Host $log.logDisplayName "log file" -BackgroundColor "blue"
   Get-EventLog -LogName $log.logDisplayName -newest 5 |
   format-list timeGenerated, eventID, source, message
  }

if ($error.count -ne 0)
   {Write-Host 
    "An error occurred during the operation. Details follow:"
    $error}