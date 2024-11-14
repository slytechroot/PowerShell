############################################
# CheckServiceThenStart.ps1
# ed wilson, msft, 6/1/2007
#
# uses get-service to check status of service
# then uses if to see if status is stopped
# if it is stopped, it will start service
# otherwise it prints out service already 
# started
#
###############################################

$strService = "bits"

Get-Service -name $strService |
foreach-object { if ($_.status -ne "running")
{
 Write-Host "starting $strService ..."
 Start-Service -Name $strService
} 
 ELSE
{
 Write-Host "$strService is already started"
}
}