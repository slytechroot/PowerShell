# CreateGlobalVariableInFunction.ps1
# ed wilson, msft, 8/18/2007
#
# creates a global variable $a inside a function called mytest
# this illustrates accessing a variable outside
# the function. 
# When this script is run, this is the result:
#  Inside the mytest function
#  This is a variable in the mytest function
#
#  Outside the function
#  This is a variable in the mytest function
# 
######################################################
function mytest
{
 $global:a = "This is a variable in the mytest function`n"
 Write-Host "Inside the mytest function `n$a"
}

myTest
Write-Host "Outside the function `n$a"