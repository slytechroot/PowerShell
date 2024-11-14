##########################################
# getFirstEntry.ps1

(Get-EventLog application)[(Get-eventlog application).length-1] | 
  format-list *