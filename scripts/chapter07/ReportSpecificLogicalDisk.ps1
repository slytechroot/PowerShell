#######################################################
# ReportSpecificLogicalDisk.ps1
# ed wilson, msft, 7/17/2007
#
# uses get-wmiobject
# uses win32_LogicalDisk wmi class
# uses named arguments, param
# uses where-object and match
#
#######################################################

param($computer="localhost",$disk="c:",$help)

if($computer) 
 {
  Write-Host -foregroundcolor green `
  "Querying $computer ..."
  
 }
if($disk) 
 {
  Write-Host -foregroundcolor green `
  "Querying $disk for logical disk information ..."
  
 }
if($help)
 { "
    ReportSpecificLogicalDisk.ps1
	
	DESCRIPTION:
    This script can take a multiple arguments, computer name, 
	drive number and help.
	It will display logical disk configuration on either a local
	or a remote computer. You can supply either help, drive and
	name of a local or remote machine. 
	
	EXAMPLE:
	ReportSpecificLogicalDisk.ps1 -computer remoteComputername
	reports on logical disk on drive c: on a computer named
	remoteComputerName
	
	ReportSpecificLogicalDisk.ps1 -computer remoteComputername -disk 'd:'
	reports on logical disk on drive d: on a computer named
	remoteComputerName
	
	
	ReportSpecificLogicalDiskn.ps1 -help y
	Prints out the help information seen here.
	
	"
	Exit
 }

Get-WmiObject -Class Win32_LogicalDisk `
-computer $computer | Where-Object { $_.deviceID -match $Disk } | 
format-list [a-z]*