############################################
# checkStatusWMILog.ps1
# ed wilson, msft, 5/25/2007
#
# uses the wevtutil.exe utility to check
# wevtutil gl gets the log
# status of the wmi diagnostics trace log
# uses switch to parse the log
#
#############################################

$strLog = "Microsoft-Windows-EventLog-WMIProvider/Debug"
switch -wildcard (wevtutil gl $strLog) 
 { 
  "*enabled*" { $switch.Current } 
 }