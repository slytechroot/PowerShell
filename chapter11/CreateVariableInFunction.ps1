# CreateVariableInFunction.ps1
# ed wilson, msft, 8/18/2007
#
# creates a variable $a inside a function called mytest
# this illustrates that the variable ONLY lives inside
# the function.
# When this script is run, this is the result:
#   Inside the mytest function
#   This is a variable in the mytest function
#
#   This is  outside the function
# 
######################################################
function mytest
{
 $a = "This is a variable in the mytest function`n"
 Write-Host "Inside the mytest function `n$a"
}

myTest
Write-Host "This is $a outside the function"