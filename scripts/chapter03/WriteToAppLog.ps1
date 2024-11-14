#######################################################
# WriteToApplog.ps1
# ed wilson, msft, 5/27/2007
#
# system.diagnostics.eventlog is .NET framework class
# to allow work with evt log. We check first to see if
# the source is configured to write to the evt log
# if the source is not configured, then we create the 
# new source.
# This script must run with admin rights, to create the
# source. If the source is configured, it will work ok
# non-elevated. 
#########################################################

if(![system.diagnostics.eventlog]::sourceExists("ps_script"))
{
 $strLog = [system.diagnostics.eventlog]::CreateEventSource("ps_script","Application")
}
$strLog = new-object system.diagnostics.eventlog("application",".")
$strLog.source = "ps_script"
$strLog.writeEntry("test from script")

