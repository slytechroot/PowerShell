#########################################
# findShortWMiClasses.ps1
# ed wilson, msft, 7/18/2007
# 
# finds wmi classes with a short name
#
#######################################


for($i=9 ; $i -le 14 ; $i++)
{
$a=get-wmiobject -List | 
 where { $_.name.length -lt $i -and $_.name -notmatch "cim"}

 $host.UI.WriteDebugLine("The following WMI class names are less than $I in length")
 $a
}

