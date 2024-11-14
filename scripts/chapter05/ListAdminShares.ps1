################################################
# ListAdminShares.ps1
# ed wilson, msft, 6/13/2007
#
# uses get-wmiobject and win32_share class
# all admin shares are created with a type code 
# that is greater than 10.
#
################################################

Get-WmiObject win32_share -Filter "type > '10'"