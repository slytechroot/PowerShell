##################################
# GetMultipleServices.ps1
# ed wilson, msft, 6/1/2007
#
# Uses get-service and 
# format-list for output
# uses variable for service name
# uses an array for service name
# uses foreach to iterate through
# services
##################################

$aryService = "EventSystem","RpcSs"

foreach($strService in $aryService)
{
 Write-Host "Service Info for: $strService"
 Get-Service -Name $strService | 
 Format-list *
}