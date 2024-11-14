###################################################################
# SetShareInfoWithParametersTranslateRtnValue.ps1
# ed wilson, msft, 6/18/2007
#
# assigns values to a share: maxallowed and description
# uses win32_share wmi class. Uses get-wmiobject cmdlet
# this script must be run with admin rights
# uses command line arguments to modify the way the script runs
# the command line arguments are named arguments. In powershell,
# these named arguments are called parameters, and they use the 
# param statement to create them. 
# Uses a function called funLookup to translate the return code 
# from the setShareInfo method call.
#
####################################################################
param($shareName="'fso'", $maxAllowed=5, $description="Test script")

Function funlookup($intIN)
{
 Switch($intIN)
 {
  0  { "Success" }
  2  { "Access denied" }
  8  { "Unknown failure" } 
  9  { "Invalid name" } 
  10 { "Invalid level" } 
  21 { "Invalid parameter" } 
  22 { "Duplicate share" } 
  23 { "Redirected path" } 
  24 { "Unknown device or directory" } 
  25 { "Net name not found" }
  DEFAULT { "$intIN is an Unknown value" }

 }
}

$wmiClass="Win32_share"
$objService=Get-WmiObject -Class $wmiClass -filter "name=$shareName"
$errRTN=$objService.setShareInfo($maxAllowed,$description)

#"Set share info completed with a return code of $($errRTN.returnvalue)"

funLookup($errRTN.returnValue)