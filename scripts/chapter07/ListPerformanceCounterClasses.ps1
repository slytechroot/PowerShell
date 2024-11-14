##################################################
# ListPerformanceCounterClasses.ps1
# ed wilson, msft, 7/21/2007
#
# lists performance counter classes in the
# root/cimv2 wmi namespace on the local comptuer
#
#################################################

Param($computer="localhost", $namespace="root\cimv2")

"Querying $computer..."
"Perusing $namespace for performance classes"
$aryClasses = "perfformatteddata","perfrawdata"
foreach($class in $aryClasses)
{
 "Listing $class WMI classes ...`n"
 Get-WmiObject -List -namespace $namespace `
   -computer $computer | 
 Where-Object { $_.name -match $class }
}