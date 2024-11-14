###################################################
# SwitchIPconfig.ps1
# ed wilson, msft, 5/20/2007
#
# captures ipconfig into variable
# uses switch with -wildcard to parse the value 
# uses $switch which is automatic variable for 
# enumerator. It has current property, and movenext
#
####################################################

$a = ipconfig /all 

switch -wildCard ($a) 
 { 
   "*DHCP Server*" { Write-Host $switch.current }
 }