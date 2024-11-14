########################################
# QueryMultipleWMIClasses.ps1
# ed wilson, msft, 7/18/2007
# 
# uses wmi searcher class accelerator
# concatenates the query string
#
# uses .net framework class 
# [wmisearcher]
# uses format-list cmdlet
#########################################

$strQuery = "select * from "
$aryClass = "win32_bios","win32_bus"

foreach($class in $aryClass)
{ 
 ([wmisearcher]"$strQuery$class").get() |
 format-list [a-z]*
}
