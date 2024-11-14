######################################
# ReportLogicalDiskConfiguration.ps1
# ed wilson, msft, 7/17/2007
#
# uses get-wmiobject
# uses win32_LogicalDisk class 
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
    ReportLogicalDiskConfiguration.ps1
	
	DESCRIPTION:
    This script can take a single argument, computer name.
	It will display logical disk configuration on either a local
	or a remote computer. You can supply either a ? or a
	name of a local machine. 
	
	EXAMPLE:
	ReportLogicalDiskConfiguration.ps1 remoteComputerName
	reports on logical disk configuration on a computer named
	remoteComputerName
	
	The script will also display this help file. This is
	done via the ? argument as seen here.
	ReportLogicalDiskConfiguration.ps1 ?
	"
 }

Get-WmiObject -Class Win32_LogicalDisk `
-computer $args