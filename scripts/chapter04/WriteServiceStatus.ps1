########################################
# WriteServiceStatus.ps1
# ed wilson, msft, 6/1/2007
#
# uses get-service, format-table and
# out-file
#
# gets all services and their status
# useful in dcm
#
########################################

$strPath = "c:\fso\dcm1.txt"
Get-Service | 
format-table name, status -autosize | 
Out-File -FilePath $strPath