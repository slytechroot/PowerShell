####################################################
# FlashingBunny.ps1
# ed wilson, msft, 5/27/2007
#
# Creates an ASCII bunny on the screen in 5 colors
# uses here-string to draw out the bunny
# uses an array of color codes for write-host
# uses foreach statement to loop through the colors
# uses clear-host to clear the screen
# uses start-sleep to pause execution for a second
# 
####################################################

$str = @"
^             ^
  o        o
      =o=
      ! !
"@

$arycolor = "blue","yellow","red","green","magenta"

foreach ($strColor in $aryColor) 
{ 
  Clear-Host
  Write-Host -ForegroundColor $strColor $str
  Start-Sleep -Seconds 1
  Clear-Host
}