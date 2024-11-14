###################################################################
# SetShareInfo.ps1
# ed wilson, msft, 6/17/2007
#
# assigns values to a share: maxallowed and description
# uses win32_share wmi class. Uses get-wmiobject cmdlet
# this script must be run with admin rights
#
####################################################################

$shareName="'fso'"
$maxAllowed="5"
$description="Test share"
$wmiClass="Win32_share"

$objService=Get-WmiObject -Class $wmiClass -filter "name=$shareName"
$errRTN=$objService.setShareInfo($maxAllowed,$description)

"Set share info completed with a return code of $($errRTN.returnvalue)"