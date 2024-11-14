#############################################################
# GetDiskPerformance.ps1
# ed wilson, msft, 7/15/2007
#
# uses the wmi class win32_perfrawdata_perfdisk_logicaldisk
# MUST be run with admin rights, or else nothing is shown
#
#############################################################

$numRep = 3
$sleep = 2
$n1=$d1=$n2=$d2=$r1=$r2=$w1=$w2=$null

for ($i=1 ; $i -le $numRep ; $i++)
{
$wmiPerf=Get-WmiObject -class win32_perfrawdata_perfdisk_logicaldisk `
  -Filter "name = '_Total'"
[double]$n1 = $wmiperf.percentIdleTime
[double]$r1 = $wmiperf.percentDiskTime
[double]$d1 = $wmiperf.TimeStamp_Sys100NS

Start-Sleep -Seconds $sleep

$wmiPerf=Get-WmiObject -class win32_perfrawdata_perfdisk_logicaldisk `
  -Filter "name = '_Total'"
[double]$n2 = $wmiperf.percentIdleTime
[double]$r2 = $wmiperf.percentDiskTime
[double]$d2 = $wmiperf.TimeStamp_Sys100NS

"rep $i . counting to rep $numrep ..."

$PercentIdleTime = (1 - (($N2 - $N1)/($D2-$D1)))*100
  "`tPercent Disk idle time is: " + "{0:N2}" -f $PercentIdleTime
$PercentDiskTime = (1 - (($r2 - $r1)/($D2-$D1)))*100
  "`tPercent Disk time is:      " + "{0:N2}" -f $PercentDiskTime
}


