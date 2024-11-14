############################################
# SearchWmiAndQueryAndFilter.ps1
# ed wilson, msft, 7/17/2007
#
# queries wmi for wmi classes related to a
# value in $strClass.
# uses where-object to filter out the cim 
# classes
#
##########################################
$obj = 'disk'

Get-WmiObject -List | 
Where-Object { $_.name -match $obj -and $_.name -notmatch "cim"  } | 
foreach-object { $_.name ;Get-WmiObject $_.name }