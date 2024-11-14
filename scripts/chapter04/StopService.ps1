################################
# StopService.ps1
# ed wilson, msft, 6/1/2007
#
# uses the stop-service cmdlet 
# stops service by using name
#
################################

$strService = "bits"
Stop-Service -Name $strService

