###################################################################
# FindCertificatesAboutToExpire.ps1
# ed wilson, msft, 10/5/2007
#
# uses the certificate provider and the cert:\ psdrive
# uses the site class. Uses get-wmiobject 
# uses the -store parameter to look for cert that is about to expire
# uses get-date cmdlet and the adddays() method
#
###################################################################

param(
      $store, 
      $days=30,
      [switch]$listcu,
      [switch]$listlm,
      [switch]$help
     )
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: FindCertificatesAboutToExpire.ps1
Finds certificates about to expire with in a certain
number of days on the local machine 

PARAMETERS: 
-store     the certificate store on the computer
-days      number of days in the future to evaluate for
           certificate expiration
-help      prints help file

SYNTAX:
FindCertificatesAboutToExpire.ps1 

Gets a listing of certificates about to expire within 30 days
in the my store of the currentuser

FindCertificatesAboutToExpire.ps1 -days 45

Gets a listing of certificates about to expire within 45 days
in the my store of the currentuser

FindCertificatesAboutToExpire.ps1 -store "currentuser\my" -days 60

Gets a listing of certificates about to expire within 60 days
in the my store of the currentuser

FindCertificatesAboutToExpire.ps1 -store "currentuser\smartcardroot"

Gets a listing of certificates about to expire within 30 days
in the smartcardroot store of the currentuser

FindCertificatesAboutToExpire.ps1 -listcu

Gets a listing of certificate stores for the
currentuser

FindCertificatesAboutToExpire.ps1 -listlm

Gets a listing of certificate stores for the
localmachine

FindCertificatesAboutToExpire.ps1 -help

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

$currentDate = (Get-Date).adddays($days)
$colcert = Get-ChildItem cert:\$store
Write-host -foregroundcolor cyan "Certificates in $store that" `
                                 "expire in $days days"
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