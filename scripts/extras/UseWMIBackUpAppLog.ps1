######################################
# UseWMIBackUpAppLog.ps1
# ed wilson, msft, 5/27/2007
#
# uses the win32_nteventlogfile class 
# backed up log is "classic evt"
# not evtx that vista uses
#
########################################

$strLogFile = "application"
$objLog = gwmi win32_nteventlogfile -filter "logfilename like '%$strLogFile%'"
$objlog.backupEventLog("c:\fso\myapplog.evt")







