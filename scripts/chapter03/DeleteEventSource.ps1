######################################################
# DeleteEventSource.ps1
# ed wilson, msft, 5/29/2007
#
# uses .net framework to system.diagnostics.eventlog
# class. uses sourceExists and logNameFromSourceName,
# and the DeleteEventSource methods
# Deletes a event log source, but does NOT delete log. 
# 
#######################################################

$source = "ps_script"

if([system.diagnostics.eventlog]::sourceExists($source,"."))
 { 
  $log = [system.diagnostics.eventlog]::LogNameFromSourceName($source,".")
  Write-Host "$source is currently registered with $log log."
  Write-Host -ForegroundColor red "$source will be deleted"
 [system.diagnostics.eventlog]::DeleteEventSource($source)
 }
 ELSE
  { Write-Host -ForegroundColor green "$source is not regisered" }