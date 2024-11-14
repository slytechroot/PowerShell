####################################################
# EnableSharedFolders.ps1
# ed wilson, msft, 2/21/2007
# 
# uses netsh to configure shared folders
# evaluates return to see if successful
#
###################################################
$errRTN=netsh firewall set service fileAndPrint enable
if($errRTN -match 'ok')
   { Write-Host -ForegroundColor green "Shared folders enabled" }
   ELSEIF($errRTN -match 'requires elevation')
   { Write-Host -ForegroundColor red "Shared folders not enabled" `
     "The operation requries admin rights"}
	ELSE
	 { Write-Host -ForegroundColor red "Shared folders not enabled" `
	   "The error reported was $errRTN" }