##################################################
# GetLogSources.ps1
# ed wilson, msft, 5/27/2007
#
# uses win32_nteventlogfile class and
# get-wmiobject cmdlet
# filters out on the logfile named app
# uses like in the filter
# foreach prints out the sources property
# of each element in the array that is returned
#
##################################################

$strLog = "application"
Write-Host "The following sources are registered 
for the $strLog log: `n"
Get-WmiObject win32_nteventlogfile -Filter "logfilename like '%$strLog%'" | 
foreach { $_.sources }

