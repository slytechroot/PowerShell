###################################################
# funline3.ps1
# ed wilson, msft, 8/27/2007
#
# underline function. creates an underline
# that is the same length as the string supplied
# uses "string multiplication" to create the string
#
###################################################
function funline ($strIN)
{
 $strLine= "=" * $strIn.length
 Write-Host -ForegroundColor yellow $strIN 
 Write-Host -ForegroundColor darkYellow $strLine
}

funline("hello there")