##############################################################
# ListSharesDetailedTranslateShareType.ps1
# ed wilson, msft, 6/14/2007
#
# uses get-wmiobject to retrieve win32_share class info
# stores properties to retrieve in an array
# uses foreach to walk through the collection of services
# uses foreach to walk through the collection of properties
# uses write-host to write out information
# uses if and notlike to remove empty property values
# uses a function to translate the share type information
#
##############################################################
Function funLookUp ($intIN) 
{
 switch ($intIN) 
 { 
   0  { $global:strRTN="Disk Drive" }
   1  { $global:strRTN="Print Queue" }
   2  { $global:strRTN="Device" }
   3  { $global:strRTN="IPC " }
   2147483648 { $global:strRTN="Disk Drive Admin" }
   2147483649 { $global:strRTN="Print Queue Admin"}
   2147483650 { $global:strRTN="Device Admin" }
   2147483651 { $global:strRTN="IPC Admin" }
 }
}


$global:strRTN = $null
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
	if($property -eq "type")
	  { 
	   funLookup($share.$property)
	   Write-Host $property "name:" $strRTN
	  }
   }
$Global:strRTN=$null
}