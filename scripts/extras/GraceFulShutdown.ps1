################################################
# GraceFulShutdown.ps1
# ed wilson, msft, 6/8/2007
#
###############################################

$objService = Get-WmiObject -Class win32_service -Filter "name = 'lanmanserver'"
$objServer = Get-WmiObject -Class win32_operatingsystem 

if ($objService.acceptPause -eq "true") 
 { $objService.pauseService() }

do an event here to check for logon sessions 

then shutdown the server
$objServer.shutdown()


