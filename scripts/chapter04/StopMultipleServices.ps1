###############################
# StopMultipleServices.ps1
# ed wilson, msft, 6/1/2007
#
# 
###############################

$aryServices = "bits", "wuauserv", "CcmExec"
foreach ($strService in $aryServices)
{
 Write-Host "Stopping $strService ..."
 Stop-Service -Name $strService
}

