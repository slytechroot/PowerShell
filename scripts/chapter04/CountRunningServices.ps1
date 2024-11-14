####################################
# CountRunningServices.ps1
# ed wilson, msft, 5/31/2007
#
# uses get-service, and where-object
# counts the services that have a
# status of running
#
#####################################

(Get-Service | where-object { $_.status -eq "running" }).length