#######################################################
# WriteProcessesToApplog.ps1
# ed wilson, msft, 5/27/2007
#
# uses Get-WMIObject to get list of processes
# uses win32_process wmi class
# uses select-object to return only name of process
# uses out-string cmdlet to turn the pipelined object
# into a string, so it can be written to the event log
# system.diagnostics.eventlog is .NET framework class
# to allow work with evt log. We check first to see if
# the source is configured to write to the evt log
# if the source is not configured, then we create the 
# new source.
#
#########################################################


$strProcess = get-WmiObject win32_process | 
select-object name | out-string

if(![system.diagnostics.eventlog]::sourceExists("ps_script","."))
{
 $strLog = [system.diagnostics.eventlog]::CreateEventSource("ps_script","Application")
}
$strLog = new-object system.diagnostics.eventlog("application",".")
$strLog.source = "ps_script"
$strLog.writeEntry($strProcess)