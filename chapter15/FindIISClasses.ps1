#########################################################
# FindIISClasses.ps1
# ed wilson, 10/3/2007
#
# finds iis 7 wmi classes based upon the value supplied 
#
########################################################
function funIIS($strIN)
 {
  Get-WmiObject -Namespace root\webadministration -list | 
  where-object { $_.name -match $strIN }
 }

funIIS("site")