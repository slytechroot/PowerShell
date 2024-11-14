########################################################
# ListShares.ps1
# ed wilson, msft, 6/12/2007
#
# uses get-wmiobject cmdlet and win32_share class to
# list information about shares. 
#
########################################################

Get-WmiObject -Class win32_share -ComputerName localhost | 
Sort-Object name | 
Format-Table name, path, description -AutoSize