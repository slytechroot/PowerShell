###############################################
# SearchAndQueryWMIclasses.ps1
# ed wilson, msft, 7/17/2007
# 
# searches wmi for class names that contain
# the search string. It then will query wmi
# for each of the retrieved wmi classes.
#
# uses get-wmiobject cmdlet, where-object
# foreach-object, and format-list cmdlets
#
###############################################

$wmiNS = "root\cimv2"
$ClassSearch = "processor"
$strPath = "c:\fso\wmitxt.txt"
Get-WmiObject -List -namespace $wmins| 
Where-Object { $_.name -match $classSearch  } | 
foreach-object { "Properties of: $($_.name)" ; Get-WmiObject $_.name } |
Format-List [a-z]* | 
Out-File -FilePath $strPath ; notepad $strPath