#####################################################
# getServiceStatus.ps1
# ed wilson, 5/17/2007
#
# uses get-service to produce a list of service status
# uses sort-object cmdlet to sort the list
# uses foreach to walk through list
# uses if ... else to determine if service is running
# uses write-host to print out color list of status
#
#####################################################

Get-Service | 
Sort-Object status -descending |
foreach {
  if ( $_.status -eq "stopped") 
   {Write-Host $_.name $_.status -ForegroundColor red}
  elseif ( $_.status -eq "running" )
   {Write-Host $_.name $_.status -ForegroundColor green}
  else
   {Write-Host $_.name $_.status -ForegroundColor yellow}
}