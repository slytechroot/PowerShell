#########################################################
# QueryRemoteEventLog.ps1
# ed wilson, msft, 10/14/2007
#
# Uses the system.diagnostics.eventlog .net framework 
# class to query a local or remote event log. uses the
# get_entries() method to get the entries of the remote
# or local eventlog. 
#
########################################################

param(
      $computer="localhost", 
      $log="system", 
      $ID, 
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: QueryRemoteEventLog.ps1
Sets a static IP address on a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-log      event log to retrieve <application,system,security>
-id       event log id number to retrieve
-help     prints help file

SYNTAX:
QueryRemoteEventLog.ps1 

Displays message an action is required, and calls help

QueryRemoteEventLog.ps1 -computer MunichServer -log system -id 1002

Lists all the id 1002 events (DHCP lease expired) entries from the system
log on a remote server MunichServer

QueryRemoteEventLog.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

if($help) { funhelp }
if(!$id)   { "missing the ID parameter" ; funhelp }

$objlog = New-Object system.diagnostics.eventLog($Log, $computer)
$objlog.get_entries() | 
Where-object { $_.eventID -eq $id }