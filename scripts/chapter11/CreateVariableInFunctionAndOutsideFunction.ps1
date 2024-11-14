# CreateVariableInFunctionAndOutsideFunction.ps1
# ed wilson, msft, 8/18/2007
#
# creates a variable $a inside a function called mytest
# this illustrates that the variable ONLY lives inside
# the function. We also create the same variable outside
# the function. 
# When this script is run, this is the result:
#  Inside the mytest function
#  This is a variable in the mytest function
#
#  Outside the function
#  This is a variable created outside the function
# 
######################################################
function mytest
{
 $a = "This is a variable in the mytest function`n"
 Write-Host "Inside the mytest function `n$a"
}

$a = "This is a variable created outside the function`n"
myTest
Write-Host "Outside the function `n$a"