####################################################
# GetWMILogLevel.ps1
# ed wilson, msft, 5/28/2007
#
# uses Get-WMIObject to retrieve win32_WMIsetting
# uses write-host to print out value
# uses $ and () to print out property
#
####################################################

Write-host "The wmi logging level is: $((Get-WmiObject win32_wmisetting).logginglevel)"