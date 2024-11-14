#################################################################################
# GetSystemRestoreSettings.ps1
# ed wilson, msft, 8/18/2007
#
# Uses get-wmiobject and the SystemRestoreConfig wmi class
# This class is in the root\default wmi namespace
# uses format-table cmdlet 
# uses a hash table to display calculated values and unique column names in
# the format-table
# uses .NET format specifiers to configure the formatting of the numbers and to
# limit to two decimial places, or to no places after the decimal point.
# uses the new-variable cmdlet and the constant option to create a constant for
# the number of seconds in a day which is 86,400 seconds.
#
#################################################################################
Param($computer = "localhost", $help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetOffLineFiles.ps1 
Prints the offline files config on a local or remote machine.

PARAMETERS: 
-computer Specifies name of the computer upon which to run the script
-help     prints help file

SYNTAX:
GetSystemRestoreSettings.ps1 -computer MunichServer

Lists system restore config on a computer named MunichServer

GetSystemRestoreSettings.ps1 

Lists system restore config on local computer

GetSystemRestoreSettings.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ funline("Obtaining help ...") ; funhelp }

New-Variable -Name SecInDay -option constant -value 86400 
$objWMI = Get-WmiObject -Namespace root\default `
         -Class SystemRestoreConfig -computername $computer
for($i=0; $i -le 15; $i++)
{
 Write-Host -ForegroundColor $i "Retrieving System Restore Settings"
 Start-Sleep -Milliseconds 60
 cls
}

if($computer -eq "localhost")
 { 
  Write-Host "System Restore Settings on $env:computername"
 }
 ELSE
 { 
  Write-Host "System Restore Settings on $computer"
 }

format-table -InputObject $objWMI -property `
  @{
    Label="Max disk utilization" ; 
	expression={  "{0:n0}"-f ($_.DiskPercent ) + " %"} 
	},
  @{
    Label="Scheduled Backup" ; 
	expression={  "{0:n2}"-f ($_.RPGlobalInterval / $SecInDay) + " days"} 
	},
  @{
    Label="Max age of backups" ; 
	expression={ "{0:n2}"-f ($_.RPLifeInterval / $SecInDay) + " days" } 
	}