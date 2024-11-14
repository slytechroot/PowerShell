############################################
# ThreeStrings.ps1
# ed wilson, 10/16/2007
# demo working with .NET framework classes
#
############################################

$a = "`$a is a string"
$a
"$a : It is a $($a.gettype())`n"

$b = [string]"`$b is a string"
$b
"$b : It is a $($b.gettype())`n"

$c = [system.string]"`$c is a string"
$c
"$c : It is a $($c.gettype())`n"

"A $($c.gettype()) .NET framwork class has the " `
 + "members" 
$a | get-member