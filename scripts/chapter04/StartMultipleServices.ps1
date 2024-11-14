###############################
# StartMultipleServices.ps1
# ed wilson, msft, 6/1/2007
#
# 
###############################

$aryServices = "bits", "wuauserv", "CcmExec"
foreach ($strService in $aryServices)
{
 Write-Host "Starting $strService ..."
 Start-Service -Name $strService
}

