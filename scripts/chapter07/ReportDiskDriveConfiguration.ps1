######################################
# ReportDiskDriveConfiguration.ps1
# ed wilson, msft, 7/17/2007
#
# uses get-wmiobject
# uses win32_DiskDrive class 
# reports default properties
#
#####################################

if(!$args) 
 {
  Write-Host -foregroundcolor green `
  'Querying localhost ...'
  $args = 'localhost' 
 }
if($args -eq "?")
 { "
    ReportDiskDriveConfiguration.ps1
	
	DESCRIPTION:
    This script can take a single argument, computer name.
	It will display drive configuration on either a local
	or a remote computer. You can supply either a ? or a
	name of a local machine. 
	
	EXAMPLE:
	ReportDiskDriveConfiguration.ps1 remoteComputerName
	reports on disk drive configuration on a computer named
	remoteComputerName
	
	The script will also display this help file. This is
	done via the ? argument as seen here.
	ReportDiskDriveConfiguration.ps1 ?
	"
 }

Get-WmiObject -Class Win32_DiskDrive `
-computer $args