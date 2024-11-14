#############################################
# GetWmiAndQuery.ps1
# ed wilson, msft, 5/17/2007
#
# gets a list of all wmi classes
# then filters the list to only selected ones
# then queries the classes
#
#############################################

$strClass = "usb"
Get-WmiObject -List | 
Where { $_.name -like "*$strClass*" } | 
ForEach-Object -begin `
  { 
    Write-Host "$strClass wmi listings"
	Start-Sleep 3
   } `
-Process `
   { 
     Get-wmiObject $_.name 
   }
