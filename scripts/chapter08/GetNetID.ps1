##################################################
# GetNetID.ps1
# ed wilson, msft, 7/21/2007
#
##################################################

Get-WmiObject -Class win32_networkadapter |
format-table -Property name, interfaceIndex, `
adapterType, macAddress -autosize