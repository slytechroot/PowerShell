##########################################################
# funline1.ps1
# ed wilson, msft, 7/18/2007
# 
# this function will underline a line of text
# that is supplied to it. It will ONLY underline
# the amount of text that is supplied. The nice 
# thing is that it will expand and contract
# with the amount of text supplied. 
#
# To use you only need to supply a value for $inputText
#
# A simple change could allow it to take $args
#
########################################################
function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

$inputText = "This is a line of text"

funline($inputText)