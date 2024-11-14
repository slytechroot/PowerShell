######################################################
# FindWMIDriverClasses.ps1
# ed wilson, msft, 8/25/2007
# finds instances of the WMIBinaryMofResource class
# when wmi starts up it trolls registry for drivers
# and creates wmi classes based upon the drivers
# these are stored in the wmi namespace
# uses get-wmiobject, select-object, out-file
# and start-sleep cmdlets
# uses [io.path] .net framework class to create
# a temporary file name in the temporary directory
#
######################################################
$tmpFile1= [io.path]::getTempFileName()
$tmpFile2= [io.path]::getTempFileName()

Get-WmiObject -Class WMIBinaryMofResource -Namespace root\wmi | 
Select-Object name |
Out-File -FilePath $tmpFile1 ; notepad $tmpFile1
Start-Sleep -Seconds 1

Get-WmiObject -list -Namespace root\wmi | 
Out-File -FilePath $tmpFile2 ; notepad $tmpFile2
