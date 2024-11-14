###################################################################
# FindExpiredCertificates.ps1
# ed wilson, msft, 10/4/2007
#
# uses the certificate provider and the cert:\ psdrive
# uses the site class. Uses get-wmiobject 
# uses the -store parameter to look for cert that is expired
# 
###################################################################

param(
      $store, 
      [switch]$listcu,
      [switch]$listlm,
      [switch]$help
     )
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: FindExpiredCertificates.ps1
Finds expired certificates on the local machine 

PARAMETERS: 
-store     the certificate store on the computer
-help      prints help file

SYNTAX:
FindExpiredCertificates.ps1 

Gets a listing of expired certificates in the my store of the
currentuser

FindExpiredCertificates.ps1 -store "currentuser\my"

Gets a listing of expired certificates in the my store of the
currentuser

FindExpiredCertificates.ps1 -store "currentuser\smartcardroot"

Gets a listing of expired certificates in the smartcardtoot store 
of the currentuser

FindExpiredCertificates.ps1 -listcu

Gets a listing of certificate stores for the
currentuser

FindExpiredCertificates.ps1 -listlm

Gets a listing of certificate stores for the
localmachine

FindExpiredCertificates.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)   { "Printing help now..." ; funHelp }
if($listcu) {
             "Certificate stores in currentuser" 
             get-childitem cert:\currentuser ; exit 
            }
if($listlm) {
             "Certificate stores in localmachine" 
             get-childitem cert:\localmachine ; exit 
            }
if(!$store) { 
             $store = "currentuser\my"
             "Using default store: $store" 
             "See $($myinvocation.mycommand) -help" `
             + " for additional examples"
            }

$currentDate = Get-Date
$colcert = Get-ChildItem cert:\$store
Write-host -foregroundcolor cyan "Expired Certificates in $store"
foreach($cert in $colcert)
{
 if($cert.notafter -lt $currentDate)
   {
    Write-host `
      "
       $($cert.thumbprint) `t $($cert.Notafter)
      "
   }
}