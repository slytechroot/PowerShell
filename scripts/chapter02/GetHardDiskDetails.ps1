# ==============================================================================================
# 
# NAME: GetHardDiskDetails.ps1
# 
# AUTHOR: Mred , microsoft
# DATE  : 1/7/2007
# 
# COMMENT: Retrieves information about hard disk size
# 1. illustrates use of: constant, variables, wmi class
#2. uses where object to filter out on only physical disks (disk type 3)
# ==============================================================================================
$aryComputers = "loopback", "localhost"
Set-Variable -name intDriveType -value 3 -option constant #constant for local disk

foreach ($strComputer in $aryComputers)
   
   {"Hard drives on: " + $strComputer
   Get-WmiObject -class win32_logicaldisk -computername $strComputer| 
      where {$_.drivetype -eq $intDriveType}}