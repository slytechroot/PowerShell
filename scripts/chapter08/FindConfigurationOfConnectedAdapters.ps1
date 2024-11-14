#################################################################################
# FindConfigurationOfConnectedAdapters.ps1
# ed wilson, msft, 7/27/2007
#
# Uses TWO wmi classes: win32_networkadapter and win32_networkadapterconfiguration
# The netadapter class has the netconnectionstatus property 
# and the netconfig class has all the protocol information
# the deviceID and the Index fields match in wmi so we use it in the where clause
# uses get-wmiobject, foreach-object
#
#
#################################################################################
$computer="localhost"
$connected=2
Get-WmiObject -Class win32_networkadapter -computername $computer `
-filter "netconnectionstatus = $connected" |
foreach-object `
 {
   Get-WmiObject -Class win32_networkadapterconfiguration `
   -computername $computer -filter "Index = $($_.deviceID)"
 }