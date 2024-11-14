################################
# StartService.ps1
# ed wilson, msft, 6/1/2007
#
# uses the Start-service cmdlet 
# Starts service by using name
#
################################

$strService = "bits"
Start-Service -Name $strService