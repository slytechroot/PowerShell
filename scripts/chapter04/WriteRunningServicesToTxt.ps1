###########################################
# WriteRunningServicesToTxt.ps1
# ed wilson, msft, 5/31/2007
#
# writes list of running of services to txt
# uses get-service, where-object and 
# out-file cmdlet
#
############################################

$strState = "running"
$strPath = "c:\fso\myservice.txt"
Get-Service |
Where-Object { $_.status -eq $strState } | 
Out-File -FilePath $strPath