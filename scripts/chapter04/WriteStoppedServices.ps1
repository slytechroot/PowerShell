###################################################
# WriteStoppedServices.ps1
# ed wilson, msft, 5/29/2007
#
# uses Get-wmiobject to retrieve win32_Service
# uses select-object for filter
# uses out-file to write the text file
#
####################################################

$strState = "stopped"
$strPath = "C:\FSO\StoppedServices.txt"
Get-WmiObject win32_service -Filter "state='$strState'" |
select-object name | 
Out-File -FilePath $strPath
