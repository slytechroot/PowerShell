####################################################
# EnableRemoteAdmin.ps1
# ed wilson, msft, 2/21/2007
# 
# uses netsh to configure remoteadmin
# evaluates return to see if successful
#
###################################################
$errRTN=netsh firewall set service remoteAdmin enable
if($errRTN -match 'ok')
   { Write-Host -ForegroundColor green "Remote admin enabled" }
   ELSEIF($errRTN -match 'requires elevation')
   { Write-Host -ForegroundColor red "Remote admin not enabled" `
     "The operation requries admin rights"}
	ELSE
	 { Write-Host -ForegroundColor red "Remote admin not enabled" `
	   "The error reported was $errRTN" }
	