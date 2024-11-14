###################################################
# findUSBEvnets.ps1
# ed wilson, msft, 5/26/2007
#
# uses get-eventlog cmdlet to get applog entries
# uses where-object to filter out on source like
# usb. Note when using like * are often required
#
###################################################

Get-EventLog application | 
Where-Object { $_.source -like "*usb*" }