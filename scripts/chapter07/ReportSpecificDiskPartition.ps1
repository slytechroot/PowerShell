#######################################################
# ReportSpecificDiskPartition.ps1
# ed wilson, msft, 7/17/2007
#
# uses get-wmiobject
# uses win32_diskpartition wmi class
# uses named arguments, param
# uses where-object and match
#
#######################################################

param($computer="localhost",$disk="Disk #0",$help)

if($computer) 
 {
  Write-Host -foregroundcolor green `
  "Querying $computer ..."
  
 }
if($disk) 
 {
  Write-Host -foregroundcolor green `
  "Querying $disk for partition information ..."
  
 }
if($help)
 { "
    ReportSpecificDiskPartition.ps1
	
	DESCRIPTION:
    This script can take a multiple arguments, computer name, 
	drive number and help.
	It will display partition configuration on either a local
	or a remote computer. You can supply either help, drive and
	name of a local or remote machine. 
	
	EXAMPLE:
	ReportSpecificDiskPartition.ps1 -computer remoteComputername
	reports on disk partition on drive 0 on a computer named
	remoteComputerName
	
	ReportSpecificDiskPartition.ps1 -computer remoteComputername -disk 'disk #1'
	reports on disk partition on drive 1 on a computer named
	remoteComputerName
	
	
	ReportSpecificDiskPartition.ps1 -help y
	Prints out the help information seen here.
	
	"
	Exit
 }

Get-WmiObject -Class Win32_DiskPartition `
-computer $computer | Where-Object { $_.name -match $Disk } | 
format-list [a-z]*