####################################################
# SetWMILogLevel.ps1
# ed wilson, msft, 5/28/2007
#
# uses Get-WMIObject to retrieve win32_WMIsetting
# uses put() to write back to WMI
# Must run with elevated permissions
# if not, it does not error out, but does not change
####################################################


$wmiLog = Get-WmiObject win32_WMISetting
$wmiLog.logginglevel = 2
$wmiLog.put()
