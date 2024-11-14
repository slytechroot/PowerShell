#############################################################
# VersionOfVista.ps1
# ed wilson, msft, 5/21/2007
#
# uses regular expressions to match characters in a string
# uses the regex option of switch statement
# uses the $switch automatic variable and the current property
# uses the net config workstation variable
#
#############################################################
$strPattern = "version"
$text = net config workstation

switch -regex ($text) 
{
  $strPattern { Write-Host $switch.current }
}