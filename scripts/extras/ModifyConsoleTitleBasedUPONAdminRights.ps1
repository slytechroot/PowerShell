##############################################################################
# modifyConsoleTitleBasedUPONAdminRights.ps1
# ed wilson, msft, 5/21/2007
#
###############################################################################

$strUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$NTPrincipal = new-object Security.Principal.WindowsPrincipal $strUser
if ($NTPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) 
   {[console]::set_Title("$($strUser.name)_Admin")}
ELSE
  {[console]::set_Title("$($strUser.name)_NON_Admin")}