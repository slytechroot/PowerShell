#################################################################################
# ListSharesAndPermissions.ps1
# ed wilson, msft, 7/23/2007
#
# uses get-wmiobject to query the win32_share class
# uses foreach-object cmdlet to iterate though the class
# uses the net share command, and feeds the name of the share
# net share without a share name, only lists shares
# net share with a share name, lists also the permissions
#
#
################################################################################# 

Get-WmiObject -class win32_Share -property name| 
foreach-object `
  { 
   net share $_.Name 
  }