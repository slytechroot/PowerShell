##############################################
# getWmiClassFunction.ps1
# ed wilson, msft, 5/21/2007
#
# uses a commandline argument that accepts a
# wmi class name to print out the properties 
# and methods of the class. 
#
##############################################

function GetClass ($str)
{
 Get-WmiObject -Class $str |
 Get-Member | sort membertype, name |
 format-table name, membertype -AutoSize
 
}

$str = "win32_volume"
getclass($str)
