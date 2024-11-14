##################################################### 
# ArgGetMultipleServices.ps1
# ed wilson, msft 6/5/2007
#
# displays information about service specified
# from cmdline. 
# uses get-service and format-list and write-host
# WIll take multiple or single
# services. Ex:
# C:\ArgGetMultipleServices.ps1 bits lanmanserver"
#
######################################################

$aryService = $args

foreach($strService in $aryService)
{
 Write-Host "Service Info for: $strService"
 Get-Service -Name $strService | 
 Format-list *
}
