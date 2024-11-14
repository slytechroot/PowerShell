#############################################################
# CheckAdmin.ps1
# ed wilson, msft, 6/8/2007
#
# determines if person invoking script did so with admin
# rights. This can be pasted to top of scripts needing 
# admin rights to avoid frustration ....
# MAY REQUIRE CONNECTION TO DOMAIN TO DO THIS METHOD>>>
############################################################


$strUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$NTPrincipal = new-object Security.Principal.WindowsPrincipal $strUser
if ($NTPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 
   {
    Write-host -forgroundcolor red "$strUser is not an admin. Exiting..
    start-sleep -seconds 1
    exit
   }
ELSE
  {Write-host "$strUser is an admin. Continuing ...}