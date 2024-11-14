######################################################
# CreateEventLog.ps1
# ed wilson, msft, 5/24/2007
#
# uses .net framework to system.diagnostics.eventlog
# class. uses createeventsource method
# Creates the event log, but does NOT write to it. 
# must run elevated
#######################################################
$strProcess = get-WmiObject win32_process | 
  select-object name | out-string
$source = "ps_script"
$log = "PS_Script_Log"

if(![system.diagnostics.eventlog]::sourceExists($source,"."))
 { 
  [system.diagnostics.eventlog]::CreateEventSource($source,$log)
 }
ELSE
 { 
  write-host "$source is already registered with another event Log" 
  EXIT
 }
    

$strLog = new-object system.diagnostics.eventlog($log,".")
$strLog.source = $source
$strLog.writeEntry($strProcess)