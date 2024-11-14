###################################################
# ExportRunningServices.ps1
# ed wilson, msft, 5/29/2007
#
# uses Get-wmiobject to retrieve win32_Service
# uses select-object for filter
# uses export-csv cmdlet to save as csv

#
####################################################

$strState = "running"
$strPath = "C:\FSO\service.csv"
Get-WmiObject win32_service -Filter "state='$strState'" |
select-object name, startmode, startname | 
Export-Csv -Path $strPath
