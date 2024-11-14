############################################################
# ListSharesDetailed.ps1
# ed wilson, msft, 6/13/2007
#
# uses get-wmiobject to retrieve win32_share class info
# stores properties to retrieve in an array
# uses foreach to walk through the collection of services
# uses foreach to walk through the collection of properties
# uses write-host to write out information
# uses if and notlike to remove empty property values
#
##############################################################
$class = "WIN32_Share"
$computer = "localhost"
$aryProperty ="type", "name", "allowMaximum", "caption", `
  "description", "maximumAllowed", "Path"
$objWMI = Get-WmiObject -Class $class -computername $computer

foreach($share in $objWMI)
{ 
 Write-Host `
 "
 `nProperty values of Share: $($share.name) 
-------------------------
 "
                
  foreach($property in $aryProperty)
   {
    if($share.$property -notlike "")
     {
      Write-Host $property : $share.$property
	 }
   }
}


