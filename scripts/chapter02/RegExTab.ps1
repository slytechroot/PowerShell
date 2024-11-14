#############################################################
# RegExTab.ps1
# ed wilson, msft, 5/21/2007
#
# uses regular expressions to match a tab in a text file
# uses the [regex] type accelerator to use regex
# uses the trick to open text file ${filename}
# uses the matches method of the reg expression object
# uses the count property to tell how many matches we have
#
#############################################################
$strPattern = "\t"
$regex = [regex]$strPattern

$text = ${C:\Chapter2\tabline.txt}

$mc = $regex.matches($text)
$mc.count