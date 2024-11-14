##########################################
# GetSystemErrors.ps1
# ed wilson, msft, 5/23/2007
#
# uses Get-EventLog to retrieve system log
# event entries. chooses only errors
# Unlike MOST powershell cmdlets, the 
# column head in the default output is not
# the required property for entryType
# Have to use Get-Member to find the props
# 
###########################################
Get-EventLog -LogName "system" -Newest 20 | 
where {$_.EntryType -like "error"} | fl *