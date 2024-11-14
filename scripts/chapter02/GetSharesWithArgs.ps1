####################################################################
#
# GetSharesWithArgs.ps1
#
# ed wilson, msft, 5/13/2007
#
# Returns listing of shares by type specified
#
####################################################################

if($args)
 {
   $type = $args
   Get-WmiObject win32_share -Filter "type = $type"
 }
ELSE
 {
  Write-Host 
  "
  Using defaults values, file shares type = 0. 
  Other valid types are:
  2147483651 for disk drive admin share
  2147483649 for print queue admin share
  2147483650 for device admin share
  2147483651 for ipc$ admin share
  Example: C;\GetSharesWithArgs.ps1 '2147483651'
  "
  $type = '0'
  Get-WmiObject win32_share -Filter "type = $type"
 }


