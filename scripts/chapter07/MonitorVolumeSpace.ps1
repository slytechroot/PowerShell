######################################################################
# MonitorVolumeSpace.ps1
# ed wilson, msft, 7/18/2007
#
# uses the win32_volume class. Note: only
# on Windows server 2003, vista, and windows Server 2008
# uses an array for comptuer names
# uses foreach statement to walk through the array
# uses get-wmiobject
# uses filter parameter for gwmi
# uses [int] type constraint to force integer
# calculates the percentage
# uses format specifier ( format string) to only display 2 digits 
# "{0:N2}" -f (($free/$capacity)*100)
#
# Uses the funline function. The funline function is in
# the extras folder: underlinefunction.ps1
#
#####################################################################
function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline = $funline + "=" }
   Write-Host -ForegroundColor yellow $strIN 
   Write-Host -ForegroundColor darkYellow $funline
}

$arycomputer = "localhost", "loopback"

foreach($computer in $arycomputer)
{
 $volumeSet = Get-WmiObject -Class win32_volume -computer $computer `
 -filter "drivetype = 3"
 foreach($volume in $volumeSet)
  { 
   $drive=$volume.driveLetter 
   [int]$free=$volume.freespace/1GB
   [int]$capacity=$volume.capacity/1GB
   funline("Drives on $computer computer:")
   "Analyzing  drive $drive $($volume.label) on $($volume.__server)"
   "`t`t Percent free space on drive $drive " +  "{0:N2}" -f `
   (($free/$capacity)*100)
   }
}