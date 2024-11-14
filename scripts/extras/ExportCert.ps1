##############################################
# ExportCert.ps1
# ed wilson, msft, 5/14/2007
#
# uses the export method from system.security
#
##############################################
$a = Get-childItem cert:\currentUser\my
$a.export("Cert") > c:\a.cer