##################################
# GetSpecificService.ps1
# ed wilson, msft, 6/1/2007
#
# Uses get-service and 
# format-list for output
# uses variable for service name
#
##################################


$strService = "bits"
Get-Service -Name $strService | 
Format-list *